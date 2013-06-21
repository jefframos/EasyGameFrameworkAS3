package jframe.misc
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Jeff
	 */
	public class SimpleCircle extends Sprite
	{
		
		public function SimpleCircle(radius:int, _color:uint = 0x332266)
		{
			this.graphics.beginFill(_color);
			this.graphics.drawCircle(0,0, radius);
			this.graphics.endFill();
		}
	
	}

}