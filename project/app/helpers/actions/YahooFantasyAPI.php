<?php

require_once 'Zend/Config/Ini.php';
require_once 'My/logging.php';

/**
* retrieves and processes social data from Twitter
*/
class Helper_YahooFantasyAPI extends Zend_Controller_Action_Helper_Abstract
{ 

	protected $appConfig;
	protected $localConfig;
	protected $twitterService;
	protected $tiggerSession;
	protected $twitterHttpClient;
	protected $logger = NULL;
	protected static $twitterDataArray;
	
	/**
	* Initialize our object
	*/
	public function __construct() 
	{ 
		
		$this->logger = new Logging();
		
		$this->appConfig = new Zend_Config_Ini('../application/configs/application.ini', 'production');
		$this->localConfig = new Zend_Config_Ini('../application/configs/local_environment.ini', 'production');
		
		$this->tiggerSession = new Zend_Session_Namespace('Tigger');
	}
	
	/**
	 * Will inform us if we are authenticated or not by checking for the TWITTER_ACCESS_TOKEN.
	 * @return boolean $isAuthenticated - Will return a boolean representing if the app is ready to go.
	 */
	public function isAuthenticated()
	{
		$isAuthenticated = false;
		
		if( isset($this->tiggerSession->twitterAccessToken) ) { 
			$isAuthenticated = true;
		}
		
		return $isAuthenticated;
	}
	
	/**
	* public getTwitterDataArray - returns contents of static $twitterDataArray
	*/
	public function getTwitterDataArray() { 
		$this->logger->info('TwitterData::getTwitterDataArray() called.');
		
		if (self::$twitterDataArray == NULL) { 
			$this->logger->info('TwitterData::getTwitterDataArray - no data found, so calling $this->getTwitterData()');
			$this->getTwitterData();
		}
		
		$this->logger->info('twitterDataArray:');
		$this->logger->info(print_r(self::$twitterDataArray, 1));
		
		return self::$twitterDataArray;
	}
	
	/**
	 * Let's authenticate via Oauth
	 */
	public function authenticate()
	{
		$this->logger->info('TwitterData::authenticate called.');
		
		// our config details
		$oauthConfig = array(
			'siteUrl' => $this->appConfig->twitter->oauth_url,
			'callbackUrl' => $this->localConfig->twitter->callback_url,
			'consumerKey' => $this->localConfig->twitter->consumer_key,
			'consumerSecret' => $this->localConfig->twitter->consumer_secret
		);
		$consumer = new Zend_Oauth_Consumer($oauthConfig);
		
		// fetch a request token
		$token = $consumer->getRequestToken();
		
		// persist the token to storage
		$this->tiggerSession->twitterRequestToken = serialize($token);
		$this->logger->info('TwitterData::authenticate(): twitterRequestToken saved to session: ' . $this->tiggerSession->twitterRequestToken);
		
		// redirect the user
		$consumer->redirect();
		
	}
	
	/**
	 * Let's finish out authorization via Oauth
	 */
	public function handleCallback()
	{
		$this->logger->info('TwitterData::handleCallback() called.');
		// our config details
		$oauthConfig = array(
			'siteUrl' => $this->appConfig->twitter->oauth_url,
			'callbackUrl' => $this->localConfig->twitter->callback_url,
			'consumerKey' => $this->localConfig->twitter->consumer_key,
			'consumerSecret' => $this->localConfig->twitter->consumer_secret
		);
		$consumer = new Zend_Oauth_Consumer($oauthConfig);
		
		$this->logger->info('handleCallback: $this->tiggerSession->twitterRequestToken = ' . $this->tiggerSession->twitterRequestToken);
		
		// Check to make sure that the Request Token has already been established.
		if (!empty($_GET) && isset($this->tiggerSession->twitterRequestToken))
		{
		    $token = $consumer->getAccessToken($_GET, unserialize($this->tiggerSession->twitterRequestToken));

			// Let's keep the Access Token in session, as we'll need it later
    		$this->tiggerSession->twitterAccessToken = serialize($token);

		    // Now that we have an Access Token, we can discard the Request Token
		    //$this->tiggerSession->twitterRequestToken = null;  // NOTE: for some reason Twitter has been sending back the request token more than once per user, and we error out because we have deleted the request token.
		    
		    $this->logger->info('handleCallback: twitter access token received.');
		    
		 } else {
		    // Mistaken request? Some malfeasant trying something?
		    throw new Exception('handleCallback: Invalid callback request. Oops. Sorry.  $_GET is empty or $this->tiggerSession->twitterRequestToken is not set.');
		    $this->logger->info('handleCallback: Invalid callback request. Oops. Sorry.  $_GET is empty or $this->tiggerSession->twitterRequestToken is not set.');
		}
	}
	
