package jframe.factory.background 
{
	import flash.display.DisplayObject;
	/**
	 * ...
	 * @author Jeff
	 */
	public class BackgroundFactory 
	{
		private var _randomBackgrounds:Vector.<DisplayObject>;
		public function BackgroundFactory() 
		{
			_randomBackgrounds = new Vector.<DisplayObject>();
		}
		
		public function get randomBackgrounds():Vector.<DisplayObject> 
		{
			return _randomBackgrounds;
		}
		
		public function set randomBackgrounds(value:Vector.<DisplayObject>):void 
		{
			_randomBackgrounds = value;
		}
		
	}

}