package jframe.misc 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Jeff
	 */
	public class SimpleSquare extends Sprite
	{
		
		public function SimpleSquare(lenght:int) 
		{
			this.graphics.beginFill(0x556644);
			this.graphics.drawRect(0, 0, lenght, lenght);
			this.graphics.endFill();
		}
		
	}

}