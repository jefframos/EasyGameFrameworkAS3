package jframe.factory.slider
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Jeff
	 */
	public class SliderFactory
	{
		private var _holderUp:Class;
		private var _holderOver:Class;
		private var _bar:Class;
		
		public function SliderFactory()
		{
		
		}
		
		public function get bar():Class
		{
			return _bar;
		}
		
		public function set bar(value:Class):void
		{
			_bar = value;
		}
		
		public function get holderOver():Class
		{
			return _holderOver;
		}
		
		public function set holderOver(value:Class):void
		{
			_holderOver = value;
		}
		
		public function get holderUp():Class
		{
			return _holderUp;
		}
		
		public function set holderUp(value:Class):void
		{
			_holderUp = value;
		}
	
	}

}