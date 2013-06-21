package jframe.GUI.input
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextLineMetrics;
	import jframe.factory.IAbstractFactory;
	
	/**
	 * ...
	 * @author Jeff
	 */
	public class DefaultInput extends Sprite implements IAbstractFactory
	{
		private var _textFieldLabel:TextField;
		private var _textLabel:String;
		private var _absFactory:AbstractFactory;
		private var _backInput:DisplayObject;
		private var _width:int;
		
		public function DefaultInput(absFactory:AbstractFactory, textLabel:String = "", _width:int = 200)
		{
			this._width = _width;
			this._absFactory = absFactory;
			this._textLabel = textLabel;
			this._textFieldLabel = new TextField();
			_absFactory.inputFactory.textFormat.align = "left"
			_textFieldLabel.defaultTextFormat = _absFactory.inputFactory.textFormat;
			build();
		}
		
		/* INTERFACE factory.IAbstractFactory */
		
		public function redraw(absFactory:AbstractFactory):void
		{
			this._absFactory = absFactory;
			removeChild(_textFieldLabel);
			if (_backInput != null)
				if (_backInput.stage)
					removeChild(_backInput);
			_textFieldLabel.removeEventListener(FocusEvent.FOCUS_IN, focusIn);
			_textFieldLabel.removeEventListener(FocusEvent.FOCUS_OUT, focusOut);
			_textFieldLabel.defaultTextFormat = _absFactory.inputFactory.textFormat;
			build();
		}
		
		public function build():void
		{
			_textFieldLabel.embedFonts = true;
			_textFieldLabel.antiAliasType = AntiAliasType.ADVANCED;
			_textFieldLabel.text = _textLabel;
			_textFieldLabel.selectable = true;
			_textFieldLabel.type = TextFieldType.INPUT;
			_textFieldLabel.multiline = _absFactory.inputFactory.multiline;
			_textFieldLabel.autoSize = TextFieldAutoSize.LEFT;
			_textFieldLabel.width = _width;
			
			if (_absFactory.inputFactory.backgroundColor >= 0)
			{
				_textFieldLabel.background = true;
				_textFieldLabel.backgroundColor = _absFactory.inputFactory.backgroundColor;
			}
			
			if (_absFactory.inputFactory.backInput != null)
			{
				_backInput = new _absFactory.inputFactory.backInput;
				addChild(_backInput);
				_backInput.width = _width;
				_backInput.height = _textFieldLabel.height;
			}
			
			addChild(_textFieldLabel);
			_textFieldLabel.multiline = true;
			_textFieldLabel.wordWrap = true;
			_textFieldLabel.autoSize = TextFieldAutoSize.NONE;
			_textFieldLabel.width = _width;
			_textFieldLabel.addEventListener(FocusEvent.FOCUS_IN, focusIn);
			_textFieldLabel.addEventListener(FocusEvent.FOCUS_OUT, focusOut);
			_textFieldLabel.addEventListener(Event.CHANGE, changeTextField);
		}
		
		private function changeTextField(e:Event):void
		{
			var tf:TextField = e.target as TextField;
			crop(tf);
		}
		
		private function crop(tf:TextField):void
		{
			if (tf.numLines > 1)
			{
				tf.text = tf.text.substr(0, tf.text.length - 1);
				crop(tf);
			}
		
		}
		
		private function focusOut(e:FocusEvent):void
		{
			if (_textFieldLabel.text == "")
				_textFieldLabel.text = _textLabel;
		}
		
		private function focusIn(e:FocusEvent):void
		{
			if (_textFieldLabel.text == _textLabel)
				_textFieldLabel.text = "";
		}
		
		public function get textInput():String
		{
			return _textFieldLabel.text;
		}
		
		public function set textInput(value:String):void
		{
			_textFieldLabel.text = value;
		}
	
	}

}