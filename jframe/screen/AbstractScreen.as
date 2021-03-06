/**
 * ...
 * >author		Sandro Santos
 */

package jframe.screen
{
	
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import jframe.events.ScreenEvent;
	
	import flash.display.MovieClip;
	
	public class AbstractScreen extends MovieClip
	{
		// ___________________________________________________________________ CONSTANTS
		
		// ___________________________________________________________________ CLASS PROPERTIES
		
		private var _screenName:String;
		private var _screenManagerName:String;
		private var _showStartedEvent:ScreenEvent;
		private var _showFinishedEvent:ScreenEvent;
		private var _hideStartedEvent:ScreenEvent;
		private var _hideFinishedEvent:ScreenEvent;
		private var _isShowing:Boolean;
		private var _isHiding:Boolean;
		private var _isShown:Boolean;
		protected var _isBuild:Boolean;
		
		// ___________________________________________________________________ INSTANCE PROPERTIES
		
		private var _screenManager:ScreenManager;
		
		// ___________________________________________________________________ GETTERS AND SETTERS
		
		public function get screenName():String
		{
			return _screenName;
		}
		
		public function get screenManagerName():String
		{
			return _screenManagerName;
		}
		
		public function get isShown():Boolean
		{
			return _isShown;
		}
		
		public function get screenManager():ScreenManager
		{
			return _screenManager;
		}
		
		public function set screenManager(value:ScreenManager):void
		{
			_screenManager = value;
			_screenManagerName = _screenManager.screenManagerName;
		}
		
		public function get isShowing():Boolean
		{
			return _isShowing;
		}
		
		public function get isHiding():Boolean
		{
			return _isHiding;
		}
		
		public function get isBuild():Boolean
		{
			return _isBuild;
		}
		
		public function set isBuild(value:Boolean):void
		{
			_isBuild = value;
		}
		
		// ___________________________________________________________________ CONSTRUCTOR
		
		public function AbstractScreen(screenName:String)
		{
			_screenName = screenName;
			_isShown = false;
			_isShowing = false;
			_isHiding = false;
		}
		
		// ___________________________________________________________________ PUBLIC METHODS
		
		public function rebuild():void
		{
		}
		
		public function build():void
		{
			throw new Error("A função build() da tela " + _screenName.toUpperCase() + " não foi implementada.");
		}
		
		public function destroy():void
		{
			throw new Error("A função destroy() da tela " + _screenName.toUpperCase() + " não foi implementada.");
		}
		
		protected function transitionIn():void
		{
			endTransitionIn();
		}
		
		protected function endTransitionIn():void
		{
			_isShown = true;
			_isShowing = false;
			dispatchShowFinished();
		}
		
		protected function transitionOut():void
		{
			endTransitionOut();
		}
		
		protected function endTransitionOut():void
		{
			destroy();
			this.visible = false;
			_isHiding = false;
			dispatchHideFinished();
		}
		
		public function show():void
		{
			_isShowing = true;
			dispatchShowStarted();
			//_isBuild = true;
			build();
			this.visible = true;
			transitionIn();
		}
		
		public function hide():void
		{
			_isShown = false;
			_isHiding = true;
			dispatchHideStarted();
			transitionOut();
		}
		
		// ___________________________________________________________________ PRIVATE METHODS
		
		private function dispatchShowStarted():void
		{
			_screenManager.dispatchEvent(new ScreenEvent(ScreenEvent.SHOW_STARTED, _screenName, _screenManagerName));
		}
		
		private function dispatchShowFinished():void
		{
			_screenManager.dispatchEvent(new ScreenEvent(ScreenEvent.SHOW_FINISHED, _screenName, _screenManagerName));
		}
		
		private function dispatchHideStarted():void
		{
			_screenManager.dispatchEvent(new ScreenEvent(ScreenEvent.HIDE_STARTED, _screenName, _screenManagerName));
		}
		
		private function dispatchHideFinished():void
		{
			_screenManager.dispatchEvent(new ScreenEvent(ScreenEvent.HIDE_FINISHED, _screenName, _screenManagerName));
		}
	
		// ___________________________________________________________________ EVENTS
	}
}