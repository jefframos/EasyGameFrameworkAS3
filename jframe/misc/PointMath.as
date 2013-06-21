package jframe.misc
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Jeff
	 */
	public class PointMath
	{
		
		public function PointMath()
		{
		
		}
		/**
		 * Função que retorna um ponto de intersecção se houver
		 * @param	beginRect1 primeiro ponto da primeira reta
		 * @param	endRect1 ponto final da primeira reta
		 * @param	beginRect2 primeiro ponto da segunda reta
		 * @param	endRect2 ponto final da segunda reta
		 * @return retorna o ponto de intersecção, se houver, snão retorna null
		 */
		public static function rectIntersect(beginRect1:Point, endRect1:Point, beginRect2:Point, endRect2:Point):Point
		{
			var det:Number;
			det = (endRect2.x - beginRect2.x) * (endRect1.y - beginRect1.y) - (endRect2.y - beginRect2.y) * (endRect1.x - beginRect1.x);			
			
			if (det == 0.0)
				return null; // não há intersecção
			
			var s:Number = ((endRect2.x - beginRect2.x) * (beginRect2.y - beginRect1.y) - (endRect2.y - beginRect2.y) * (beginRect2.x - beginRect1.x)) / det;
		
			var returnPoint:Point = new Point()
			returnPoint.x = beginRect1.x + (endRect1.x-beginRect1.x)*s;
			returnPoint.y = beginRect1.y + (endRect1.y-beginRect1.y)*s;
			
			return returnPoint; // há intersecção
		}
	
	}

}