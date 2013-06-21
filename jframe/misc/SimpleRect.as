package jframe.misc 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Jeff
	 */
	public class SimpleRect extends Sprite
	{
		
		public function SimpleRect(width:int, height:int, _color:uint = 0x332266) 
		{
			this.graphics.beginFill(_color);
			this.graphics.drawRect(0, 0, width, height);
			this.graphics.endFill();
		}
		
	}

}