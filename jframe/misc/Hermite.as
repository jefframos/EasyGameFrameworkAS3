package jframe.misc 
{
	import flash.display.Sprite;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Jeff
	 */
	public class Hermite 
	{
		
		public function Hermite() 
		{
			
		}
		public static function makeCurve(beginPoint:Point, finalPoint:Point, firstAnchorPoint:Point, finalAnchorPoint:Point, _container:Sprite):void
		{
			var px:Number = 0;
			var py:Number = 0;
			//_container.graphics.clear()
			//_container.graphics.lineStyle(1, 0x0099ee);
			//_container.graphics.moveTo(beginPoint.x,beginPoint.y)
			for (var t:Number = 0; t < 1; t += .01)
			{
				var t_2:Number = t * t;
				var t_3:Number = t_2 * t;
				
				// some repetitive math for clarity
				px = (2 * t_3 - 3 * t_2 + 1) * beginPoint.x + (t_3 - 2 * t_2 + t) * firstAnchorPoint.x + (-2 * t_3 + 3 * t_2) * finalPoint.x + (t_3 - t_2) * finalAnchorPoint.x;
				py = (2 * t_3 - 3 * t_2 + 1) * beginPoint.y + (t_3 - 2 * t_2 + t) * firstAnchorPoint.y + (-2 * t_3 + 3 * t_2) * finalPoint.y + (t_3 - t_2) * finalAnchorPoint.y;
				
				_container.graphics.lineTo(px,py)
				//canvas.setPixel(px, py, 0xFF0000);
			}
		}
	}

}