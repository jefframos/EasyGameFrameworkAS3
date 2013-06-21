package jframe.GUI.label
{
	import flash.display.Sprite;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import jframe.factory.IAbstractFactory;
	
	/**
	 * ...
	 * @author Jeff
	 */
	public class DefaultLabel extends Sprite implements IAbstractFactory
	{
		private var _textFieldLabel:TextField;
		private var _factory:AbstractFactory;
		private var _size:uint;
		private var _textLabel:String;
		private var _labelWidth:int;
		private var _alignType:String;
		private var _wordWrap:Boolean;
		
		public function DefaultLabel(absFactory:AbstractFactory, textLabel:String = "", _labelWidth:int = 0, _size:uint = 10, _alignType:String = "null", _wordWrap:Boolean = true)
		{
			this._wordWrap = _wordWrap;
			this._alignType = _alignType;			
			this._labelWidth = _labelWidth;
			this._textLabel = textLabel;
			this._size = _size;
			this._factory = absFactory;
			_textFieldLabel = new TextField()
			_factory.labelFactory.textFormat.size = _size;
			_textFieldLabel.defaultTextFormat = _factory.labelFactory.textFormat;
			
			build();
		}
		
		/* INTERFACE factory.IAbstractFactory */
		
		public function redraw(absFactory:AbstractFactory):void
		{
			this._factory = absFactory;
			removeChild(_textFieldLabel);
			_textFieldLabel = new TextField();
			
			_factory.labelFactory.textFormat.size = _size;
			_textFieldLabel.defaultTextFormat = _factory.labelFactory.textFormat;
			this.filters = [];
			build();
		}
		
		public function build():void
		{
			_textFieldLabel.embedFonts = true;
			_textFieldLabel.antiAliasType = AntiAliasType.ADVANCED;
			_textFieldLabel.multiline = true;
			if (_alignType == "null")
				_alignType = TextFieldAutoSize.CENTER;
			_textFieldLabel.autoSize = _alignType;
			_textFieldLabel.wordWrap = _wordWrap;
			_textFieldLabel.text = _textLabel;
			_textFieldLabel.selectable = false;
			if (_factory.labelFactory.textFilters.length > 0)
				_textFieldLabel.filters = _factory.labelFactory.textFilters;
			if (_labelWidth > 0)
				_textFieldLabel.width = _labelWidth;
			addChild(_textFieldLabel);
		}
		public function changeLabelSize(size:int):void
		{
			_size = size;
			var f:TextFormat = _textFieldLabel.getTextFormat();
			f.size = size;
			_textFieldLabel.setTextFormat(f);
		}
		public function get textLabel():String
		{
			return _textLabel;
		}
		
		public function set textLabel(value:String):void
		{
			_textLabel = value;
			_textFieldLabel.text = _textLabel;
		}
	
	}

}