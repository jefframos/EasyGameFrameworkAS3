package com.box3.socialNetwork 
{
	
	/**
	 * ...
	 * 
	 * @usage
	 * ...
	 * 
	 * @author	Sandro Santos
	 */

	import flash.events.EventDispatcher;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;

	public class TwitterManager extends EventDispatcher 
	{
		// ___________________________________________________________________ CONSTANTS
		
		// ___________________________________________________________________ CLASS PROPERTIES
		
		// ___________________________________________________________________ INSTANCE PROPERTIES
		
		private static var _instance									: TwitterManager;
		
		// ___________________________________________________________________ GETTERS AND SETTERS
		
		// ___________________________________________________________________ CONSTRUCTOR
		
		public function TwitterManager (singleton:SingletonObligate) {}
		
		// ___________________________________________________________________ PUBLIC METHODS
		
		public static function getInstance () : TwitterManager
		{
			if (!TwitterManager._instance) TwitterManager._instance = new TwitterManager(new SingletonObligate());
			return TwitterManager(TwitterManager._instance);
		}
		
		public function share(message:String, url:String):void
		{
			var urlVariables:URLVariables = new URLVariables();
			urlVariables.text = message;
			urlVariables.url = url;

			var urlRequest:URLRequest = new URLRequest("http://twitter.com/share");
			urlRequest.method = URLRequestMethod.GET;
			urlRequest.data = urlVariables;
			navigateToURL(urlRequest, "_blank");
		}
		
		// ___________________________________________________________________ PRIVATE METHODS
		
		// ___________________________________________________________________ EVENTS
	}
}

class SingletonObligate {}
