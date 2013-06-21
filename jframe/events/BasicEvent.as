/**
 * ...
 * >author		Sandro Santos
 */

package jframe.events 
{
	
	import flash.events.Event;
	
	public class BasicEvent extends Event 
	{
		// ___________________________________________________________________ CONSTANTS
		
		// ___________________________________________________________________ CLASS PROPERTIES
		
		private var _params												: Array;
		
		// ___________________________________________________________________ INSTANCE PROPERTIES
		
		// ___________________________________________________________________ GETTERS AND SETTERS
		
		public function get params():Array { return _params; }
		
		// ___________________________________________________________________ CONSTRUCTOR
		
		public function BasicEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, params:Array = null)
		{
			_params = params;
			super(type, true, cancelable);
		}
		
		// ___________________________________________________________________ PUBLIC METHODS
		
		// ___________________________________________________________________ PRIVATE METHODS
		
		// ___________________________________________________________________ EVENTS
	}
}

