package jframe.samples.toolTipSample
{
	import assets.samples.TooltipView;
	import com.greensock.plugins.AutoAlphaPlugin;
	import com.greensock.plugins.TweenPlugin;
	import com.greensock.TweenLite;
	import com.greensock.TweenNano;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import flash.text.TextFieldAutoSize;
	
	/**
	 * ...
	 * @author Jeff
	 */
	public class TooltipSample extends EventDispatcher
	{
		static private var _scope:TooltipView;
		static private var instance:TooltipSample;
		static private var _container:Sprite;
		
		public function TooltipSample()
		{
		
		}
		
		public static function initialize(_container:DisplayObjectContainer):void
		{
			TweenPlugin.activate([AutoAlphaPlugin]);
			_scope = new TooltipView;
			_scope.visible = false;
			_scope.alpha = 0;
			_container = _container;
			_container.addChild(_scope);
		}
		
		public static function show(pos:Point, label:String, timeShow:Number = .3, autoHide:Number = -1):void
		{
			var wmargin:int = 20;
			TweenLite.killTweensOf(_scope);
			_scope.visible = false;
			_scope.alpha = 0;
			_scope.parent.setChildIndex(_scope, _scope.parent.numChildren - 1);
			_scope._label.autoSize = TextFieldAutoSize.CENTER;
			_scope._label.text = label;
			_scope._background.width = _scope._label.width + wmargin*2;
			_scope._background.x = _scope._label.x - wmargin;
			_scope.x = pos.x;
			_scope.y = pos.y;
			var tweenObj:Object = {};
			tweenObj.autoAlpha = 1;
			if (autoHide > 0)
			{
				tweenObj.onCompleteParams = [autoHide];
				tweenObj.onComplete = hide;
			}
			
			TweenLite.to(_scope, timeShow, tweenObj);
		}
		
		static public function hide(delay:Number = 0):void
		{
			TweenLite.to(_scope, .1, {delay:delay, autoAlpha: 0});
		}
	}

}