	/**
	* public endUserSession - ends the Zend_Twitter_Service session
	*/
	public function endUserSession()
	{
		$this->setupTwitterService();
		$this->twitterService->account->endSession();
	}
	
	/**
	* public getTwitterData - returns all data in an array
	*/
	public function getTwitterData() { 
		$this->logger->info('getTwitterData() called.');
		if (self::$twitterDataArray == NULL) { 
			$this->logger->info('getTwitterData: $twitterDataArray is empty, retrieving data.');
			self::$twitterDataArray['userTimeline'] = $this->getUserTimelineData();
			self::$twitterDataArray['userFriends'] = $this->getUserFriendsData();
			self::$twitterDataArray['userFollowers'] = $this->getUserFollowersData();
			self::$twitterDataArray['repliesToUser'] = $this->getRepliesToUserData();
			self::$twitterDataArray['tweetsRetweetedByUser'] = $this->getTweetsRetweetedByUserData();	
			self::$twitterDataArray['userReplies'] = $this->getUserRepliesData();
		}
		$this->logger->info('completed populating twitterDataArray:');
		$this->logger->info(print_r(self::$twitterDataArray, 1));
		return self::$twitterDataArray;
		
	}
	
	/**
	 * public getUserTimelineData - Returns the user timeline with Tweets, RTs (both manual and auto), and @replies.
	 * @param integer $count - The amount of Tweets to return. Default set to 200 (max).
	 * @param boolean $includeRTs - Flag to indicate whether to include retweets.  Defaults to true.
	 * @return $statusArray - An array containing tweets.
	 */
	public function getUserTimelineData( $includeRTs = true, $includeReplies = true, $count = 200 )
	{
		$this->logger->info('TwitterData::getUserTimeline called with params: $includeRTs=' . $includeRTs . ', $includeReplies=' . $includeReplies . ', $count=' . $count);
		
		//Twitter API doesn't like me sending in false
		if (!$includeRTs) { 
			$includeRTs = 0;
		}
	
		// make sure we fall between 1 and the max (200).
		if( $count <= 0 ) {
			$count = 1;
		} elseif( $count > 200 ) {
			$count = 200;
		}

		$this->setupTwitterService();
			
		$this->logger->info('getUserTimeline: making Twitter API call');
		
		$data = $this->twitterService->status->userTimeline(array(
			'count' => $count,
			'include_rts' => $includeRTs
		));
		
		$this->logger->info('getUserTimeline Twitter API results:');
		$this->logger->info(print_r($data, 1));
		
		// convert the relavent info to an array
		$statusArray = array();

		if (count($data->status)) { 
			foreach ($data->status as $status) { 
				if (!$includeReplies) { // if we are leaving out replies
					if (!(int)$status->in_reply_to_user_id) { // if we this is not a reply
						$statusItem = array();
						$statusItem['date'] = date('U', strtotime($status->created_at));
						$statusItem['text'] = (string)$status->text;
						$statusArray[] = $statusItem;		
					}
				} else { 
					$statusItem = array();
					$statusItem['date'] = date('U', strtotime($status->created_at));
					$statusItem['text'] = (string)$status->text;
					$statusArray[] = $statusItem;
				}
				
			}
		}
		
		return $statusArray;
	}
	
