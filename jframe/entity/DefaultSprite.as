package jframe.entity
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author ...
	 */
	public class DefaultSprite extends Sprite
	{
		protected var _updateable:Boolean;
		
		public function DefaultSprite()
		{
			_updateable = false;
		}
		
		/**
		 * Remove o sprite do palco
		 * @return
		 */
		public function kill():Boolean
		{
			if(this.parent != null)
				this.parent.removeChild(this);
			return true;
		
		}
		
		public function getDistance(compareObject:DisplayObject):Number
		{
			return Point.distance(new Point(this.x, this.y), new Point(compareObject.x, compareObject.y));
		}
		
		/**
		 * Update
		 */
		public function update():void
		{
			trace("Override-me");
		}
		
		public function get updateable():Boolean
		{
			return _updateable;
		}
		
		public function set updateable(value:Boolean):void
		{
			_updateable = value;
		}
		
		public function getAbsolutePosition():Point
		{
			return this.parent.localToGlobal(new Point(this.x, this.y))
		}
	
	}

}