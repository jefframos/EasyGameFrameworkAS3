package com.box3.socialNetwork 
{
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	/**
	 * ...
	 * 
	 * @usage
	 * ...
	 * 
	 * @author	Sandro Santos
	 */

	public class FacebookManager extends EventDispatcher 
	{
		// ___________________________________________________________________ CONSTANTS
		
		// ___________________________________________________________________ CLASS PROPERTIES
		
		// ___________________________________________________________________ INSTANCE PROPERTIES
		
		private static var _instance									: FacebookManager;
		
		// ___________________________________________________________________ GETTERS AND SETTERS
		
		// ___________________________________________________________________ CONSTRUCTOR
		
		public function FacebookManager (singleton:SingletonObligate) {}
		
		// ___________________________________________________________________ PUBLIC METHODS
		
		public static function getInstance () : FacebookManager
		{
			if (!FacebookManager._instance) FacebookManager._instance = new FacebookManager(new SingletonObligate());
			return FacebookManager(FacebookManager._instance);
		}
		
		public function sharer(title:String, link:String, description:String = null, thumbURL:String = null):void
		{
			var urlVariables:URLVariables = new URLVariables();
			urlVariables.s = 100;
			urlVariables["p[title]"] = title;
			urlVariables["p[url]"] = link;
			
			if (description && description.length > 0)
			{
				urlVariables["p[summary]"] = description;
			}
			
			if (thumbURL && thumbURL.length > 0)
			{
				urlVariables["p[images][0]"] = thumbURL;
			}
			
			var urlRequest:URLRequest = new URLRequest("http://www.facebook.com/sharer.php");
			urlRequest.method = URLRequestMethod.GET;
			urlRequest.data = urlVariables;
			navigateToURL(urlRequest, "_blank");
		}
		
		// ___________________________________________________________________ PRIVATE METHODS
		
		
		// ___________________________________________________________________ EVENTS
		
	}
}

class SingletonObligate {}
