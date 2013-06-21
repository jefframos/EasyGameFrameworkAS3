package jframe.screen.transitions
{
	import com.greensock.plugins.AutoAlphaPlugin;
	import com.greensock.plugins.TweenPlugin;
	import com.greensock.TimelineLite;
	import com.greensock.TweenAlign;
	import com.greensock.TweenLite;
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import jframe.factory.AbstractFactory;
	import jframe.factory.sound.SoundFactory;
	import jframe.sound.SoundManager;
	
	/**
	 * ...
	 * @author Jeff
	 */
	public class ScreenTransitions
	{
		static private var _factory:AbstractFactory;
		
		public function ScreenTransitions()
		{
		
		}
		
		public static function transitionIn(_absFactory:AbstractFactory, _vectorItens:Vector.<DisplayObject>, _vecInitPositions:Vector.<Point>, callback:Function):void
		{
			_factory = _absFactory;
			if (_vectorItens != null && _vecInitPositions != null)
			{
				if (_vectorItens.length != _vecInitPositions.length)
				{
					trace("Vetores da transição estão com tamanhos diferentes");
					return
				}
				if (_factory != null)
					if (_factory.soundFactory)
					{
						if (_factory.soundFactory.transitionSoundType == SoundFactory.PER_SCREEN)
						{
							if (_factory.soundFactory.transitionIn)
								SoundManager.playSound(_factory.soundFactory.transitionIn);
						}
					}
				
				var timeLine:TimelineLite = new TimelineLite({onComplete: callback});
				
				var arrayTweens:Array = new Array();
				for (var i:int = 0; i < _vectorItens.length; i++)
				{
					_vectorItens[i].y = _vecInitPositions[i].y - 10;
					_vectorItens[i].alpha = 0;
					arrayTweens.push(new TweenLite(_vectorItens[i], .2, {autoAlpha: 1, y: _vecInitPositions[i].y, onInit: onInitIn}));
				}
				timeLine.insertMultiple(arrayTweens, 0, TweenAlign.START, 0.1);
			}
		}
		
		static private function onInitIn():void
		{
			if (_factory != null)
				if (_factory.soundFactory)
				{
					if (_factory.soundFactory.transitionSoundType == SoundFactory.PER_OBJECT)
					{
						if (_factory.soundFactory.transitionIn)
							SoundManager.playSound(_factory.soundFactory.transitionIn);
					}
				}
		}
		
		public static function transitionOut(_absFactory:AbstractFactory, _vectorItens:Vector.<DisplayObject>, _vecInitPositions:Vector.<Point>, callback:Function):void
		{
			_factory = _absFactory;
			if (_vectorItens != null && _vecInitPositions != null)
			{
				if (_vectorItens.length != _vecInitPositions.length)
				{
					trace("Vetores da transição estão com tamanhos diferentes");
					return
				}
				
				if (_factory.soundFactory)
				{
					if (_factory.soundFactory.transitionSoundType == SoundFactory.PER_SCREEN)
					{
						if (_factory.soundFactory.transitionIn)
							SoundManager.playSound(_factory.soundFactory.transitionOut);
					}
				}
				
				var timeLine:TimelineLite = new TimelineLite({onComplete: callback});
				var arrayTweens:Array = new Array();
				for (var i:int = _vectorItens.length - 1; i >= 0; i--)
				{
					arrayTweens.push(new TweenLite(_vectorItens[i], .2, {autoAlpha: 0, y: _vecInitPositions[i].y - 10, onInit: onInitOut}));
				}
				timeLine.insertMultiple(arrayTweens, 0, TweenAlign.START, 0.1);
			}
		}
		
		static private function onInitOut():void
		{
			if (_factory.soundFactory)
			{
				if (_factory.soundFactory.transitionSoundType == SoundFactory.PER_OBJECT)
				{
					if (_factory.soundFactory.transitionOut)
						SoundManager.playSound(_factory.soundFactory.transitionOut);
				}
			}
		}
	
	}

}