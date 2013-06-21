package jframe.GUI.window
{
	import com.greensock.plugins.AutoAlphaPlugin;
	import com.greensock.plugins.TweenPlugin;
	import com.greensock.TweenLite;
	import com.greensock.TweenNano;
	import factory.IAbstractFactory;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import jframe.factory.IAbstractFactory;
	
	/**
	 * ...
	 * @author Jeff
	 */
	public class DefaultWindow extends Sprite implements IAbstractFactory
	{
		static public const WINDOW_CENTER:String = "windowCenter";
		static public const CLOSE_WINDOW:String = "closeWindow";
		static public const OPEN_WINDOW:String = "openWindow";
		static public const HIDE_WINDOW:String = "hideWindow";
		protected var _upState:Sprite;
		protected var _factory:AbstractFactory;
		protected var _size:Point;
		protected var _closeButton:DefaultButton;
		protected var _background:Shape;
		protected var _buttonPos:Point;
		protected var _windowPosition:String;
		
		public function DefaultWindow(factory:AbstractFactory, closeButton:DefaultButton, size:Point, windowPosition:String = "", buttonPos:Point = null)
		{
			this._windowPosition = windowPosition;
			if (_windowPosition == "")
				_windowPosition = WINDOW_CENTER;
			this._buttonPos = buttonPos;
			this._closeButton = closeButton;
			this._size = size;
			
			this._factory = factory;
			build();
			TweenPlugin.activate([AutoAlphaPlugin]);
			
			hide();
		}
		
		private function clickClose(e:MouseEvent):void
		{
			dispatchEvent(new Event(CLOSE_WINDOW));
			hide();
		}
		
		public function show():void
		{
			dispatchEvent(new Event(OPEN_WINDOW));
			TweenLite.to(this, .2, {autoAlpha: 1});
		}
		
		public function hide(force:Boolean = false):void
		{
			dispatchEvent(new Event(HIDE_WINDOW));
			if (force)
			{
				this.alpha = 0;
				this.visible = false;
			}
			else
				TweenLite.to(this, .2, {autoAlpha: 0});
		}
		
		public function redraw(absFactory:AbstractFactory):void
		{
			this._factory = absFactory;
			this._closeButton.redraw(_factory);
			if (_upState.stage)
				removeChild(_upState);
			if (_closeButton.stage)
				removeChild(_closeButton);
			for (var i:int = 0; i < this.numChildren; i++)
			{
				if (this.getChildAt(i) is IAbstractFactory)
					IAbstractFactory(this.getChildAt(i)).redraw(absFactory)
			}
			if (_background.stage)
				removeChild(_background);
			build();
		}
		
		public function build():void
		{
			
			_upState = new _factory.windowFactory.upState;
			
			if (_factory.windowFactory.backColor >= 0)
			{
				_background = new Shape();
				_background.graphics.beginFill(_factory.windowFactory.backColor, _factory.windowFactory.backAlpha);
				_background.graphics.drawRect(-25, -25, ApplicationConfig.resolution.x + 50, ApplicationConfig.resolution.y + 50);
				_background.graphics.endFill();
				addChild(_background);
			}
			
			_upState.width = _size.x;
			_upState.height = _size.y;
			if (_windowPosition == WINDOW_CENTER)
			{
				_upState.x = ApplicationConfig.resolution.x / 2 - _upState.width / 2;
				_upState.y = ApplicationConfig.resolution.y / 2 - _upState.height / 2;
			}
			
			if (_buttonPos)
			{
				_closeButton.x = _upState.x + _buttonPos.x;
				_closeButton.y = _upState.y + _buttonPos.y;
			}
			else
			{
				_closeButton.x = _upState.x;
				_closeButton.y = _upState.y;
			}
			
			addChild(_upState);
			addChild(_closeButton);
			_closeButton.addEventListener(MouseEvent.CLICK, clickClose)
		}
	
	}

}