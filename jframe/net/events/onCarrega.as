package jeff.net.events 
{
	import flash.events.Event;
	
	public class onCarrega extends Event {
		
		public static const COMPLETO:String = "completo";
		public static const PROGRESSO:String = "progresso";
		public static const ERRO:String = "erro";
		public var retorno:*;
		
		public function onCarrega(type:String, bubbles:Boolean = false, cancelable:Boolean = false, retorno:* = null):void {
			super(type, bubbles, cancelable);
			this.retorno = retorno;
		}
		
		/**
		 * Creates and returns a copy of the current instance.
		 * @return A copy of the current instance.
		 */
		public override function clone():Event {
			return new onCarrega(type, false, false, retorno);
		}
		
		/**
		 * Returns a String containing all the properties of the current
		 * instance.
		 * @return A string representation of the current instance.
		 */
		public override function toString():String {			
			return formatToString("onCarrega", "type", "bubbles", "cancelable", "eventPhase", "retorno");
		}
	}
}