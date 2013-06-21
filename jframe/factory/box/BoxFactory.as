package jframe.factory.box 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Jeff
	 */
	public class BoxFactory 
	{
		/**
		 * STATES
		 */
		private var _upState:Class;
		private var _overState:Sprite;
		
		public function BoxFactory() 
		{
			
		}
		
		public function get upState():Class 
		{
			return _upState;
		}
		
		public function set upState(value:Class):void 
		{
			_upState = value;
		}
		
	}

}