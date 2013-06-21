package jframe.entity.defaultEntity
{
	import adobe.utils.CustomActions;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import jframe.commands.commandList.CommandList;
	import jframe.commands.event.CommandEvent;
	import jframe.commands.playerCommands.MoveCommand;
	import jframe.entity.DefaultSprite;
	import jframe.graphics.spriteSheet.SpriteSheet;
	import jframe.layer.GameLayer;
	
	/**
	 * ...
	 * @author Jeff
	 */
	public class DefaultEntity extends DefaultSprite
	{
		protected var rangeCircle:Sprite;
		//Eventos
		static public const UPDATE:String = "Update";
		static public const CAMERA_UPDATE:String = "CameraUpdate";
		static public const MOVE:String = "Move";
		static public const MOVE_NOTIFICATION:String = "MoveNotification";
		//VelocidadeMáxima permitida
		protected var _maxVelocity:Point;
		//SpriteSheet da entidade
		protected var _spriteSheet:SpriteSheet;
		//Velocidade
		protected var _velocity:Point = new Point;
		//Aceleração
		protected var _acceleration:Point;
		//Aceleração máxima
		protected var _maxAcceleration:Number;
		//Incremento em X que é usado na aceleração
		protected var _incressX:Number = .1;
		//É a velocidade que de fato age, após as alterações na velocidade
		protected var _virtualVelocity:Point;
		//Label da animação atual
		protected var _actualAnimation:String;
		//Incremento da velocidade
		protected var _incressVelocity:Point;
		//Hit da base
		protected var _baseBounds:Rectangle;
		//Hit da entidade
		protected var _hitBounds:Rectangle;
		//Camada que está a entidade
		protected var _layer:GameLayer;
		//se for TRUE, atualiza o ZIndex automaticamente
		protected var _autoUpdate:Boolean;
		//Se vai ser aplicada aceleração
		protected var _applyAcceleration:Boolean = false;
		//Se morreu
		protected var _dead:Boolean;
		//Trava o movimento
		protected var _breakMove:Boolean;
		//Centraliza a imagem no sprite
		protected var _center:Boolean;
		//Range de colisão externo
		protected var _rangeColision:int;
		//Range
		protected var _rangeCenterHit:int;
		//Inverte spritesheet
		protected var _facing:Boolean;
		//CommandList
		protected var _commandList:CommandList;
		protected var _collidable:Boolean;
		protected var _life:int;
		protected var _maxLife:int;
		
		//protected var _lifeBar:LifeBar;
		/**
		 * Entidade padrão, pai de todas
		 */
		public function DefaultEntity()
		{
		}
		
		/**
		 * Constrói a entidade
		 * @param	_spriteSheet
		 */
		public function build(_spriteSheet:SpriteSheet = null):void
		{
			if (_spriteSheet != null)
			{
				this._spriteSheet = _spriteSheet;
				this.addChild(_spriteSheet);
			}
			this._baseBounds = new Rectangle();
			this._velocity = new Point(1, 1);
			this._acceleration = new Point
			this._maxAcceleration = 3;
			this._baseBounds = new Rectangle(0, 0, width, 10);
			this._hitBounds = new Rectangle(0, 0, width, height);
			this._applyAcceleration = false;
			this._virtualVelocity = new Point();
			this._dead = false;
			this._breakMove = false;
			this._maxVelocity = new Point(10, 10)
			this._commandList = new CommandList();
			this._commandList.addEventListener(CommandEvent.FINISH_COMMAND, finishCommand);
		}
		
		/**
		 * Despausa a animação
		 */
		public function unpauseEntity():void
		{
			_spriteSheet.unpause();
		}
		
		/**
		 * Pausa a animação
		 */
		public function pauseEntity():void
		{
			_spriteSheet.pause();
		}
		
		/**
		 * Função que para a animação
		 */
		public function stopAnimation():void
		{
			/**
			 * Para a animação no label e frame atual
			 */
			_spriteSheet.stop(_spriteSheet.labelAtual, 0);
		}
		
		/**
		 * Debug do Range
		 */
		protected function showRange():void
		{
			rangeCircle = new Sprite
			rangeCircle.graphics.lineStyle(1, Math.random() * 0xffffff);
			//rangeCircle.graphics.beginFill(0x659832)
			rangeCircle.graphics.drawCircle(0, 0, _rangeColision)
			this.addChild(rangeCircle)
			//rangeCircle.alpha = 0
			
			var temp2:Sprite = new Sprite
			temp2.graphics.lineStyle(1, Math.random() * 0xffffff);
			temp2.graphics.drawCircle(0, 0, _rangeCenterHit)
			this.addChild(temp2)
		
		}
		
		/**
		 * Debug da base
		 */
		protected function showBase():void
		{
			var temp:Sprite = new Sprite
			temp.graphics.beginFill(0x820102,.3);
			temp.graphics.drawRect(_baseBounds.x, _baseBounds.y, _baseBounds.width, _baseBounds.height)
			this.addChild(temp)
		}
		
		/**
		 *
		 * @param	type
		 */
		public function handlerMovement(type:String, tempVelocity:Point = null):void
		{
			trace("handlerMovement não implementado em ", this)
		}
		
		/**
		 * Debug do Hit
		 */
		protected function showHit():void
		{
			var temp:Sprite = new Sprite
			temp.graphics.beginFill(Math.random() * 0xffffff);
			temp.graphics.drawRect(_hitBounds.x, _hitBounds.y, _hitBounds.width, _hitBounds.height)
			this.addChild(temp)
		}
		
		/**
		 * Função que da o play na animação
		 * @param	_label
		 */
		public function playAnimation(_label:String, repeat:Boolean = true, force:Boolean = false):void
		{
			if (_label != _actualAnimation || force)
			{
				_spriteSheet.setFrame(_spriteSheet.getAnimation(_label)[0])
				_actualAnimation = _label;
				_spriteSheet.play(_label, repeat);
			}
		}
		
		/**
		 * Remove o personagem do palco
		 * @return
		 */
		override public function kill():Boolean
		{
			_dead = true;
			return super.kill();
		}
		
		/**
		 * Desacelera
		 */
		protected function slowDown():void
		{
			if (Math.abs(_velocity.x) > 0)
				this.x += _velocity.x + _acceleration;
			if (Math.abs(_velocity.y) > 0)
				this.y += _velocity.y;
		}
		
		/**
		 *
		 * @param	destiny
		 */
		public function goto(destiny:Point, forceGoto:Boolean = true, notification:Boolean = false):void
		{
			var label:String = MOVE;
			if (notification)
				label = MOVE_NOTIFICATION;
			if (forceGoto)
				this._commandList.killCommands();
			_commandList.add(new MoveCommand(this, destiny), label);
		
		}
		
		/**
		 * Indica que o commando chegou ao fim
		 * @param	e
		 */
		private function finishCommand(e:CommandEvent):void
		{
			if (e.params.label == MOVE_NOTIFICATION)
				dispatchEvent(new Event(MOVE_NOTIFICATION));
		}
		
		/**
		 * Incremento para mover para a esquerda
		 */
		public function moveLeft():void
		{
			_velocity.x = -_incressVelocity.x;
		}
		
		/**
		 * Incremento para mover para a direita
		 */
		public function moveRight():void
		{
			_velocity.x = _incressVelocity.x;
		}
		
		/**
		 * Função de movimentação
		 */
		public function move(_slowDown:Boolean = false):void
		{
			dispatchEvent(new Event(CAMERA_UPDATE));
			
			if (!_applyAcceleration)
			{
				//_acceleration.x = 0;
				_virtualVelocity.x = _velocity.x;
				_virtualVelocity.y = _velocity.y;
			}
			else
			{
				if (_velocity.x > 0)
				{
					_virtualVelocity.x += _acceleration.x;
					if (_virtualVelocity.x > _velocity.x)
						_virtualVelocity.x = _velocity.x;
				}
				else if (_velocity.x < 0)
				{
					_virtualVelocity.x -= _acceleration.x;
					if (_virtualVelocity.x < _velocity.x)
						_virtualVelocity.x = _velocity.x;
				}
				else
					_virtualVelocity.x = 0
				
				if (_velocity.y > 0)
				{
					_virtualVelocity.y += _acceleration.y;
					if (_virtualVelocity.y > _velocity.y)
						_virtualVelocity.y = _velocity.y;
				}
				else if (_velocity.y < 0)
				{
					_virtualVelocity.y -= _acceleration.y;
					if (_virtualVelocity.y < _velocity.y)
						_virtualVelocity.y = _velocity.y;
				}
				else
					_virtualVelocity.y = 0
				
			}
			
			//_acceleration += (_velocity.x < 0) ? _incressX * -1 : _incressX;
			
			//_velocity.x = _virtualVelocity.x;
			//_virtualVelocity.y = _velocity.y;
			
			if (!_breakMove)
			{
				if (Math.abs(_virtualVelocity.x) > 0)
					this.x += _virtualVelocity.x //_velocity.x;
				if (Math.abs(_virtualVelocity.y) > 0)
					this.y += _virtualVelocity.y;
				
			}
			this.x = int(this.x);
			this.y = int(this.y);
			/**
			 * Faz update automaticamento do zIdex a cada atualização
			 */
			if (_layer && _autoUpdate)
			{
				_layer.updateChildZIndex();
			}
			
			dispatchEvent(new Event(UPDATE));
		}
		
		/**
		 * Zera a velocidade
		 */
		public function clearVelocity():void
		{
			_velocity = new Point();
		}
		
		/**
		 * GETTERS AND SETTERS
		 */
		public function get velocity():Point
		{
			return _velocity;
		}
		
		public function set velocity(value:Point):void
		{
			_velocity = value;
		}
		
		public function get incressVelocity():Point
		{
			return _incressVelocity;
		}
		
		public function get baseBounds():Rectangle
		{
			return _baseBounds;
		}
		
		public function get layer():GameLayer
		{
			return _layer;
		}
		
		public function set layer(value:GameLayer):void
		{
			_layer = value;
		}
		
		public function get autoUpdate():Boolean
		{
			return _autoUpdate;
		}
		
		public function set autoUpdate(value:Boolean):void
		{
			_autoUpdate = value;
		}
		
		public function get acceleration():Point
		{
			return _acceleration;
		}
		
		public function get virtualVelocity():Point
		{
			return _virtualVelocity;
		}
		
		public function get dead():Boolean
		{
			return _dead;
		}
		
		public function set dead(value:Boolean):void
		{
			_dead = value;
		}
		
		public function set breakMove(value:Boolean):void
		{
			_breakMove = value;
		}
		
		public function get hitBounds():Rectangle
		{
			return _hitBounds;
		}
		
		public function get center():Boolean
		{
			return _center;
		}
		
		public function get rangeColision():int
		{
			return _rangeColision;
		}
		
		public function get rangeCenterHit():int
		{
			return _rangeCenterHit;
		}
		
		public function get maxVelocity():Point
		{
			return _maxVelocity;
		}
		
		public function get facing():Boolean
		{
			return _facing;
		}
		
		public function set facing(value:Boolean):void
		{
			if (value)
				_spriteSheet.scaleX = -1
			else
				_spriteSheet.scaleX = 1
			_facing = value;
		}
		
		public function get collidable():Boolean 
		{
			return _collidable;
		}
		
		public function set collidable(value:Boolean):void 
		{
			_collidable = value;
		}
		
		public function get spriteSheet():SpriteSheet 
		{
			return _spriteSheet;
		}
		
		public function set spriteSheet(value:SpriteSheet):void 
		{
			_spriteSheet = value;
		}
		
		public function set incressVelocity(value:Point):void 
		{
			_incressVelocity = value;
		}
	}

}