package jframe.effects 
{
	import com.greensock.TweenLite;
	import flash.display.Sprite;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author Jeff
	 */
	public class PopUpText extends Sprite
	{
		private var _time:Number;
		private var _distanceY:Number;
		
		public function PopUpText(_label:String, _time:Number = .5, _distanceY:Number = -10, textFormat:TextFormat = null) 
		{
				this._distanceY = _distanceY;
				this._time = _time;
				var _tempTextField:TextField = new TextField();
				_tempTextField.antiAliasType = AntiAliasType.ADVANCED;
				_tempTextField.defaultTextFormat = textFormat != null?textFormat:new TextFormat;
				_tempTextField.autoSize = TextFieldAutoSize.LEFT
				_tempTextField.text = _label;
				addChild(_tempTextField);
		}
		
		public function start():void 
		{
			TweenLite.to(this, _time, {y:y + _distanceY, onComplete:onComplete})
		}
		
		private function onComplete():void 
		{
			if(this.parent)
				this.parent.removeChild(this);
		}
		
		
	}

}