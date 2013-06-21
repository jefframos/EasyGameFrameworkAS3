package jframe.events 
{
	
	/**
	 * ...
	 * 
	 * @usage
	 * ...
	 * 
	 * @author	Sandro Santos
	 */

	public class ScrollEvent extends BasicEvent 
	{
		// ___________________________________________________________________ CONSTANTS
		
		public static const ENABLED										: String = "com.box3.events_ScrollEvent_ENABLED";
		public static const DISABLED									: String = "com.box3.events_ScrollEvent_DISABLED";
		
		// ___________________________________________________________________ CLASS PROPERTIES
		
		// ___________________________________________________________________ INSTANCE PROPERTIES
		
		// ___________________________________________________________________ GETTERS AND SETTERS
		
		// ___________________________________________________________________ CONSTRUCTOR
		
		public function ScrollEvent (type:String)
		{
			super(type, true);
		}
		
		// ___________________________________________________________________ PUBLIC METHODS
		
		// ___________________________________________________________________ PRIVATE METHODS
		
		// ___________________________________________________________________ EVENTS
	}
}

