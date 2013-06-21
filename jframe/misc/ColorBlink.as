package jframe.misc
{
	import com.greensock.plugins.GlowFilterPlugin;
	import com.greensock.plugins.TweenPlugin;
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import flash.display.DisplayObject;
	
	/**
	 * ...
	 * @author Jeff
	 */
	public class ColorBlink
	{
		private static var object:DisplayObject
		private static var glowObject1:Object
		private static var glowObject2:Object
		private static var time:Number
		
		public function ColorBlink()
		{
		
		}
		
		public static function colorBlink(object:DisplayObject, _glowObject1:Object, _glowObject2:Object, time:Number):void
		{
			
			TweenPlugin.activate([GlowFilterPlugin])
			object = object;
			glowObject1 = _glowObject1;
			glowObject2 = _glowObject2;
			
			glowObject1.color
			
			
			time = time;
			trace( "time : " + time );
			initStep1()
		
		}
		
		static private function initStep1():void
		{
			trace( "glowObject1.color : " + glowObject1.color );
			trace( "glowObject1.color : " + glowObject1.alpha );
			trace( "glowObject1.color : " + glowObject1.blurX );
			trace( "glowObject1.color : " + glowObject1.blurY );
			trace( "glowObject1.color : " + glowObject1.strength );
			trace( "glowObject1.color : " + glowObject1.quality );
			
			TweenMax.to(object, .5, {glowFilter: {color: 0xFFFFFF, alpha: 1, blurX: 10, blurY: 10, strength: 10, quality: 3}});
			//TweenMax.to(object, time, {glowFilter: {color: glowObject1.color, alpha: glowObject1.alpha, blurX: glowObject1.blurX, blurY: glowObject1.blurY, strength: glowObject1.strength, quality: glowObject1.quality}, onComplete: completeStep1})
		}
		
		static private function completeStep1():void
		{
			trace( "completeStep1 : " + completeStep1 );
			TweenMax.to(object, time, {glowFilter: {color: glowObject2.color, alpha: glowObject2.alpha, blurX: glowObject2.blurX, blurY: glowObject2.blurY, strength: glowObject2.strength, quality: glowObject2.quality}, onComplete: initStep1})
		}
		
		public static function breakBlink():void
		{
			TweenMax.killTweensOf(object);
		}
	}

}