package jframe.keyboard
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	
	/**
	 * Módulo que mapeia o teclado e dispara eventos conforme a direção que está sendo pressionada, verifica os oito lados possiveis
	 * @author jeffRamos
	 */
	public class DirectionKey extends EventDispatcher
	{
		/**
		 * Constantes das direções
		 */
		static public const LEFT:String = "Left";
		static public const LEFT_DOWN:String = "LeftDown";
		static public const LEFT_UP:String = "LeftUp";
		static public const DOWN:String = "Down";
		static public const RIGHT:String = "Right";
		static public const RIGHT_DOWN:String = "RightDown";
		static public const RIGHT_UP:String = "RightUp";
		static public const UP:String = "Up";
		/**
		 * Constante usada quando não está mais pressionando nenhuma tecla
		 */
		static public const NO_KEY:String = "NoKey";
		/**
		 * Stage
		 */
		private var _stage:Stage;
		/**
		 * Habilita movimento pelas teclas W A S D
		 */
		private var _ableWASD:Boolean;
		/**
		 * Habilita movimento pelas arrows
		 */
		private var _ableArrows:Boolean;
		/**
		 * Array que armazena temporariamente as teclas pressionadas
		 */
		private var _arrayKey:Array = new Array;
		/**
		 * Pausa o envio dos eventos
		 */
		private var _pauseDispatcher:Boolean = false;
		
		public function DirectionKey(_stage:Stage)
		{
			_stage = _stage;
			_stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown)
			_stage.addEventListener(KeyboardEvent.KEY_UP, keyUp)
			_ableArrows = true;
		}
		
		public function forceDispatch():void 
		{
			/**
				 * Verifica a direção através do array de teclas
				 */
				var composedDirection:String = getComposedDirection();
				/**
				 * Dispara o evento indicando qual direçao o personagem deve ir
				 */
				if (!_pauseDispatcher)
					dispatchEvent(new Event(composedDirection))
		}
		
		/**
		 * Key Up, remove a tecla que foi solta, do array de teclas
		 * @param	e
		 */
		private function keyUp(e:KeyboardEvent):void
		{
			var upDirection:String = getDirectionKey(e.keyCode)
			for (var i:int = 0; i < _arrayKey.length; i++)
			{
				if (_arrayKey[i] == upDirection)
					_arrayKey.splice(i, 1);
			}
			/**
			 * Se por um acaso, o array de teclas estiver vazio, pausa o personagem e seu movimento
			 */
			if (_arrayKey.length <= 0)
			{
				if (!_pauseDispatcher)
					dispatchEvent(new Event(NO_KEY))
			}
			
			var composedDirection:String = getComposedDirection();
			if (!_pauseDispatcher)
				dispatchEvent(new Event(composedDirection))
		}
		
		/**
		 * Handler do teclado
		 * @param	e
		 */
		private function keyDown(e:KeyboardEvent):void
		{
			/**
			 * Verifica se o personagem está em movimento, se não estiver verifica a teclae movimenta o personagem
			 */
			var _direction:String = getDirectionKey(e.keyCode);
			if (incressArray(_direction))
			{
				/**
				 * Verifica a direção através do array de teclas
				 */
				var composedDirection:String = getComposedDirection();
				/**
				 * Dispara o evento indicando qual direçao o personagem deve ir
				 */
				if (!_pauseDispatcher)
					dispatchEvent(new Event(composedDirection))
			}
		}
		
		/**
		 * Função que verifica o array de direções e retorna qual direção de fato o jogador está tentando ir
		 * @return
		 */
		private function getComposedDirection():String
		{
			var kUp:Boolean = false;
			var kDown:Boolean = false;
			var kLeft:Boolean = false;
			var kRight:Boolean = false;
			var directionReturn:String = NO_KEY;
			for (var i:int = 0; i < _arrayKey.length; i++)
			{
				switch (_arrayKey[i])
				{
					case UP: 
						if (!kDown)
						{
							kUp = true;
							directionReturn = UP;
						}
						break;
					case LEFT: 
						if (!kRight)
						{
							kLeft = true;
							directionReturn = LEFT;
						}
						break;
					case DOWN: 
						if (!kUp)
						{
							kDown = true;
							directionReturn = DOWN;
						}
						break;
					case RIGHT: 
						if (!kLeft)
						{
							kRight = true;
							directionReturn = RIGHT;
						}
						break;
					default: 
				}
			}
			if (kDown && kRight)
			{
				directionReturn = RIGHT_DOWN;
			}
			if (kUp && kRight)
			{
				directionReturn = RIGHT_UP;
			}
			if (kDown && kLeft)
			{
				directionReturn = LEFT_DOWN;
			}
			if (kUp && kLeft)
			{
				directionReturn = LEFT_UP;
			}
			return directionReturn
		}
		
		/**
		 * Retorna a direção que o personagem tem que andar
		 * @param	keyCode
		 * @return
		 */
		private function getDirectionKey(keyCode:uint):String
		{
			if (_ableArrows)
			{
				switch (keyCode)
				{
					case 37: 
						return LEFT;
						break;
					case 40: 
						return DOWN;
						break;
					case 39: 
						return RIGHT;
						break;
					case 38: 
						return UP;
						break;
				}
			}
			if (_ableWASD)
			{
				switch (keyCode)
				{
					case 65: 
						return LEFT;
						break;
					case 83: 
						return DOWN;
						break;
					case 68: 
						return RIGHT;
						break;
					case 87: 
						return UP;
						break;
				}
			}
			return "null"
		}
		
		/**
		 * Incrementa o array de teclas selecionadas
		 * @param	direction
		 */
		private function incressArray(direction:String):Boolean
		{
			if (direction == "null")
				return false;
			for (var i:int = 0; i < _arrayKey.length; i++)
			{
				if (_arrayKey[i] == direction)
					return false;
			}
			_arrayKey.push(direction);
			return true;
		}
		
		public function set pauseDispatcher(value:Boolean):void
		{
			_pauseDispatcher = value;
		}
		
		public function get pauseDispatcher():Boolean
		{
			return _pauseDispatcher;
		}
		
		public function set ableArrows(value:Boolean):void
		{
			_ableArrows = value;
		}
		
		public function set ableWASD(value:Boolean):void
		{
			_ableWASD = value;
		}
		
		public function get arrayKey():Array 
		{
			return _arrayKey;
		}
	
	}

}