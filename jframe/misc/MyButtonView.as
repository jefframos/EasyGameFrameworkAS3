package jeff.misc
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.text.TextFieldAutoSize;
	/**
	 * ...
	 * @author Jeff
	 */
	public class MyButtonView extends Sprite
	{
		private var _scope:MyButton;
		public function MyButtonView()
		{
			_scope = new MyButton;
			addChild(_scope);
			
			buttonMode = true;
			this.addEventListener(MouseEvent.ROLL_OVER, rollOver)
			this.addEventListener(MouseEvent.ROLL_OUT, rollOut)
			_scope.label.mouseEnabled = false;
			
		}
		
		private function rollOver(e:MouseEvent):void 
		{
			this.transform.colorTransform = new ColorTransform(.8)
		}
		private function rollOut(e:MouseEvent):void 
		{
			this.transform.colorTransform = new ColorTransform()
		}
		public function setText(texto:String):void {
			
			_scope.label.text = texto;
			_scope.label.wordWrap = true
			_scope.label.cacheAsBitmap = true;
			//_scope.label.width = _scope.label.textWidth;
			//_scope.label.autoSize = TextFieldAutoSize.LEFT;
			//trace("before",_scope.label.width)
			_scope.label.autoSize = "left"//TextFieldAutoSize.RIGHT;
			//trace(_scope.label.width)
			_scope.background.width = _scope.label.width + _scope.label.x * 2;
			_scope.background.height = _scope.label.height + _scope.label.y * 2;
		}

	}

}