	/**
	* public getUserTimeline - returns a user timeline array from $twitterDataArray
	*/
	public function getUserTimeline() { 
		$data = $this->getTwitterDataArray();
		$this->logger->info('TwitterData::getUserTimeline() is returning the following:');
		$this->logger->info(print_r($data['userTimeline'], 1));
		return $data['userTimeline'];
	}
	
	/**
	* public getTimestamps - Returns an array of timestamps, matching on getUserTimeline()
	* @return array $dates
	*/
	public function getTimestamps() { 
		$dates = array();
		foreach ($this->getUserTimeline() as $status) { 
			$dates[] = $status['date'];
		}
		return $dates;
	}

	/**
	 * public getUserFriendsData - Uses the Zend_Service_Twitter object to retrieve up to 100 user friends.
	 * @return array $friendsArray - An array containing friend information objects.
	 */
	public function getUserFriendsData()
	{
		$this->logger->info('TwitterData::getUserFriends called.');
		
		$this->setupTwitterService();
		
		$this->logger->info('getUserFriends: making Twitter API call.');
		$data = $this->twitterService->user->friends();

		$this->logger->info('getUserFriends: Twitter API call results:');
		$this->logger->info(print_r($data, 1));

		// convert to an array
		$friendsArray = array();
		foreach ($data->user as $user) { 
			$friendItem = array();
			$friendItem['screen_name'] = (string)$user->screen_name;
			$friendItem['name'] = (string)$user->name;
			$friendItem['profile_image_url'] = (string)$user->profile_image_url;
			$friendsArray[] = $friendItem;
		}
	
		return $friendsArray;
	}
	
	/**
	* pbulic getUserFriends - returns an array of user friends from $twitterDataArray
	*/
	public function getUserFriends() { 
		$data = $this->getTwitterDataArray();
		return $data['userFriends'];
	}
	
	/**
	 * public getUserFollowersData - Uses the Zend_Service_Twitter object to retrieve up to 100 user followers.
	 * @return array $followersArray - An array containing follower information objects.
	 */
	public function getUserFollowersData()
	{
		$this->logger->info('TwitterData::getUserFollowers called.');
	
		$this->setupTwitterService();
		$this->logger->info('getUserFollows: making Twitter API call.');
		$data = $this->twitterService->user->followers();
		
		$this->logger->info(print_r($data, 1));
		
		// convert to an array
		$followersArray = array();
		foreach ($data->user as $user) { 
			$followerItem = array();
			$followerItem['screen_name'] = (string)$user->screen_name;
			$followerItem['name'] = (string)$user->name;
			$followerItem['profile_image_url'] = (string)$user->profile_image_url;
			$followersArray[] = $followerItem;
		}
					
		return $followersArray;
	}
	
	/**
	* public getUserFollowers - returns an array of user followers from $twitterDataArray
	*/
	public function getUserFollowers() { 
		$data = $this->getTwitterDataArray();
		return $data['userFollowers'];
	}
	
	/**
	 * public getRepliesToUserData - Uses the Zend_Service_Twitter object to retrieve the 200 most recent replies to the user
	 * @param $count - The amount of Tweets to return. Default set to 200 (max).
	 * @return array $response - An array containing tweets.
	 */
	public function getRepliesToUserData( $count = 200 )
	{
		$this->logger->info('TwitterData::getRepliesToUser called.');
	
		// make sure we fall between 1 and the max (200).
		if( $count <= 0 ) {
			$count = 1;
		} elseif( $count > 200 ) {
			$count = 200;
		}

		$this->setupTwitterService();
		$this->logger->info('getRepliesToUser: making Twitter API call.');
		$data = $this->twitterService->status->replies(array( // CFC note: the results returned by this call are contrary to documentation.  The documentation indicates that we'll recieve replies FOR our users rather than replies TO our user.
			'count' => $count
		));
		$this->logger->info('getRepliesToUser: results from Twitter API call:');
		$this->logger->info(print_r($data, 1));
		
		// convert the relavent info to an array
		$statusArray = array();
		if (count($data->status)) { 
			foreach ($data->status as $status) { 
				$statusItem = array();
				$statusItem['network'] = 'Twitter';
				$statusItem['id'] = (string)$status->user->id;
				$statusItem['date'] = date('U', strtotime($status->created_at));
				$statusItem['text'] = (string)$status->text;
				$statusArray[] = $statusItem;
			}
		}
		
		return $statusArray;
	}
	
