package jframe.factory.label
{
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * ...
	 * @author Jeff
	 */
	public class LabelFactory
	{
		/**
		 * TEXT FIELD
		 */
		static public const TEXT_AUTO_SIZE:String = "textAutoSize";
		private var _textAlign:String;
		private var _textField:TextField;
		private var _sizeType:String;
		private var _textFormat:TextFormat;
		private var _textSize:uint;
		
		/**
		 * FILTERS
		 */
		private var _textFilters:Array;
		
		public function LabelFactory()
		{
			_textAlign = TextFormatAlign.LEFT;
			_textFilters = new Array()
		}
		
		public function get textField():TextField
		{
			return _textField;
		}
		
		public function set textField(value:TextField):void
		{
			_textField = value;
			_textFormat = _textField.getTextFormat();
			_textFormat.align = _textAlign;
		
			
			_textField.embedFonts = true
			
			_textField.antiAliasType = AntiAliasType.ADVANCED
			_textField.sharpness = 100;
			_textField.thickness = 100;
			if (_textField.filters.length > 0)
				_textFilters = _textField.filters;
				
			_textField.defaultTextFormat = _textFormat;
		}
		
		public function get sizeType():String
		{
			return _sizeType;
		}
		
		public function set sizeType(value:String):void
		{
			_sizeType = value;
		}
		
		public function get textFormat():TextFormat
		{
			return _textFormat;
		}
		
		public function set textFormat(value:TextFormat):void
		{
			_textFormat = value;
		}
		
		public function get textAlign():String
		{
			return _textAlign;
		}
		
		public function set textAlign(value:String):void
		{
			_textAlign = value;
			if (_textFormat)
				_textFormat.align = _textAlign;
		}
		
		public function get textFilters():Array
		{
			return _textFilters;
		}
		
		public function set textFilters(value:Array):void
		{
			_textFilters = value;
		}
		
		public function get textSize():uint
		{
			return _textSize;
		}
		
		public function set textSize(value:uint):void
		{
			_textSize = value;
			_textFormat.size = _textSize;
		}
	
	}

}