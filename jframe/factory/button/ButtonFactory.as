package jframe.factory.button
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.filters.BitmapFilter;
	import flash.filters.DropShadowFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.Sound;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Jeff
	 */
	public class ButtonFactory
	{
		/**
		 * TEXT FIELD
		 */
		static public const TEXT_AUTO_SIZE:String = "textAutoSize";
		private var _buttonTextField:TextField;
		private var _sizeType:String;
		private var _colorOver:uint;
		private var _colorUp:uint;
		private var _textFormat:TextFormat;
		private var _textSize:uint;
		
		/**
		 * STATES
		 */
		private var _buttonUpState:Class;
		private var _buttonOverState:Class;
		
		/**
		 * STATES
		 */
		private var _buttonRoundUpState:Class;
		private var _buttonRoundOverState:Class;
		
		/**
		 * POSITION
		 */
		private var _margin:Point;
		
		/**
		 * TRANSITIONS
		 */
		static public const ALPHA_TRANSITIONS:String = "auphaTransitions";
		static public const SCALE_TRANSITIONS:String = "scaleTransitions";
		static public const FLOAT_TRANSITIONS:String = "floatTransitions";
		private var _colorTransform:Number;
		private var _transition:String;
		private var _timeTransition:Number;
		
		/**
		 * FILTERS
		 */
		private var _textFilters:Array;
		private var _buttonFilters:Array;
		
		/**
		 * SOUND
		 */
		//private var _soundOver:Sound;
		
		public function ButtonFactory()
		{
			_colorOver = 0xFFFFFF;
			_colorUp = 0x000000;
			_transition = ALPHA_TRANSITIONS;
			_sizeType = TEXT_AUTO_SIZE;
			_margin = new Point(5, 5);
			_timeTransition = 0.3;
			_textFilters = new Array();
			_buttonFilters = new Array();
			_colorTransform = -1
		}
		
		public function get buttonUpState():Class
		{
			return _buttonUpState;
		}
		
		public function set buttonUpState(value:Class):void
		{
			_buttonUpState = value;
		}
		
		public function get buttonOverState():Class
		{
			
			return _buttonOverState;
		}
		
		public function set buttonOverState(value:Class):void
		{
			_buttonOverState = value;
		}
		
		public function get buttonTextField():TextField
		{
			return _buttonTextField;
		}
		
		public function set buttonTextField(value:TextField):void
		{
			_buttonTextField = value;
			if (_buttonTextField)
			{
				_textFormat = _buttonTextField.getTextFormat();
				if (_buttonTextField.filters.length > 0)
					_textFilters = _buttonTextField.filters;
			}
		}
		
		public function get sizeType():String
		{
			return _sizeType;
		}
		
		public function set sizeType(value:String):void
		{
			_sizeType = value;
		}
		
		public function get margin():Point
		{
			return _margin;
		}
		
		public function set margin(value:Point):void
		{
			_margin = value;
		}
		
		public function get transition():String
		{
			return _transition;
		}
		
		public function set transition(value:String):void
		{
			_transition = value;
		}
		
		public function get colorUp():uint
		{
			return _colorUp;
		}
		
		public function set colorUp(value:uint):void
		{
			_colorUp = value;
		}
		
		public function get colorOver():uint
		{
			return _colorOver;
		}
		
		public function set colorOver(value:uint):void
		{
			_colorOver = value;
		}
		
		public function get timeTransition():Number
		{
			return _timeTransition;
		}
		
		public function set timeTransition(value:Number):void
		{
			_timeTransition = value;
		}
		
		public function get textFormat():TextFormat
		{
			return _textFormat;
		}
		
		public function set textFormat(value:TextFormat):void
		{
			_textFormat = value;
		}
		
		public function get buttonFilters():Array
		{
			return _buttonFilters;
		}
		
		public function set buttonFilters(value:Array):void
		{
			_buttonFilters = value;
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
		
		public function get textFilters():Array
		{
			return _textFilters;
		}
		
		public function set textFilters(value:Array):void
		{
			_textFilters = value;
		}
		
		public function get buttonRoundUpState():Class
		{
			if (_buttonRoundUpState == null)
				return _buttonUpState;
				
			return _buttonRoundUpState;
		}
		
		public function set buttonRoundUpState(value:Class):void
		{
			_buttonRoundUpState = value;
		}
		
		public function get buttonRoundOverState():Class
		{
			if (_buttonRoundOverState == null)
				return _buttonOverState;
			return _buttonRoundOverState;
		}
		
		public function set buttonRoundOverState(value:Class):void
		{
			_buttonRoundOverState = value;
		}
		
		public function get colorTransform():Number 
		{
			return _colorTransform;
		}
		
		public function set colorTransform(value:Number):void 
		{
			_colorTransform = value;
		}
	
		//public function get soundOver():Sound 
		//{
		//return _soundOver;
		//}
		//
		//public function set soundOver(value:Sound):void 
		//{
		//_soundOver = value;
		//}
	
	}

}