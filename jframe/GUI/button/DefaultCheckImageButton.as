package jframe.GUI.button
{
	import com.greensock.TweenNano;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import jframe.factory.AbstractFactory;
	import jframe.sound.SoundManager;
	import jframe.util.PositionUtil;
	
	/**
	 * ...
	 * @author Jeff
	 */
	public class DefaultCheckImageButton extends DefaultButton
	{
		private var _check:Boolean;
		private var _imageUp:DisplayObject;
		private var _imageOver:DisplayObject;
		private var _redrawAppendFunction:Function;
		
		public function DefaultCheckImageButton(absFactory:AbstractFactory, imageUp:DisplayObject = null, imageOver:DisplayObject = null, _fixedSize:Point = null, _clickFunction:Function = null, _redrawAppendFunction:Function = null, _type:String = "null")
		{
			this._redrawAppendFunction = _redrawAppendFunction;
			this._imageOver = imageOver;
			this._imageUp = imageUp;
			this._type = _type;
			
			super(absFactory, "", _fixedSize, _clickFunction, null, _type);
		}
		public function incressImagePos(pos:Point):void
		{
			_upState.x += pos.x;
			_overState.x += pos.x;
			
			_upState.y += pos.y;
			_overState.y += pos.y;
		}
		override public function redraw(absFactory:AbstractFactory):void
		{
			if (_redrawAppendFunction != null)
				_redrawAppendFunction();
			super.redraw(absFactory);
		}
		
		override public function build():void
		{
			if (_factory.soundFactory)
				if (_factory.soundFactory.buttonOver)
					_soundOver = _factory.soundFactory.buttonOver;
			
			if (_type == "null")
			{
				_type = SQUARE;
			}
			
			if (_type == SQUARE)
			{
				_upState = new _factory.buttonFactory.buttonUpState;
				_overState = new _factory.buttonFactory.buttonOverState;
			}
			else
			{
				_upState = new _factory.buttonFactory.buttonRoundUpState;
				_overState = new _factory.buttonFactory.buttonRoundOverState;
			}
			
			if (_factory.buttonFactory.buttonFilters.length > 0)
				this.filters = _factory.buttonFactory.textFilters;
			
			_margin = _factory.buttonFactory.margin;
			_transition = _factory.buttonFactory.transition;
			
			_upState.width = _imageUp.width + _factory.buttonFactory.margin.x * 2;
			_overState.width = _imageUp.width + _factory.buttonFactory.margin.x * 2;
			_imageUp.x = _factory.buttonFactory.margin.x;
			_imageOver.x = _factory.buttonFactory.margin.x;
			
			_upState.height = _imageUp.height + _factory.buttonFactory.margin.y * 2;
			_overState.height = _imageUp.height + _factory.buttonFactory.margin.y * 2;
			_imageUp.y = _factory.buttonFactory.margin.y;
			_imageOver.y = _factory.buttonFactory.margin.y;
			
			if (_fixedSize)
			{
				if (_fixedSize.x > 0)
				{
					_upState.width = _fixedSize.x;
					_overState.width = _fixedSize.x;
				}
				if (_fixedSize.y > 0)
				{
					_upState.height = _fixedSize.y;
					_overState.height = _fixedSize.y;
				}
			}
			
			_over = false;
			
			PositionUtil.centerByObject(_imageOver, _overState);
			PositionUtil.centerByObject(_imageUp, _overState);
			
			addChild(_upState);
			addChild(_overState);
			if (!_imageUp.stage)
				addChild(_imageUp);
			else
			{
				this.setChildIndex(_imageUp, this.numChildren - 1);
			}
			if (!_imageOver.stage)
				addChild(_imageOver);
			else
			{
				this.setChildIndex(_imageOver, this.numChildren - 1);
			}
			
			_overState.alpha = 0;
			_imageOver.alpha = 0;
			
			this.buttonMode = true;
			
			this.addEventListener(MouseEvent.ROLL_OVER, mouseHandler);
			this.addEventListener(MouseEvent.ROLL_OUT, mouseHandler);
		}
		
		private function mouseHandler(e:MouseEvent):void
		{
			if (e.type == MouseEvent.ROLL_OVER)
			{
				if (_soundOver)
					SoundManager.playSound(_soundOver);
				_over = true;
				if (_transition == ButtonFactory.ALPHA_TRANSITIONS)
				{
					TweenNano.to(_overState, _factory.buttonFactory.timeTransition, {alpha: 1});
					TweenNano.to(_upState, _factory.buttonFactory.timeTransition, {delay: _factory.buttonFactory.timeTransition / 2, alpha: 0});
				}
				else
				{
					_overState.alpha = 1;
					_upState.alpha = 0;
				}
				
			}
			else if (e.type == MouseEvent.ROLL_OUT)
			{
				_over = false;
				if (_transition == ButtonFactory.ALPHA_TRANSITIONS)
				{
					TweenNano.to(_overState, _factory.buttonFactory.timeTransition, {delay: _factory.buttonFactory.timeTransition / 2, alpha: 0});
					TweenNano.to(_upState, _factory.buttonFactory.timeTransition, {alpha: 1});
				}
				else
				{
					_overState.alpha = 0;
					_upState.alpha = 1;
				}
			}
		}
		
		public function get check():Boolean
		{
			return _check;
		}
		
		public function set check(value:Boolean):void
		{
			_check = value;
			if (_check)
			{
				TweenNano.to(_imageOver, _factory.buttonFactory.timeTransition, {delay: _factory.buttonFactory.timeTransition / 2, alpha: 0});
				TweenNano.to(_imageUp, _factory.buttonFactory.timeTransition, {alpha: 1});
			}
			else
			{
				TweenNano.to(_imageOver, _factory.buttonFactory.timeTransition, {alpha: 1});
				TweenNano.to(_imageUp, _factory.buttonFactory.timeTransition, {delay: _factory.buttonFactory.timeTransition / 2, alpha: 0});
			}
		}
	
	}

}