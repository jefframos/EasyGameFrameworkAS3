/**
 * ...
 * >author		Sandro Santos
 */

package jframe.screen 
{
	
	import com.box3.utils.GlobalUtil;
	import com.greensock.TweenNano;
	import com.greensock.easing.Linear;
	import com.greensock.easing.Strong;
	import flash.display.BitmapData;
	
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	
	// TODO: Implementar bitmapData, toogle e uma flag isShown para verificar se está visível ou não
	
	public class ScreenLock extends MovieClip 
	{
		// ___________________________________________________________________ CONSTANTS
		
		// ___________________________________________________________________ CLASS PROPERTIES
		
		private var _time												: Number;
		private var _alpha												: Number;
		private var _isShown											: Boolean;
		private var _bitmapData											: BitmapData;
		
		// ___________________________________________________________________ INSTANCE PROPERTIES
		
		private var _scope												: MovieClip;
		
		// ___________________________________________________________________ GETTERS AND SETTERS
		
		override public function set x(value:Number):void
		{
			_scope.x = value;
			stageResized();
		}
		
		override public function set y(value:Number):void
		{
			_scope.y = value;
			stageResized();
		}
		
		public function get isShown():Boolean 
		{
			return _scope.visible;
		}
		
		// ___________________________________________________________________ CONSTRUCTOR
		
		public function ScreenLock (color:uint = 0x000000, bitmapData:BitmapData = null, alpha:Number = 0, time:Number = 0.1):void
		{
			build();
			
			_time = time;
			
			_alpha = alpha;
			if (_bitmapData == null && IS_DEBUG)
			{
				var colorTransform:ColorTransform = new ColorTransform();
				colorTransform.color = (!color)?0x000000:color;
				_scope.transform.colorTransform = colorTransform;
			}
			else
			{
				_bitmapData = bitmapData;
			}
			
			_scope.alpha = _alpha;
			
			GlobalUtil.stage.addEventListener(Event.RESIZE, eventHandler);
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		// ___________________________________________________________________ PUBLIC METHODS
		
		public function show(callbackFunction:Function = null):void
		{
			if(_scope.visible == false)
			{
				_scope.visible = true;
				var obj:Object = new Object();
				obj.alpha = _alpha;
				obj.ease = Linear.easeNone;
				if(callbackFunction != null)
				{
					obj.onComplete = callbackFunction;
				}
				TweenNano.killTweensOf(_scope);
				TweenNano.to(_scope, _time, obj );
			}
			else
			{
				if(callbackFunction != null)
					callbackFunction();
			}
		}
		
		public function hide(callbackFunction:Function = null):void
		{
			if(_scope.visible == true)
			{
				var obj:Object = new Object();
				obj.alpha = 0;
				obj.ease = Linear.easeNone;
				obj.onComplete = completeHide;
				if(callbackFunction != null)
				{
					obj.onCompleteParams = [callbackFunction]
				}
				TweenNano.killTweensOf(_scope);
				TweenNano.to(_scope, _time, obj );
			}
			else
			{
				if(callbackFunction != null)
					callbackFunction();
			}
		}
		
		// ___________________________________________________________________ PRIVATE METHODS
		
		private function stageResized():void
		{
			var newPosition:Point = _scope.parent.globalToLocal(new Point(0, 0));
			
			_scope.x = (newPosition.x);
			_scope.y = (newPosition.y);
			
			switch(GlobalUtil.stage.align)
			{
				case StageAlign.BOTTOM:
					_scope.x += (((GlobalUtil.stageWidth / 2) - (GlobalUtil.stage.stageWidth / 2)));
					_scope.y += (GlobalUtil.stageHeight - GlobalUtil.stage.stageHeight);
					break;
				case StageAlign.BOTTOM_LEFT:
					_scope.x = _scope.x;
					_scope.y += (GlobalUtil.stageHeight - GlobalUtil.stage.stageHeight);
					break;
				case StageAlign.BOTTOM_RIGHT:
					_scope.x += (GlobalUtil.stageWidth - GlobalUtil.stage.stageWidth);
					_scope.y += (GlobalUtil.stageHeight - GlobalUtil.stage.stageHeight);
					break;
				case StageAlign.LEFT:
					_scope.x = _scope.x;
					_scope.y += (((GlobalUtil.stageHeight / 2) - (GlobalUtil.stage.stageHeight / 2)));
					break;
				case StageAlign.RIGHT:
					_scope.x += (GlobalUtil.stageWidth - GlobalUtil.stage.stageWidth);
					_scope.y += (((GlobalUtil.stageHeight / 2) - (GlobalUtil.stage.stageHeight / 2)));
					break;
				case StageAlign.TOP:
					_scope.x += (((GlobalUtil.stageWidth / 2) - (GlobalUtil.stage.stageWidth / 2)));
					_scope.y = _scope.y;
					break;
				case StageAlign.TOP_LEFT:
					_scope.x = _scope.x;
					_scope.y = _scope.y;
					break;
				case StageAlign.TOP_RIGHT:
					_scope.x += (GlobalUtil.stageWidth - GlobalUtil.stage.stageWidth);
					_scope.y = _scope.y;
					break;
				default:
					_scope.x += (((GlobalUtil.stageWidth / 2) - (GlobalUtil.stage.stageWidth / 2)));
					_scope.y += (((GlobalUtil.stageHeight / 2) - (GlobalUtil.stage.stageHeight / 2)));
					break;
			}
			
			//_scope.x = 0;
			//_scope.y = 0;
			
			_scope.width = GlobalUtil.stage.stageWidth;
			_scope.height = GlobalUtil.stage.stageHeight;
		}
		
		private function completeHide(callbackFunction:Function = null):void
		{
			_scope.visible = false;
			if(callbackFunction != null)
			{
				callbackFunction();
			}
		}
		
		private function build():void
		{
			_scope = new MovieClip();
			addChild(_scope);
			
			if (_bitmapData)
			{
				_scope.graphics.beginBitmapFill(_bitmapData, null, true, true);
			}
			else
			{
				_scope.graphics.beginFill(0x000000, 1);
			}
			_scope.graphics.drawRect(0, 0, GlobalUtil.stageWidth, GlobalUtil.stageHeight);
			_scope.graphics.endFill();
		}
		
		private function destroy () : void
		{
			removeChild(_scope);
			_scope = null;
		}
		
		// ___________________________________________________________________ EVENTS
		
		private function addedToStageHandler(evt:Event):void
		{
			stageResized();
		}
		
		private function eventHandler(evt:Event):void
		{
			switch(evt.type)
			{
				case Event.RESIZE:
					stageResized();
					break;
			}
		}
	}
}

