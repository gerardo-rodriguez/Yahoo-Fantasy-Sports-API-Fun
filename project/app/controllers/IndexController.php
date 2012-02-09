<?php
	//-------------------------------------------------
	// Imports
	//-------------------------------------------------

	/**
	 * Admin Index Controller
	 *
	 * The controller for the Admin Index view.
	 *  
	 * @author Gerardo Rodriguez
	 * @created 12/20/2011
	 */
	class IndexController extends Zend_Controller_Action
	{
		//-------------------------------------------------
		// Properties
		//-------------------------------------------------
		private $redirector;
		private $yahooAPI;
		
		public function init() 
		{
			//$this->session_alert = new Zend_Session_Namespace('');
			//$this->Model = new Model();
			
			//Sets alternative layout
			// $this->_helper->layout->setLayout('admin_logged_out');
			
			//Access to helpers
			$this->redirector = $this->_helper->getHelper('Redirector');
			// $this->yahooAPI = $this->_helper->getHelper('YahooFantasyAPI');
		}
		//-------------------------------------------------
		// Public Methods
		//-------------------------------------------------
		public function indexAction()
		{
			// $this->yahooAPI->authenticate();
		}
		
		public function callback()
		{
			// $this->yahooAPI->handleCallback();
		}
		//-------------------------------------------------
		// Private Methods
		//-------------------------------------------------
		
	}
	
?>