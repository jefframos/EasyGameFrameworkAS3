package jframe.commands.playerCommands
{
	import flash.events.Event;
	import flash.geom.Point;
	import jframe.commands.defaultCommands.AsyncCommand;
	import jframe.entity.defaultEntity.DefaultEntity;
	
	/**
	 * ...
	 * @author Jeff
	 */
	public class MoveCommand extends AsyncCommand
	{
		static public const RIGHT:String = "Right";
		static public const LEFT:String = "Left";
		
		private var _side:String;
		private var _inAction:Boolean = false;
		private var _destiny:Point;
		private var _entity:DefaultEntity;
		
		public function MoveCommand(_entity:DefaultEntity, _destiny:Point)
		{
			this._entity = _entity;
			this._destiny = _destiny;
		}
		
		/**
		 * Atualiza a entidade
		 * @param	e
		 */
		private function updateEntity(e:Event):void
		{
			if (_side == RIGHT)
			{
				if (_entity.x > _destiny.x)
				{
					_entity.clearVelocity();
					onComplete();
				}
			}
			else if (_side == LEFT)
			{
				if (_entity.x < _destiny.x)
				{
					_entity.clearVelocity();
					onComplete();
				}
			}
		}		
		/**
		 * Executa o comando
		 */
		override public function execute():void
		{
			_inAction = true;
			
			if (_entity.x < _destiny.x)
			{
				_entity.moveRight();
				_side = RIGHT;
			}
			else if (_entity.x > _destiny.x)
			{
				_entity.moveLeft();
				_side = LEFT;
			}
			_entity.addEventListener(DefaultEntity.UPDATE, updateEntity)
		}
		
		/**
		 * Complete
		 * @param	e
		 */
		private function onComplete(e:Event = null):void
		{
			_entity.removeEventListener(DefaultEntity.UPDATE, updateEntity)
			if (_inAction)
			{
				trace( "onComplete : " + onComplete );
				complete();
			}
		}
		
		public function get inAction():Boolean
		{
			return _inAction;
		}
		
		public function set inAction(value:Boolean):void
		{
			_inAction = value;
		}
	
	}

}
