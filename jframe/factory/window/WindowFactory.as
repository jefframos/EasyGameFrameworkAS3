package jframe.factory.window 
{
	import jframe.factory.IAbstractFactory;
	/**
	 * ...
	 * @author Jeff
	 */
	public class WindowFactory 
	{
		
		/**
		 * STATES
		 */
		private var _upState:Class;
		
		/**
		 * COLORS
		 */
		private var _backColor:int;
		private var _backAlpha:Number;
		
		
		public function WindowFactory() 
		{
			_backColor = 1;
			_backAlpha = 0.5;
		}
		
		public function get upState():Class 
		{
			return _upState;
		}
		
		public function set upState(value:Class):void 
		{
			_upState = value;
		}
		
		public function get backColor():int 
		{
			return _backColor;
		}
		
		public function set backColor(value:int):void 
		{
			_backColor = value;
		}
		
		public function get backAlpha():Number 
		{
			return _backAlpha;
		}
		
		public function set backAlpha(value:Number):void 
		{
			_backAlpha = value;
		}
		
	}

}