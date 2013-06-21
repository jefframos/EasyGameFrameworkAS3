/**
 * ...
 * >author		Sandro Santos
 */

package jframe.events
{

	public class ScreenEvent extends BasicEvent 
	{
		// ___________________________________________________________________ CONSTANTS
		
		public static const SHOW_STARTED								: String = "ScreenEvent_screenEventShowStarted";
		public static const SHOW_FINISHED								: String = "ScreenEvent_screenEventShowFinished";
		public static const HIDE_STARTED								: String = "ScreenEvent_screenEventHideStarted";
		public static const HIDE_FINISHED								: String = "ScreenEvent_screenEventHideFinished";
		
		// ___________________________________________________________________ CLASS PROPERTIES
		
		private var _screenName											: String;
		private var _screenManagerName									: String;
		
		// ___________________________________________________________________ INSTANCE PROPERTIES
		
		// ___________________________________________________________________ GETTERS AND SETTERS
		
		public function get screenName():String { return _screenName; }
		
		public function get screenManagerName():String { return _screenManagerName; }
		
		// ___________________________________________________________________ CONSTRUCTOR
		
		public function ScreenEvent (type:String, screenName:String, screenManagerName:String)
		{
			_screenName = screenName;
			_screenManagerName = screenManagerName;
			super(type, true);
		}
		
		// ___________________________________________________________________ PUBLIC METHODS
		
		// ___________________________________________________________________ PRIVATE METHODS
		
		// ___________________________________________________________________ EVENTS
	}
}

