package jframe.application
{
	import jframe.application.ApplicationModel;
	import flash.display.Sprite;
	import flash.geom.Point;
	import jframe.screen.ScreenManager;
	
	/**
	 * ...
	 * @author Jeff
	 */
	public class AbstractApplication extends Sprite
	{
		static public const MAIN_SCREEN_MANAGER:String = "mainScreenManager";
		private var _resolution:Point;
		protected var _screenManager:ScreenManager;
		protected var _applicationContainer:Sprite;
		protected var _applicationModel:ApplicationModel;
		
		public function AbstractApplication(_resolution:Point)
		{
			this._resolution = _resolution;
			_applicationContainer = new Sprite();
			addChild(_applicationContainer);
			_screenManager = new ScreenManager(_applicationContainer, MAIN_SCREEN_MANAGER);
			ApplicationModel.resolution = _resolution;
			ApplicationModel.mainScreenManager = _screenManager;
		}
		
		public function get screenManager():ScreenManager 
		{
			return _screenManager;
		}
		
		public function set screenManager(value:ScreenManager):void 
		{
			_screenManager = value;
		}
	
	}

}