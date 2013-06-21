package jframe.application 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.geom.Point;
	import jframe.factory.AbstractFactory;
	import jframe.screen.ScreenManager;
	/**
	 * ...
	 * @author Jeff
	 */
	public class ApplicationModel 
	{
		private static var _resolution:Point;
		private static var _stage:Stage;
		private static var _mainContainer:DisplayObjectContainer;
		private static var _mainScreenManager:ScreenManager;
		private static var _factory:AbstractFactory
		static public var rootURL:String;
		static public var socketURL:String;
		static public var socketPort:int;
		
		public function ApplicationModel() 
		{
			
		}
		
		static public function get resolution():Point 
		{
			return _resolution;
		}
		
		static public function set resolution(value:Point):void 
		{
			_resolution = value;
		}
		
		static public function get stage():Stage 
		{
			return _stage;
		}
		
		static public function set stage(value:Stage):void 
		{
			_stage = value;
		}
		
		static public function get factory():AbstractFactory 
		{
			return _factory;
		}
		
		static public function set factory(value:AbstractFactory):void 
		{
			_factory = value;
		}
		
		static public function get mainContainer():DisplayObjectContainer 
		{
			return _mainContainer;
		}
		
		static public function set mainContainer(value:DisplayObjectContainer):void 
		{
			_mainContainer = value;
		}
		
		static public function get mainScreenManager():ScreenManager 
		{
			return _mainScreenManager;
		}
		
		static public function set mainScreenManager(value:ScreenManager):void 
		{
			_mainScreenManager = value;
		}
		
	}

}