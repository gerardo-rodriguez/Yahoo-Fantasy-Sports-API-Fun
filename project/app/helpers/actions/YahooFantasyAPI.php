<?php

// require_once 'Zend/Config/Ini.php';
// require_once 'My/logging.php';

/**
* retrieves and processes fantasy basketball data from yahoo api
*/
class Helper_YahooFantasyAPI extends Zend_Controller_Action_Helper_Abstract
{ 

	protected $appConfig;
	protected $appSession;
	
	/**
	* Initialize our object
	*/
	public function __construct() 
	{ 
		 // path relative to public/index.php location
		$this->appConfig = new Zend_Config_Ini('../app/configs/application.ini', 'production');
		
		$this->appSession = new Zend_Session_Namespace('FantasyApp');
	}
	
	/**
	 * Will inform us if we are authenticated or not by checking for the TWITTER_ACCESS_TOKEN.
	 * @return boolean $isAuthenticated - Will return a boolean representing if the app is ready to go.
	 */
	public function isAuthenticated()
	{
		$isAuthenticated = false;
		
		if( isset($this->appSession->yahooAccessToken) ) { 
			$isAuthenticated = true;
		}
		
		return $isAuthenticated;
	}
	
	/**
	 * Let's authenticate via Oauth
	 */
	public function authenticate()
	{
		// our config details
		$oauthConfig = array(
			// 'siteUrl' => $this->appConfig->yahoo->oauth_url,
			'requestTokenUrl' => $this->appConfig->yahoo->request_token_url,
			'authorizeUrl' => $this->appConfig->yahoo->authorize_url,
			'accessTokenUrl' => $this->appConfig->yahoo->access_token_url,
			'callbackUrl' => $this->appConfig->yahoo->callback_url,
			'consumerKey' => $this->appConfig->yahoo->consumer_key,
			'consumerSecret' => $this->appConfig->yahoo->consumer_secret
		);
		$consumer = new Zend_Oauth_Consumer($oauthConfig);
		
		// fetch a request token
		$token = $consumer->getRequestToken();
		
		// persist the token to storage
		$this->appSession->yahooRequestToken = serialize($token);
		
		// redirect the user
		$consumer->redirect();
	}
	
	/**
	 * Let's finish out authorization via Oauth
	 */
	public function handleCallback()
	{
		// our config details
		$oauthConfig = array(
			// 'siteUrl' => $this->appConfig->yahoo->oauth_url,
			'requestTokenUrl' => $this->appConfig->yahoo->request_token_url,
			'authorizeUrl' => $this->appConfig->yahoo->authorize_url,
			'accessTokenUrl' => $this->appConfig->yahoo->access_token_url,
			'callbackUrl' => $this->appConfig->yahoo->callback_url,
			'consumerKey' => $this->appConfig->yahoo->consumer_key,
			'consumerSecret' => $this->appConfig->yahoo->consumer_secret
		);
		$consumer = new Zend_Oauth_Consumer($oauthConfig);
				
		// Check to make sure that the Request Token has already been established.
		if (!empty($_GET) && isset($this->appSession->yahooRequestToken))
		{
		    $token = $consumer->getAccessToken($_GET, unserialize($this->appSession->yahooRequestToken));

			// Let's keep the Access Token in session, as we'll need it later
    		$this->appSession->yahooAccessToken = serialize($token);

		    // Now that we have an Access Token, we can discard the Request Token
		    //$this->appSession->yahooRequestToken = null;  // NOTE: for some reason Twitter has been sending back the request token more than once per user, and we error out because we have deleted the request token.
			echo 'Way...';
		 } else {
		    // Mistaken request? Some malfeasant trying something?
		    throw new Exception('handleCallback: Invalid callback request. Oops. Sorry.  $_GET is empty or $this->appSession->yahooRequestToken is not set.');
		}
	}
	
	/**
	* public endUserSession - ends the Zend_Twitter_Service session
	*/
	public function endUserSession()
	{
		// $this->setupTwitterService();
		// $this->twitterService->account->endSession();
	}
	
	/**
	 * public getUserTimelineData - Returns the user timeline with Tweets, RTs (both manual and auto), and @replies.
	 * @param integer $count - The amount of Tweets to return. Default set to 200 (max).
	 * @param boolean $includeRTs - Flag to indicate whether to include retweets.  Defaults to true.
	 * @return $statusArray - An array containing tweets.
	 */
}

?>