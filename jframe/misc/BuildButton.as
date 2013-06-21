package jeff.misc 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	/**
	 * ...
	 * @author ...
	 */
	public class BuildButton 
	{
		
		public function BuildButton() 
		{
			
		}
		public static function build(target:Sprite):void
		{
			target.addEventListener(MouseEvent.ROLL_OVER, rollOver)
			target.addEventListener(MouseEvent.ROLL_OUT, rollOut)
			target.buttonMode = true;
		}
		private static function rollOver(e:MouseEvent):void 
		{
			e.target.transform.colorTransform = new ColorTransform(.8)
		}
		private static function rollOut(e:MouseEvent):void 
		{
			e.target.transform.colorTransform = new ColorTransform()
		}
	}

}