package jframe.GUI.button
{
	import com.greensock.TweenNano;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.text.TextField;
	import jframe.factory.IAbstractFactory;
	import jframe.sound.SoundManager;
	import jframe.util.DisplayUtil;
	
	/**
	 * ...
	 * @author Jeff
	 */
	public class ImageButton extends Sprite implements IAbstractFactory
	{
		private var _clickFunction:Function;
		private var _fixedSize:Point;
		private var _imageOver:DisplayObject;
		private var _imageUp:DisplayObject;
		private var _isButton:Boolean;
		private var _over:Boolean;
		private var _soundOver:Sound;
		private var _id:uint;
		private var _imageSelected:DisplayObject
		private var _active:Boolean;
		private var _returnFunction:Object;
		;
		
		public function ImageButton(imageUp:DisplayObject, imageOver:DisplayObject = null, imageSelected:DisplayObject = null, _fixedSize:Point = null, _clickFunction:Function = null, _returnFunction:Object = null, _isButton:Boolean = true, _soundOver:Sound = null)
		{
			this._returnFunction = _returnFunction;
			this._imageSelected = imageSelected;
			this._soundOver = _soundOver;
			this._isButton = _isButton;
			this._clickFunction = _clickFunction;
			this._fixedSize = _fixedSize;
			this._imageUp = imageUp;
			this._imageOver = imageOver;
			this.addEventListener(MouseEvent.CLICK, callClickFunction);
			this.buttonMode = _isButton;
			_id = Math.random() * 0xFFFFFF;
			build();
		}
		
		private function callClickFunction(e:MouseEvent):void
		{
			if (!_active)
				active();
			else
				deactive();
			if (_clickFunction != null)
			{
				if (_returnFunction != null)
					_clickFunction(_returnFunction)
				else
					_clickFunction()
			}
		}
		
		public function deactive(isOver:Boolean = true):void
		{
			if (_imageSelected != null)
			{
				_active = false;
				TweenNano.to(_imageOver, .2, {alpha: (isOver ? 1 : 0)});
				TweenNano.to(_imageSelected, .2, {alpha: 0});
				TweenNano.to(_imageUp, .2, {alpha: (isOver ? 0 : 1)});
			}
		}
		
		public function active():void
		{
			if (_imageSelected != null)
			{
				_active = true;
				TweenNano.to(_imageOver, .2, {alpha: 0});
				TweenNano.to(_imageSelected, .2, {alpha: 1});
				TweenNano.to(_imageUp, .2, {alpha: 0});
			}
		}
		
		/* INTERFACE factory.IAbstractFactory */
		
		public function redraw(absFactory:AbstractFactory):void
		{
		
		}
		
		public function build():void
		{
			if (_imageOver != null)
			{
				this.addChild(_imageOver);
				_imageOver.alpha = 0;
			}
			if (_imageSelected != null)
			{
				this.addChild(_imageSelected);
				_imageSelected.alpha = 0;
			}
			
			this.addChild(_imageUp);
			
			this.addEventListener(MouseEvent.ROLL_OVER, mouseHandler);
			this.addEventListener(MouseEvent.ROLL_OUT, mouseHandler);
			
			DisplayUtil.recursiveDisable(this, TextField);
		}
		
		private function mouseHandler(e:MouseEvent):void
		{
			if (e.type == MouseEvent.ROLL_OVER)
			{
				_over = true;
				if (!_active)
				{
					if (_soundOver)
						SoundManager.playSound(_soundOver);
					
					if (_imageOver != null)
						TweenNano.to(_imageOver, .2, {alpha: 1});
					TweenNano.to(_imageUp, .2, {delay: .2 / 2, alpha: 0});
				}
			}
			else if (e.type == MouseEvent.ROLL_OUT)
			{
				_over = false;
				if (!_active)
				{
					if (_imageOver != null)
						TweenNano.to(_imageOver, .2, {delay: .2 / 2, alpha: 0});
					TweenNano.to(_imageUp, .2, {alpha: 1});
				}
			}
		}
		
		public function get id():uint
		{
			return _id;
		}
		
		public function set id(value:uint):void
		{
			_id = value;
		}
	
	}

}