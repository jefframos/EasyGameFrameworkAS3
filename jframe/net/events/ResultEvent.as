package jeff.net.events
{
	import flash.events.Event;
	
	public class ResultEvent extends Event {
		
		public static const RESULT:String = "result";
		public static const PROGRESS:String = "progress";
		public var result:*;
		
		public function ResultEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, result:* = null):void {
			super(type, bubbles, cancelable);
			this.result = result;
		}
		
		/**
		 * Creates and returns a copy of the current instance.
		 * @return A copy of the current instance.
		 */
		public override function clone():Event {
			return new ResultEvent(type, false, false, result);
		}
		
		/**
		 * Returns a String containing all the properties of the current
		 * instance.
		 * @return A string representation of the current instance.
		 */
		public override function toString():String {
			return formatToString("ResultEvent", "type", "bubbles", "cancelable", "eventPhase", "result");
		}
	}
}