	/**
	* public getRepliesToUser - returns an array of replies to user from $twitterDataArray
	*/
	public function getRepliesToUser() { 
		$data = $this->getTwitterDataArray();
		return $data['repliesToUser'];
	}
	
	/**
	* public getUserRepliesData - Uses the Zend_Service_Twitter object to retrieve the 200 most recent user replies to other tweets
	* @param $count - The amount of Tweets to return
	* @return array $statusArray - an array of tweets
	*/
	public function getUserRepliesData( $count = 200 ) { 
		$this->logger->info('TwitterData::getUserReplies called.');
		// make sure we fall between 1 and the max (200).
		if( $count <= 0 ) {
			$count = 1;
		} elseif( $count > 200 ) {
			$count = 200;
		}

		$this->setupTwitterService();
		$this->logger->info('getUserReplies: making Twitter API call.');
		$data = $this->twitterService->status->userTimeline(array(
			'count' => $count,
			'include_rts' => 0
		));
		$this->logger->info('getUserReplies: results from Twitter API call:');
		$this->logger->info(print_r($data, 1));
		
		// convert the relavent info to an array
		$statusArray = array();
		
		if (count($data->status)) { 
			foreach ($data->status as $status) { 
				if ((int)$status->in_reply_to_user_id) { 
					$statusItem = array();
					$statusItem['network'] = 'Twitter';
					$statusItem['id'] = (string)$status->in_reply_to_user_id;
					$statusItem['date'] = date('U', strtotime($status->created_at));
					$statusItem['text'] = (string)$status->text;
					$statusArray[] = $statusItem;
				}
			}
		}
		
		return $statusArray;
	}
	
	/**
	* public getUserReplies - returns an array of user replies from $twitterDataArray
	*/
	public function getUserReplies() { 
		$data = $this->getTwitterDataArray();
		return $data['userReplies'];
	}
	
	/**
	* public getFriendActivity() - compiles replies to user and user replies
	* @return array $activityArray
	*/
	public function getFriendActivity() { 
		$this->logger->info('TwitterData::getFriendActivity called');
		
		$activityArray = array();
		
		$userReplies = $this->getUserReplies();
		$repliesToUser = $this->getRepliesToUser();
		
		foreach ($userReplies as $status) { 
			$activityArray[] = $status;
		}
		foreach ($repliesToUser as $status) { 
			$activityArray[] = $status;
		}
		$this->logger->info('getFriendActivity results:');
		$this->logger->info(print_r($activityArray, 1));
		
		return $activityArray;
	}
	
	/**
	* public getProfiles - Uses Zend_Twitter_Service and returns an array of names, uids, and image URLs
	* @param array $searchArray - an array of user ids / assumes less than 5 in length
	* @return array $profiles - an array of names, uids, and image URLs
	*/
	public function getProfiles($searchArray) { 
		$this->logger->info('TwitterData::getProfiles called.');
		
		$this->setupTwitterConfig();
		$profilesArray = array();
		foreach ($searchArray as $search) { 
			$this->logger->info('getProfiles: making Twitter API call for user id ' . $search['id']);
			$data = $this->twitterService->user->show($search['id']);
			$this->logger->info('getProfiles: Twitter API call results:');
			$this->logger->info(print_r($data, 1));
			$profile = array();
			$profile['name'] = (string)$data->name;
			$profile['pic'] = (string)$data->profile_image_url;
			$profile['uid'] = (int)$data->id;
			$profilesArray[] = $profile;
		}
		$this->logger->info('getProfiles: results returned:');
		$this->logger->info(print_r($profilesArray, 1));
		
		return $profilesArray;
	}
	
