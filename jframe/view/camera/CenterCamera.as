package jframe.view.camera
{
	import com.greensock.TweenNano;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import jframe.entity.defaultEntity.DefaultEntity;
	import jframe.manager.GameManager;
	
	/**
	 * ...
	 * @author ...
	 */
	public class CenterCamera extends EventDispatcher
	{
		static public const MOVE_WORLD:String = "MoveWorld";
		private var _mainContainer:DisplayObject;
		private var _width:int;
		private var _height:int;
		private var _centerObject:DefaultEntity;
		private static var _boundsSprite:Sprite;
		private var _testY:Boolean;
		private var _initWidth:int;
		private var _moveDirection:int;
		private var _noReturnPosX:int;
		private var _testeLeft:Boolean;
		private var _boundsVisible:Boolean;
		
		/**
		 * Construtor padrão
		 * @param	_mainContainer
		 * @param	_width
		 * @param	_height
		 */
		public function CenterCamera()
		{
		}
		
		/**
		 * Cria a camera
		 * @param	_mainContainer
		 * @param	_width
		 * @param	_height
		 * @param	_testY
		 */
		public function build(_mainContainer:DisplayObject, _width:int, _height:int, _testY:Boolean = false, _boundsVisible:Boolean = true):void
		{
			this._boundsVisible = _boundsVisible;
			this._testY = _testY;
			this._height = _height;
			this._width = _width;
			this._mainContainer = _mainContainer;
			this._testeLeft = true;
			_initWidth = _mainContainer.width;
			centerBounds(_width, _height);
		}
		
		/**
		 * @param	width
		 * @param	height
		 */
		private function centerBounds(width:int, height:int):void
		{
			_boundsSprite = new Sprite()
			_boundsSprite.graphics.lineStyle(1, 0, _boundsVisible ? 1 : 0) //(0x326598, .3);
			_boundsSprite.graphics.drawRect(0, 0, width, height);
			
			_boundsSprite.x = GameManager.stage.stageWidth / 2 - _boundsSprite.width / 2;
			_boundsSprite.y = GameManager.stage.stageHeight / 2 - _boundsSprite.height / 2 + 50;
			_mainContainer.stage.addChild(_boundsSprite);
		}
		
		/**
		 * o objeto que fica no centro da camera, tem que ser um objeto do tipo DefaultEntity
		 * @param	_centerObject
		 */
		public function centerObject(_centerObject:DefaultEntity):void
		{
			trace( "centerObject : " + centerObject );
			this._centerObject = _centerObject;
			_mainContainer.x = GameManager.width/2  - _centerObject.getAbsolutePosition().x
			//_mainContainer.x = GameManager.width/2  - _centerObject.x;
			//_mainContainer.y = GameManager.height / 2 - _centerObject.y + 50;
			update();
			updateCam()
		}
		
		/**
		 * Update normal da camera
		 */
		public function updateCam():void
		{
			_centerObject.removeEventListener(DefaultEntity.CAMERA_UPDATE, freezeScreen)
			_centerObject.addEventListener(DefaultEntity.CAMERA_UPDATE, update)
			
			/**
			 * pausa a entidade e a centraliza
			 */
			
			//if (_mainContainer.x > (GameManager.absWidth / 2 - _centerObject.x))
			//{
				//_centerObject.pauseEntity();
				try{
					//TweenNano.to(_mainContainer, .4, { x:GameManager.width / 2 - _centerObject.x, onComplete:function():void { _centerObject.unpauseEntity(); } } );
					TweenNano.to(_mainContainer, .4, { x:GameManager.width / 2 - _centerObject.getAbsolutePosition().x, onComplete:function():void { _centerObject.unpauseEntity(); } } );
					
				}
				catch (err:Error)
				{
					
				}
			//}
		}
		
		/**
		 * Congela a camera
		 */
		public function freezeCam():void
		{
			_noReturnPosX = _mainContainer.x
			_centerObject.removeEventListener(DefaultEntity.CAMERA_UPDATE, update)
			_centerObject.addEventListener(DefaultEntity.CAMERA_UPDATE, freezeScreen)
		}
		
		/**
		 * Camera congelada
		 * @param	e
		 */
		private function freezeScreen(e:Event = null, testY:Boolean = false):void
		{
			var ajust:Boolean = false;
			var _globalPosition:Point = _mainContainer.localToGlobal(new Point(_centerObject.x, _centerObject.y))
			if (_centerObject.velocity.x > 0)
			{
				if (_globalPosition.x + _centerObject.width / 2 > GameManager.width)
				{
					_centerObject.velocity.x = 0;
				}
			}
			if (_centerObject.velocity.x < 0)
			{
				if (_globalPosition.x - _centerObject.width / 2 < 0)
				{
					_centerObject.velocity.x = 0;
				}
			}
			
			if (_centerObject.velocity.y < 0)
			{
				if (_globalPosition.y < _boundsSprite.y)
				{
					ajust = true
				}
			}
			if (_centerObject.velocity.y > 0)
			{
				if (_globalPosition.y > _boundsSprite.y + _boundsSprite.height)
				{
					ajust = true
				}
			}
			if (ajust)
			{
				/**
				 * Não testa o x nesse caso
				 */
				_mainContainer.y -= int(_centerObject.velocity.y)
			}
		}
		
		/**
		 * Atualiza o cenário
		 */
		public function update(e:Event = null):void
		{
			var _globalPosition:Point = _mainContainer.localToGlobal(new Point(_centerObject.x, _centerObject.y))
			var ajust:Boolean = false;
			var calcBounds:Boolean = true
			
			/**
			 * Calcula pelas bounds
			 */
			if (calcBounds)
			{
				/**
				 * FIXME:Alterei aqui _centerObject.virtualVelocity.x por _centerObject.velocity.x
				 * pois sempre pegava a velocidade anterior, devido a ordem dos eventos
				 */
				if (_centerObject.velocity.x > 0)
				{
					if (_globalPosition.x > _boundsSprite.x + _boundsSprite.width)
					{
						_moveDirection = 1
						ajust = true;
					}
				}
				if (_centerObject.velocity.x < 0)
				{
					if (_globalPosition.x < _boundsSprite.x)
					{
						_moveDirection = -1
						ajust = true;
					}
				}
				if (_centerObject.velocity.y < 0)
				{
					if (_globalPosition.y < _boundsSprite.y)
					{
						ajust = true;
					}
				}
				if (_centerObject.velocity.y > 0)
				{
					if (_globalPosition.y > _boundsSprite.y + _boundsSprite.height)
					{
						ajust = true;
					}
				}
				
			}
			
			/**
			 * TODO: Tentar fazer com que a camera trave em um dos lados
			 */
			if ((_mainContainer.x - _centerObject.virtualVelocity.x) > 0 && _centerObject.virtualVelocity.x < 0 && ajust)
				//if ((_noReturnPosX < _mainContainer.x) > 0 && _centerObject.virtualVelocity.x < 0 && ajust)
			{
				/**
				 * Faz o personagem retornar quando chegar no limite da bound
				 * indico que é para o personagem não andar
				 */
				_centerObject.breakMove = true;
				/**
				 * retorna para a posição anterior
				 */
				_mainContainer.x += _centerObject.virtualVelocity.x;
				_centerObject.x -= _centerObject.virtualVelocity.x;
				/**
				 * zera a velocidade
				 */
				_centerObject.velocity = new Point
				calcBounds = false;
				
			}
			else
			{
				/**
				 * indico que o personagem pode andar
				 */
				_centerObject.breakMove = false;
			}
			/**
			 * O bound maximo da camera, é testado pela largura do objeto passado assim que a camera foi inicializada
			 */
			if (_mainContainer.x < GameManager.width - _initWidth && _centerObject.virtualVelocity.x > 0 && ajust)
			{
				
				/**
				 * Faz o personagem retornar quando chegar no limite da bound
				 * indico que é para o personagem não andar
				 */
				_centerObject.breakMove = true;
				/**
				 * retorna para a posição anterior
				 */
				_mainContainer.x += _centerObject.virtualVelocity.x;
				_centerObject.x -= _centerObject.virtualVelocity.x;
				/**
				 * zera a velocidade
				 */
				_centerObject.velocity = new Point
				
				calcBounds = false;
			}
			else
			{
				/**
				 * indico que o personagem pode andar
				 */
				_centerObject.breakMove = false;
			}
			/**
			 *
			 */
			//if (_noReturnPosX < _mainContainer.x && ajust)
			//{
			///**
			//* Faz o personagem retornar quando chegar no limite da bound
			//* indico que é para o personagem não andar
			//*/
			//_centerObject.breakMove = true;
			///**
			//* retorna para a posição anterior
			//*/
			//_mainContainer.x += _centerObject.virtualVelocity.x;
			//_centerObject.x -= _centerObject.virtualVelocity.x;
			///**
			//* zera a velocidade
			//*/
			//_centerObject.velocity = new Point
			//
			//calcBounds = false;
			//}
			/**
			 * Se houver teste em y
			 */
			if (_testY)
			{
				if (_mainContainer.y - _centerObject.velocity.y > 0 && _centerObject.velocity.y < 0)
				{
					_centerObject.velocity = new Point
					calcBounds = false;
				}
				if (_mainContainer.y - _centerObject.velocity.y < GameManager.height - _mainContainer.height)
				{
					_centerObject.velocity = new Point
					calcBounds = false;
				}
			}
			
			/**
			 * Se o objeto em questão saiu dos bounds, meche o cenário relativo a velocidade do vivente
			 */
			if (ajust)
			{
				_mainContainer.x -= int(_centerObject.virtualVelocity.x)
				_mainContainer.y -= int(_centerObject.velocity.y)
				if (_centerObject.virtualVelocity.x != 0)
					dispatchEvent(new Event(MOVE_WORLD));
			}
		
		}
		
		public function destroy():void
		{
			TweenNano.killTweensOf(_centerObject);
			try
			{
				_mainContainer.stage.removeChild(_boundsSprite);
				
			}
			catch (err:Error)
			{
				
			}
		}
		
		static public function get boundsSprite():Sprite
		{
			return _boundsSprite;
		}
		
		public function get moveDirection():int
		{
			return _moveDirection;
		}
		
		public function set testeLeft(value:Boolean):void
		{
			_testeLeft = value;
		}
	
	}

}