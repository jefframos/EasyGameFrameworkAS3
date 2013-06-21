package jframe.view.paralax
{
	import com.greensock.TweenNano;
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import imagePackage.ImageManipulation;
	import jframe.layer.GameLayer;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Paralax extends Sprite
	{
		private var _arrayParalaxChilds:Array;
		private var _mainContainer:DisplayObject;
		
		public function Paralax(_mainContainer:DisplayObject)
		{
			this._mainContainer = _mainContainer;
		}
		
		/**
		 * Envia um objeto e cria e replica eles pra montar um paralax
		 * @param	displayObject
		 * @param	force
		 */
		public function generateLayer(displayObject:DisplayObject, force:Number = 1, _spacing:int = 0):void
		{
			/**
			 * TODO:Embutir o cálculo do espaçamento
			 */
			var numElements:int = Math.round(_mainContainer.width * force / displayObject.width);
			var containerBitmap:Sprite = new Sprite();
			for (var i:int = 0; i < numElements; i++)
			{
				var tempBitmap:Bitmap = ImageManipulation.displayObjectToBitmap(displayObject);
				tempBitmap.x = containerBitmap.width
				tempBitmap.y = displayObject.y
				containerBitmap.addChild(tempBitmap);
			}
			
			addParalaxChild(containerBitmap, force);
		}
		
		/**
		 *
		 */
		public function destroy():void
		{
			for (var i:int = 0; i < _arrayParalaxChilds.length; i++) 
			{
				var item:DisplayObject = _arrayParalaxChilds[i].displayObject;
				item.parent.removeChild(item)
			}
			_arrayParalaxChilds = new Array();
		}
		
		/**
		 *
		 * @param	child
		 * @param	force
		 */
		public function addParalaxChild(child:DisplayObject, force:Number = 1):void
		{
			if (!_arrayParalaxChilds)
				_arrayParalaxChilds = new Array();
			_arrayParalaxChilds.push({displayObject: child, force: force})			
			super.addChild(child);
		}
		
		public function update(side:Number):void
		{
			if (side)
				for each (var item:Object in _arrayParalaxChilds)
				{
					var tempForce:Number = side > 0 ? -1 : 1
					TweenNano.to(item.displayObject, .1, {x: item.displayObject.x + item.force * tempForce});
				}
		
		}
	}

}