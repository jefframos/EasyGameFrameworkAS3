package jframe.GUI.slider
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import GUI.button.ImageButton;
	import jframe.factory.AbstractFactory;
	import jframe.factory.IAbstractFactory;
	import jframe.GUI.button.ImageButton;
	import jframe.util.PositionUtil;
	
	/**
	 * ...
	 * @author Jeff
	 */
	public class DefaultSlider extends Sprite implements IAbstractFactory
	{
		private var _holder:ImageButton;
		private var _bar:Sprite;
		private var _sizeHolder:Point;
		private var _sizeBar:Point;
		private var _factory:AbstractFactory
		private var _holderOver:Sprite;
		;
		private var _xCorrection:Number;
		private var _percent:Number;
		private var _callbackChangeHolder:Function;
		private var _actualXHolder:Number = int.MIN_VALUE;
		
		public function DefaultSlider(absFactory:AbstractFactory, _sizeHolder:Point, _sizeBar:Point, _callbackChangeHolder:Function = null)
		{
			this._callbackChangeHolder = _callbackChangeHolder;
			this._sizeBar = _sizeBar;
			this._sizeHolder = _sizeHolder;
			this._factory = absFactory;
			build()
		
		}
		
		/* INTERFACE factory.IAbstractFactory */
		
		public function redraw(absFactory:AbstractFactory):void
		{
			this._factory = absFactory;
			if (_bar.stage)
				this.removeChild(_bar)
			if (_holder.stage)
				this.removeChild(_holder)
			build();
		}
		
		public function build():void
		{
			if (_factory.sliderFactory != null || _factory.buttonFactory != null)
			{
				if (_factory.sliderFactory != null && _factory.sliderFactory.bar != null)
				{
					this._bar = new _factory.sliderFactory.bar;
				}
				else
				{
					this._bar = new _factory.buttonFactory.buttonUpState;
				}
				this.addChild(_bar)
				_bar.buttonMode = true;
				_bar.width = _sizeBar.x;
				_bar.height = _sizeBar.y;
				_bar.addEventListener(MouseEvent.MOUSE_DOWN, onClickBar);
				
				if (_factory.sliderFactory != null && _factory.sliderFactory.holderOver != null && _factory.sliderFactory.holderUp != null)
				{
					_holder = new ImageButton(new _factory.sliderFactory.holderUp, new _factory.sliderFactory.holderOver)
				}
				else if (_factory.sliderFactory != null && _factory.sliderFactory.holderUp != null)
				{
					_holder = new ImageButton(new _factory.sliderFactory.holderUp, null)
				}
				else
				{
					_holder = new ImageButton(new _factory.buttonFactory.buttonUpState, new _factory.buttonFactory.buttonOverState)
				}
				_holder.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
				ApplicationConfig.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
				_holder.width = _sizeHolder.x;
				_holder.height = _sizeHolder.y;
				this.addChild(_holder)
				PositionUtil.centerByObject(_holder, _bar)
				if (_actualXHolder > int.MIN_VALUE)
					_holder.x = _actualXHolder;
			}
		}
		
		private function onClickBar(e:MouseEvent):void
		{
			percent = (DisplayObject(e.target).mouseX) * 100 / (_bar.x + _bar.width - _holder.width) * _bar.scaleX;
			this.addEventListener(Event.ENTER_FRAME, enterFrame)
			if (_callbackChangeHolder != null)
				_callbackChangeHolder()
		}
		
		private function onMouseUp(e:MouseEvent):void
		{
			this.removeEventListener(Event.ENTER_FRAME, enterFrame)
		}
		
		private function onMouseDown(e:MouseEvent):void
		{
			_xCorrection = DisplayObject(e.target).mouseX;
			this.addEventListener(Event.ENTER_FRAME, enterFrame)
		}
		
		private function enterFrame(e:Event):void
		{
			_holder.x = mouseX - _holder.width / 2;
			
			if (_holder.x < 0)
				_holder.x = 0;
			if (_holder.x + _holder.width > _bar.x + _bar.width)
				_holder.x = _bar.x + _bar.width - _holder.width
			_percent = (_holder.x) * 100 / (_bar.x + _bar.width - _holder.width)
			_actualXHolder = _holder.x;
			
			if (_callbackChangeHolder != null)
				_callbackChangeHolder()
		}
		
		public function get percent():Number
		{
			return _percent;
		}
		
		public function set percent(value:Number):void
		{
			_percent = value;
			if (_bar != null && _holder != null)
				_holder.x = _percent * (_bar.x + _bar.width - _holder.width) / 100
		}
	
	}

}