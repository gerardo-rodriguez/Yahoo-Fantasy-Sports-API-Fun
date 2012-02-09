<?php

// require_once 'Zend/Config/Ini.php';
// require_once 'My/logging.php';

/**
* retrieves and processes social data from Twitter
*/
class Helper_YahooFantasyAPI extends Zend_Controller_Action_Helper_Abstract
{ 

	protected $appConfig;
	protected $localConfig;
	protected $twitterService;
	protected $tiggerSession;
	
	/**
	* Initialize our object
	*/
	public function __construct() 
	{ 
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
	 * public getUserTimelineData - Returns the user timeline with Tweets, RTs (both manual and auto), and @replies.
	 * @param integer $count - The amount of Tweets to return. Default set to 200 (max).
	 * @param boolean $includeRTs - Flag to indicate whether to include retweets.  Defaults to true.
	 * @return $statusArray - An array containing tweets.
	 */
}

?>