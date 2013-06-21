package jframe.samples.playerSample
{
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import jframe.application.AbstractApplication;
	import jframe.application.ApplicationModel;
	import jframe.entity.defaultEntity.DefaultEntity;
	import jframe.graphics.spriteSheet.SpriteSheet;
	import jframe.keyboard.DirectionKey;
	
	/**
	 * ...
	 * @author Jeff
	 */
	public class PlayerSample extends DefaultEntity
	{
		[Embed(source="hugo.png")]
		private var image:Class;
		//private var spriteSheet:SpriteSheet;
		private var movment:DirectionKey;
		private var _playerController:Boolean;
		private var _going:Boolean;
		private var _baseRect:Rectangle;
		private var _jumping:Boolean;
		private var _hurt:Boolean;
		
		public function PlayerSample(_playerController:Boolean)
		{
			super();
			this._playerController = _playerController;
			spriteSheet = new SpriteSheet();
			spriteSheet.setImage(new image);
			spriteSheet.cutImages(52, 70, true)
			build(spriteSheet)
			
			spriteSheet.addAnimation(PlayerAnimations.JUMPING, [19, 20, 21, 22, 23, 24], .06);
			spriteSheet.addAnimation(PlayerAnimations.IDLE, [17, 18], 1);
			spriteSheet.addAnimation(PlayerAnimations.WALK, [5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 0, 1, 2, 3, 4], .03);
			spriteSheet.addAnimation(PlayerAnimations.HURT, [5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 0, 1, 2, 3, 4], .06);
			spriteSheet.addAnimation(PlayerAnimations.FALLING, [25, 25, 26, 26, 27, 28, 29, 30], .04);
			spriteSheet.addEventListener(SpriteSheet.END_ANIMATION, endAnimation);
			spriteSheet.setFrame(17);
			spriteSheet.play(PlayerAnimations.IDLE, true);
			
			if (_playerController)
			{
				movment = new DirectionKey(ApplicationModel.stage);
				movment.addEventListener(DirectionKey.UP, keyHandler)
				movment.addEventListener(DirectionKey.DOWN, keyHandler)
				movment.addEventListener(DirectionKey.LEFT, keyHandler)
				movment.addEventListener(DirectionKey.LEFT_DOWN, keyHandler)
				movment.addEventListener(DirectionKey.LEFT_UP, keyHandler)
				movment.addEventListener(DirectionKey.RIGHT, keyHandler)
				movment.addEventListener(DirectionKey.RIGHT_UP, keyHandler)
				movment.addEventListener(DirectionKey.RIGHT_DOWN, keyHandler)
				movment.addEventListener(DirectionKey.NO_KEY, keyHandler)
				movment.ableWASD = true
				movment.ableArrows = true;
				/**
				 * Velocidade padrão
				 */
				_incressVelocity = new Point(10, 10);
			}
			else
			{
				this.addEventListener(DefaultEntity.MOVE_NOTIFICATION, endGoto);
				_going = true;
				_incressVelocity = new Point(3 * Math.random() + 1, 3 * Math.random() + 1);
			}
			/**
			 * Ajusta velocidades
			 */
			_velocity = new Point();
			
			/**
			 * Ranges de colisão
			 */
			_rangeColision = 30;
			_rangeCenterHit = 20;
			
			/**
			 * cria a base de colisão, serve pra update
			 */
			_baseRect = new Rectangle(0, 0, 40, 10)
			_baseRect.y = 30
			_baseRect.x = -20
			
			/**
			 * Mostra os hits
			 */
			showBase();
			showRange();
			
			/**
			 * Serve para entrar no sort do zindex
			 */
			_autoUpdate = true;
			_updateable = true;
			
			_applyAcceleration = true
			_acceleration = new Point(1, 1)
			
			_jumping = false;
			_hurt = false;
		}
		
		private function endGoto(e:Event):void
		{
			if (_going)
			{
				goto(new Point(this.x + 100), false, true)
				_going = false;
			}
			else
			{
				goto(new Point(this.x - 100), false, true)
				_going = true;
			}
		}		
		protected function addedStage(e:Event):void
		{
			if (!_playerController)
				goto(new Point(this.x - 50), false, true)
		}
		
		protected function keyHandler(e:Event):void
		{
			if (e.type == DirectionKey.DOWN)
			{
				_velocity.y = _incressVelocity.y;
				_velocity.x = 0;
			}
			else if (e.type == DirectionKey.UP)
			{
				_velocity.y = -_incressVelocity.y;
				_velocity.x = 0;
			}
			else if (e.type == DirectionKey.LEFT)
			{
				_velocity.x = -_incressVelocity.x;
				_velocity.y = 0;
			}
			else if (e.type == DirectionKey.RIGHT)
			{
				_velocity.x = _incressVelocity.x;
				_velocity.y = 0;
			}
			else if (e.type == DirectionKey.RIGHT_UP)
			{
				_velocity.y = -_incressVelocity.y;
				_velocity.x = _incressVelocity.x;
			}
			else if (e.type == DirectionKey.LEFT_UP)
			{
				_velocity.y = -_incressVelocity.y;
				_velocity.x = -_incressVelocity.x;
			}
			else if (e.type == DirectionKey.RIGHT_DOWN)
			{
				_velocity.y = _incressVelocity.y;
				_velocity.x = _incressVelocity.x;
			}
			else if (e.type == DirectionKey.LEFT_DOWN)
			{
				_velocity.y = _incressVelocity.y;
				_velocity.x = -_incressVelocity.x;
			}
			else
			{
				_velocity = new Point();
			}
		}
		
		protected function endAnimation(e:Event):void
		{
		
		}
		
		override public function update():void
		{
			trace(_velocity);			
			if (_velocity.x > 0)
				facing = false;
			else if (_velocity.x < 0)
				facing = true;
			
			if (_velocity.x != 0 || _velocity.y != 0)
				playAnimation(PlayerAnimations.WALK);
			else
				playAnimation(PlayerAnimations.IDLE);
			
			move();
		}
		
		public function slow():void
		{
			_virtualVelocity.x = _velocity.x / 2
		}
	}

}