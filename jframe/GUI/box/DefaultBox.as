package jframe.GUI.box 
{
	import factory.AbstractFactory;
	import factory.IAbstractFactory;
	import flash.display.Sprite;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Jeff
	 */
	public class DefaultBox extends Sprite implements IAbstractFactory
	{
		private var _upState:Sprite;
		private var _overState:Sprite;
		private var _factory:AbstractFactory;
		private var _size:Point;
		public function DefaultBox(factory:AbstractFactory, size:Point) 
		{
			this._size = size;
			this._factory = factory;
			_upState = new _factory.boxFactory.upState;
			
			build();
		}
		
		/* INTERFACE factory.IAbstractFactory */
		
		public function redraw(absFactory:AbstractFactory):void 
		{
			removeChild(_upState);
			this._factory = absFactory;
			_upState = new _factory.boxFactory.upState;
			build();
		}
		
		/* INTERFACE factory.IAbstractFactory */
		
		public function build():void 
		{
			addChild(_upState);
			_upState.width = _size.x;
			_upState.height = _size.y;
		}
		
	}

}