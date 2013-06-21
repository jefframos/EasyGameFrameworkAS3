package jeff.net
{
	import flash.events.Event;
	import flash.events.NetStatusEvent;
	import flash.net.Responder;
	import flash.net.NetConnection;
	import flash.net.ObjectEncoding;
	import flash.events.EventDispatcher;


	/**
	 * ...
	 * @author Tiago Salomon
	 */
	public class ExternalAMFdata extends EventDispatcher
	{
		private var _gateway:String = new String();
		private var _command:String = new String();
		private var _data:Object;
		private var _dataSend:Object;

		public function ExternalAMFdata() {

		}

		public function command(command:String, dataSend:Object = null):void
		{
			this._command = command;
			this._dataSend = dataSend;
			this.initialize();
		}

		private function initialize():void
		{

			var myService:NetConnection = new NetConnection();
			myService.objectEncoding = ObjectEncoding.AMF3;
			myService.connect(this._gateway + "gateway.php");
			myService.addEventListener(NetStatusEvent.NET_STATUS, netStatus)

			var myResponder:Responder = new Responder (onComplete, onStatusError);
			myService.call (this._command, myResponder, this._dataSend);
		}
		
		private function netStatus(e:NetStatusEvent):void 
		{
		}

		private function onComplete(result:Object):void
		{
			this._data = result;
			this.dispatchEvent(new Event(Event.COMPLETE));
		}

		private function onStatusError( pFault:String ):void
		{
			//trace("ExternalAMFdata: STATUS ERROR");
			throw new Error("ExternalAMFdata:  STATUS ERROR");
		}

		/**
		 *
		 * GET AND SET
		 *
		 */
		public function get gateway():String { return _gateway; }

		public function set gateway(value:String):void
		{
			_gateway = value;
		}

		public function get data():Object { return _data; }

		public function set data(value:Object):void
		{
			_data = value;
		}

	}

}

