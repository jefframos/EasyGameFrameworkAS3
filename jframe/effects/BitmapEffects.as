package jframe.effects
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import jframe.image.ImageManipulation;
	
	/**
	 * ...
	 * @author Jeff
	 */
	public class BitmapEffects extends Sprite
	{
		static public const END_EXPLOSION:String = "endExplosion";
		private var _arrayParticulas:Vector.<ExplosionParts>;
		private var _pos:Point;
		private var _root:DisplayObject;
		private var _scope:Bitmap;
		
		public function BitmapEffects(scope:Bitmap, _root:DisplayObject)
		{
			_scope = scope;
			_root = _root;
			this.x = _scope.x + _scope.width / 2
			this.y = _scope.y + _scope.height / 2
			_scope.x = -_scope.width / 2
			_scope.y = -_scope.height / 2
		}
		
		public function explosion(numParts:Point = null):void
		{
			if (numParts == null)
				numParts = new Point(2, 2);
			/**
			 * Cortar o bitmap e fazer eles sumirem
			 */
			_arrayParticulas = new Vector.<ExplosionParts>();
			//var numParts:int = 2;
			var _widthPath:int = _scope.width / numParts.x;
			var _heightPath:int = _scope.height / numParts.y;
			var cutRect:Rectangle = new Rectangle(0, 0, _widthPath, _heightPath);
			
			for (var i:int = 0; i < numParts.x; i++)
			{
				for (var j:int = 0; j < numParts.y; j++)
				{
					
					cutRect.x = _widthPath * i;
					cutRect.y = _heightPath * j;
					
					var tempBitData:BitmapData = new BitmapData(_widthPath, _heightPath);
					tempBitData.copyPixels(ImageManipulation.copyBitmap(_scope).bitmapData, cutRect, new Point(0, 0));
					
					var tempBitmap:Bitmap = new Bitmap(tempBitData, "auto", true);
					tempBitmap.x = cutRect.x - _widthPath
					tempBitmap.y = cutRect.y - _heightPath
					tempBitmap.transform.colorTransform = new ColorTransform(Math.random() * .2 + 0.8, Math.random() * .2 + 0.8, Math.random() * .2 + 0.8)
					addChild(tempBitmap)
					_arrayParticulas.push(new ExplosionParts(Math.random() * 1.5 + 0.5, i == 0 ? -2 + Math.random() : 2 + Math.random(), - Math.random() * 2 - 5, tempBitmap));
				}
			}
			this.addEventListener(Event.ENTER_FRAME, explosionLoop)
		}
		
		public function rastro(numParts:Point, velocity:Point):void 
		{
			if (numParts == null)
				numParts = new Point(2, 2);
			/**
			 * Cortar o bitmap e fazer eles sumirem
			 */
			_arrayParticulas = new Vector.<ExplosionParts>();
			//var numParts:int = 2;
			var _widthPath:int = _scope.width / numParts.x;
			var _heightPath:int = _scope.height / numParts.y;
			var cutRect:Rectangle = new Rectangle(0, 0, _widthPath, _heightPath);
			
			for (var i:int = 0; i < numParts.x; i++)
			{
				for (var j:int = 0; j < numParts.y; j++)
				{
					
					cutRect.x = _widthPath * i;
					cutRect.y = _heightPath * j;
					
					var tempBitData:BitmapData = new BitmapData(_widthPath, _heightPath);
					tempBitData.copyPixels(ImageManipulation.copyBitmap(_scope).bitmapData, cutRect, new Point(0, 0));
					
					var tempBitmap:Bitmap = new Bitmap(tempBitData, "auto", true);
					tempBitmap.x = cutRect.x - _widthPath
					tempBitmap.y = cutRect.y - _heightPath
					tempBitmap.transform.colorTransform = new ColorTransform(Math.random() * .2 + 0.8, Math.random() * .2 + 0.8, Math.random() * .2 + 0.8)
					addChild(tempBitmap)
					_arrayParticulas.push(new ExplosionParts(Math.random() * 1 - 0.5, -velocity.x/2,-velocity.y/2, tempBitmap, .1));
				}
			}
			this.addEventListener(Event.ENTER_FRAME, explosionLoop)
		}
		
		private function explosionLoop(e:Event):void
		{
			for (var i:int = 0; i < _arrayParticulas.length; i++)
			{
				var expParts:ExplosionParts = _arrayParticulas[i];
				
				expParts.yVelocity += expParts.gravity;
				expParts.scope.y += expParts.yVelocity;
				expParts.scope.x += expParts.xVelocity;
				expParts.scope.alpha -= expParts.alphaDecress;
				
				if (expParts.scope.alpha <= 0)
				{
					this.removeEventListener(Event.ENTER_FRAME, explosionLoop)
					if(this.parent != null)
						this.parent.removeChild(this)
					
					dispatchEvent(new Event(END_EXPLOSION));
					break;
				}
			}
		
		}
	
	}

}