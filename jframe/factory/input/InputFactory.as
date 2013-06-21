package jframe.factory.input
{
	import flash.display.DisplayObject;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author Jeff
	 */
	public class InputFactory
	{
		/**
		 * TEXT FIELD
		 */
		static public const TEXT_AUTO_SIZE:String = "textAutoSize";
		private var _backgroundColor:int;
		private var _textField:TextField;
		private var _sizeType:String;
		private var _multiline:Boolean;
		private var _textFormat:TextFormat;
		private var _backInput:Class;
		
		public function InputFactory()
		{
			_multiline = false;
			_backgroundColor = -1;
		}
		
		public function get textField():TextField
		{
			return _textField;
		}
		
		public function set textField(value:TextField):void
		{
			_textField = value;
			_textFormat = _textField.getTextFormat();
		}
		
		public function get sizeType():String
		{
			return _sizeType;
		}
		
		public function set sizeType(value:String):void
		{
			_sizeType = value;
		}
		
		public function get multiline():Boolean 
		{
			return _multiline;
		}
		
		public function set multiline(value:Boolean):void 
		{
			_multiline = value;
		}
		
		public function get textFormat():TextFormat 
		{
			return _textFormat;
		}
		
		public function set textFormat(value:TextFormat):void 
		{
			_textFormat = value;
			_textFormat.size = 20;
		}
		
		public function get backInput():Class 
		{
			return _backInput;
		}
		
		public function set backInput(value:Class):void 
		{
			_backInput = value;
		}
		
		public function get backgroundColor():int 
		{
			return _backgroundColor;
		}
		
		public function set backgroundColor(value:int):void 
		{
			_backgroundColor = value;
		}
	
	}

}