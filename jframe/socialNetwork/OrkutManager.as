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

	public class OrkutManager extends EventDispatcher 
	{
		// ___________________________________________________________________ CONSTANTS
		
		// ___________________________________________________________________ CLASS PROPERTIES
		
		// ___________________________________________________________________ INSTANCE PROPERTIES
		
		private static var _instance									: OrkutManager;
		
		// ___________________________________________________________________ GETTERS AND SETTERS
		
		// ___________________________________________________________________ CONSTRUCTOR
		
		public function OrkutManager (singleton:SingletonObligate) {}
		
		// ___________________________________________________________________ PUBLIC METHODS
		
		public static function getInstance () : OrkutManager
		{
			if (!OrkutManager._instance) OrkutManager._instance = new OrkutManager(new SingletonObligate());
			return OrkutManager(OrkutManager._instance);
		}
		
		public function share(title:String, siteUrl:String, description:String = null, thumbUrl:String = null):void
		{
			var urlVariables:URLVariables = new URLVariables();
			urlVariables.nt = escape("orkut.com");
			urlVariables.tt = title;
			urlVariables.cn = description;
			if (siteUrl)
			{
				urlVariables.du = siteUrl;
			}
			if (thumbUrl)
			{
				urlVariables.tn = thumbUrl;
			}

			var urlRequest:URLRequest = new URLRequest("http://promote.orkut.com/preview");
			urlRequest.method = URLRequestMethod.GET;
			urlRequest.data = urlVariables;
			trace("ORKUT: "+urlRequest.url);
			navigateToURL(urlRequest, "_blank");
		}
		
		// ___________________________________________________________________ PRIVATE METHODS
		
		// ___________________________________________________________________ EVENTS
	}
}

class SingletonObligate {}
