package jframe.factory.sound 
{
	import flash.media.Sound;
	/**
	 * ...
	 * @author Jeff
	 */
	public class SoundFactory 
	{
		static public const PER_OBJECT:String = "perObject";
		static public const PER_SCREEN:String = "perScreen";
		private var _buttonOver:Sound;
		private var _buttonOut:Sound;
		private var _transitionIn:Sound;
		private var _transitionOut:Sound;
		private var _ambientSound:Sound;
		private var _transitionSoundType:String;
		public function SoundFactory() 
		{
			
		}
		
		public function get buttonOver():Sound 
		{
			return _buttonOver;
		}
		
		public function set buttonOver(value:Sound):void 
		{
			_buttonOver = value;
		}
		
		public function get buttonOut():Sound 
		{
			return _buttonOut;
		}
		
		public function set buttonOut(value:Sound):void 
		{
			_buttonOut = value;
		}
		
		public function get transitionIn():Sound 
		{
			return _transitionIn;
		}
		
		public function set transitionIn(value:Sound):void 
		{
			_transitionIn = value;
		}
		
		public function get transitionOut():Sound 
		{
			return _transitionOut;
		}
		
		public function set transitionOut(value:Sound):void 
		{
			_transitionOut = value;
		}
		
		public function get transitionSoundType():String 
		{
			if (_transitionSoundType == "" || _transitionSoundType == null)
				_transitionSoundType = PER_OBJECT;
			return _transitionSoundType;
		}
		
		public function set transitionSoundType(value:String):void 
		{
			_transitionSoundType = value;
		}
		
		public function get ambientSound():Sound 
		{
			return _ambientSound;
		}
		
		public function set ambientSound(value:Sound):void 
		{
			_ambientSound = value;
		}
		
	}

}