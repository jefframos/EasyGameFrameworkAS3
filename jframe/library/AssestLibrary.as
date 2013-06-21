package jframe.library
{
	import com.hydrotik.queueloader.QueueLoader;
	import com.hydrotik.queueloader.QueueLoaderEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	/**
	 * ...
	 * @author ...
	 */
	public class AssestLibrary extends EventDispatcher
	{
		private static var _queueLoader:QueueLoader;
		private static var _libraryObject:Object;
		
		/**
		 * Classe estática que carrega objetos e armazena
		 *
		 * Exemplo de uso
		 *
		 * AssestLibrary.load("animas/Player/player.png", "player", completePlayer);
		 *	AssestLibrary.load("imagens/bart.png", "enemy", completeEnemy);
		 *	Abaixo eu envio a callback para o carregamento
		 *	AssestLibrary.load("animas/Fan1/fan1.png", "enemy", completeEnemy);
		 *	AssestLibrary.load("animas/Seguranca/seguranca.png", "security");
		 */
		public function AssestLibrary()
		{
		
		}
		
		/**
		 * Carrega um objeto e coloca da biblioteca de assets
		 * @param	url Url do que deve ser carregado
		 * @param	label Label do objeto, será o nome atributo na libraryObject
		 * @param	callbackComplete Função chamada quando o objeto em questão for carregado, é opcional
		 */
		public static function load(url:String, label:String, callbackComplete:Function = null):void
		{
			_queueLoader = new QueueLoader();
			_queueLoader.addItem(url, null, {name: label, callback: callbackComplete});
			_queueLoader.execute();
			_queueLoader.addEventListener(QueueLoaderEvent.ITEM_PROGRESS, itemProgress);
			_queueLoader.addEventListener(QueueLoaderEvent.ITEM_COMPLETE, itemComplete);
		}
		/**
		 * Evento que mostra o progresso do item
		 * @param	e
		 */
		private static function itemProgress(e:QueueLoaderEvent):void
		{
			//trace(e.info.name, " percent: ", e.queuepercentage * 100, " %");
		}
		
		/**
		 * ao carregar o item
		 * @param	e
		 */
		private static function itemComplete(e:QueueLoaderEvent):void
		{
			if (!_libraryObject)
				_libraryObject = new Object();
			
			_libraryObject[e.info["name"]] = e.content;
			
			if (e.info.callback)
				e.info.callback();
		}
		
		/**
		 * retorna a biblioteca de objetos
		 */
		static public function get libraryObject():Object
		{
			return _libraryObject;
		}
	
	}

}