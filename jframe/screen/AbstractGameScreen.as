package jframe.screen
{
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import jframe.application.ApplicationModel;
	import jframe.screen.AbstractScreen;
	import jframe.screen.transitions.ScreenTransitions;
	
	/**
	 * ...
	 * @author Jeff
	 */
	public class AbstractGameScreen extends AbstractScreen
	{
		protected var _vectorItens:Vector.<DisplayObject>;
		protected var _vecInitPositions:Vector.<Point>;
		
		public function AbstractGameScreen(_label:String)
		{
			super(_label);
		}
		
		override public function build():void
		{
			
			if (!_isBuild)
			{
				_isBuild = true;
				
				if (_vectorItens === null)
					_vectorItens = new Vector.<DisplayObject>();
				
				builder()
				
				_vecInitPositions = new Vector.<Point>();
				
				for each (var item:DisplayObject in _vectorItens)
				{
					_vecInitPositions.push(new Point(item.x, item.y));
				}
			}
			else if (_vectorItens != null)
			{
				for each (var item2:DisplayObject in _vectorItens)
				{
					addChild(item2);
				}
			}
		}
		
		override public function addChild(child:DisplayObject):DisplayObject
		{
			if (_vectorItens == null)
				_vectorItens = new Vector.<DisplayObject>();
			var contains:Boolean = false;
			for each (var item:DisplayObject in _vectorItens)
			{
				if (item == child)
					contains = true;
			}
			if (!contains)
				_vectorItens.push(child);
			return super.addChild(child);
		}
		
		override public function destroy():void
		{
			while (this.numChildren)
				removeChildAt(0);
		}
		
		protected function builder():void
		{
		
		}
		
		/**
		 * Transição das telas
		 */
		override protected function transitionIn():void
		{
			ScreenTransitions.transitionIn(ApplicationModel.factory, _vectorItens, _vecInitPositions, endTransitionIn)
		}
		
		override protected function transitionOut():void
		{
			ScreenTransitions.transitionOut(ApplicationModel.factory, _vectorItens, _vecInitPositions, endTransitionOut)
		}
	
	}

}