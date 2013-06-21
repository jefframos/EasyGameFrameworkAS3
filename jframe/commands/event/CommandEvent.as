package jframe.commands.event 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author Jeff
	 */
	public class CommandEvent extends Event
	{
		private var _params:Object;
		public static const FINISH_QUEUE:String = "FinishQueue";
		public static const FINISH_COMMAND:String = "FinishCommand";
		
		public function CommandEvent(type:String, obj:Object = null) 
		{
			_params = obj;
			super(type)
		}
		
		public function get params():Object { return _params; }
		
		public function set params(value:Object):void 
		{
			_params = value;
		}
		
	}

}