	/**
	 * public getTweetsRetweetedByUserData - Uses Zend_Service_Twitter - Will return Tweets automatically (as opposed to manually) RT'ed by user
	 * @param $count - The amount of Tweets to return. Default set to 100 (max). (https://dev.twitter.com/docs/api/1/get/statuses/retweeted_by_me)
	 * @return array - An associative array of Tweets
	 */
	public function getTweetsRetweetedByUserData( $count = 100 )
	{
		$this->logger->info('TwitterData::getTweetsRetweetedByUser called.');
		
		// make sure we fall between 1 and the max (200).
		if( $count <= 0 ) {
			$count = 1;
		} elseif( $count > 100 ) {
			$count = 100;
		}

		$this->setupTwitterConfig();
		// let the http client know what call to make
		$this->twitterHttpClient->setUri("http://api.twitter.com/1/statuses/retweeted_by_me.xml");
		// pass in any arguments for this api call
		$this->twitterHttpClient->setParameterPost(array(
			'count' => $count
		));

		// let's get some data!!! :D
		$this->logger->info('getTweetsRetweetedByUser: making Twitter API request.');
		$response = $this->twitterHttpClient->request();
		$tweetData = new Zend_Rest_Client_Result($response->getBody());
		$this->logger->info('getTweetsRetweetedByUser: Twitter API returned:');
		$this->logger->info(print_r($tweetData, 1));
		
		// convert the relavent info to an array
		$statusArray = array();
		if (count($tweetData->status)) { 
			foreach ($tweetData->status as $status) { 
				$statusItem = array();
				$statusItem['date'] = date('U', strtotime($status->created_at));
				$statusItem['text'] = (string)$status->text;
				$statusArray[] = $statusItem;
			}
		}
		
		return $statusArray;
	}
	
	/**
	* public getTweetsRetweetedByUser - returns an array of tweets retweeted by user from $twitterDataArray
	*/
	public function getTweetsRetweetedByUser() { 
		$data = $this->getTwitterDataArray();
		return $data['tweetsRetweetedByUser'];
	}
	
	/**
	 * public getAPIStatus - Uses the Zend_Service_Twitter object to retrieve the current Twitter API rate limit status.
	 * @return object $data - An object containg various rate limit information.
	 */
	public function getAPIStatus()
	{
		$this->setupTwitterService();
		$data = $this->twitterService->account->rateLimitStatus();
		
		return $data;
	}

	/**
	 * private setupTwitterService - Will setup our Twitter service to be used throughout this class.
	 */
	private function setupTwitterService()
	{
		$token = unserialize($this->tiggerSession->twitterAccessToken);
				
		$this->twitterService = new Zend_Service_Twitter(array(
			'accessToken' => $token
		));
	}
	
	/**
	 * private setupTwitterConfig - Will setup our twitter configuration object
	 */
	private function setupTwitterConfig()
	{
		// setup our twitter config
		$twitterConfig = array(
			'version' => '1.0', // there is no other version…
			'requestScheme' => Zend_Oauth::REQUEST_SCHEME_HEADER,
			'signatureMethod' => 'HMAC-SHA1',
			'requestTokenUrl' => $this->appConfig->twitter->request_token_url,
			'authorizeUrl' => $this->appConfig->twitter->authorize_url,
			'accessTokenUrl' => $this->appConfig->twitter->access_token_url,
			'callbackUrl' => $this->localConfig->twitter->callback_url,
			'consumerKey' => $this->localConfig->twitter->consumer_key,
			'consumerSecret' => $this->localConfig->twitter->consumer_secret
		);
		
		// let's grab our access token
		$token = unserialize($this->tiggerSession->twitterAccessToken);

		// let's grab our http client to use throughout our api calls
		$this->twitterHttpClient = $token->getHttpClient($twitterConfig);
		// a few minor configs for the http client
		$this->twitterHttpClient->setMethod(Zend_Http_Client::POST);
	}
}

?>