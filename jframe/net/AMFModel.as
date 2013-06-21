package jeff.net 
{
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	/**
	 * ...
	 * @author Vitor Justin
	 */
	public class AMFModel extends EventDispatcher
	{
		
		/**
		 * Dados da classe.
		 * 
		 * @private
		 */
		private var _data:Object;
		
		/**
		 * Controla o envio e recebimento de dados
		 * para o AMFPHP.
		 * 
		 * @private
		 * 
		 */ 
		private var extAMF:ExternalAMFdata;
		
		public function AMFModel() 
		{
			super(this);
			this.extAMF = new ExternalAMFdata();
		}
		
		public function send(method:String, data:Object):void
		{
			this.extAMF.gateway = "http://www.pinkcats.com.br/2011/amfphp/";
			//this.extAMF.gateway = "http://clientes.box3.com.br/pinkcats_novo/public_html/2011/amfphp/";
			trace( "this.extAMF.gateway : " + this.extAMF.gateway );
			this.extAMF.command(method, data);
			this.extAMF.addEventListener(Event.COMPLETE, this.handleDataSendComplete);
		}
		
		private function handleDataSendComplete(e:Event):void
		{
			this._data = this.extAMF.data;
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public function get data():Object { return this._data; }
		
	}

}