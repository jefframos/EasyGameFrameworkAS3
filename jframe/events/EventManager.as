/**
 * ...
 * >author		Sandro Santos
 */

package jframe.events
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	
	public class EventManager
	{
		// ___________________________________________________________________ CONSTANTS
		
		// ___________________________________________________________________ CLASS PROPERTIES
		
		private static var _obj:DisplayObjectContainer;
		private static var _messagesActived:Boolean = true;
		
		// ___________________________________________________________________ INSTANCE PROPERTIES
		
		// ___________________________________________________________________ GETTERS AND SETTERS
		
		public static function get messagesActived():Boolean
		{
			return _messagesActived;
		}
		
		public static function set messagesActived(messagesActived:Boolean):void
		{
			_messagesActived = messagesActived;
		}
		
		// ___________________________________________________________________ CONSTRUCTOR
		
		public function EventManager()
		{
		}
		
		// ___________________________________________________________________ PUBLIC METHODS
		
		public static function init(obj:DisplayObjectContainer):void
		{
			if (!_obj)
			{
				_obj = obj;
			}
		}
		
		public static function dispatchEvent(evt:Event):void
		{
			if (_obj)
			{
				_obj.dispatchEvent(evt);
				
				if (_messagesActived == true)
				{
					showMessages(evt);
				}
			}
		}
		
		public static function removeEventListener(type:String, listener:Function):void
		{
			if (_obj)
			{
				_obj.removeEventListener(type, listener);
			}
		}
		
		public static function addEventListener(type:String, listener:Function):void
		{
			if (_obj)
			{
				_obj.addEventListener(type, listener);
			}
		}
		
		// ___________________________________________________________________ PRIVATE METHODS
		
		private static function showMessages(evt:Event):void
		{
			//if (evt["message"])
			//{
				//trace("[EVENT] " + evt["message"]);
			//}
		}
		// ___________________________________________________________________ EVENTS
	}
}

