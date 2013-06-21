package jframe.util
{
	import flash.display.DisplayObject;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Jeff
	 */
	public class PositionUtil
	{
		
		public function PositionUtil()
		{
		
		}
		
		public static function centerByObject(target:DisplayObject, reference:DisplayObject, _incress:Point = null, _pointInCenter:Boolean = false):void
		{
			target.x = reference.x + reference.width / 2 - (_pointInCenter ? 0 : target.width / 2) + (_incress != null ? _incress.x : 0);
			target.y = reference.y + reference.height / 2 - (_pointInCenter ? 0 : target.height / 2) + (_incress != null ? _incress.y : 0);
		}
		
		public static function centerBySize(target:DisplayObject, pointSize:Point, _incress:Point = null, _pointInCenter:Boolean = false):void
		{
			target.x = pointSize.x / 2 - (_pointInCenter ? 0 : target.width / 2) + (_incress != null ? _incress.x : 0);
			target.y = pointSize.y / 2 - (_pointInCenter ? 0 : target.height / 2) + (_incress != null ? _incress.y : 0);
		}
	
	}

}