package jframe.misc 
{
	/**
	 * ...
	 * @author Jeff
	 */
	public class OtherUtils 
	{
		
		public function OtherUtils() 
		{
			
		}
		public static function intToTime(time:Number, numbersBeforDot:int = 2):String {
			var h:Number = Math.floor(time / 3600);
			var m:Number = Math.floor((time % 3600) / 60);
			var s:Number = Math.floor((time % 3600) % 60);
			return (h == 0 ? "" : (h < 10 ? "0" + h.toString() + ":" : h.toString() + ":")) + (m < 10 ? "0" + m.toString() : m.toString()) + ":" + (s < 10 ? "0" + s.toString() : s.toString());
		}
		public static function shuffle(array:Array, startIndex:int = 0, endIndex:int = 0):void {
			if (endIndex == 0)
				endIndex = array.length - 1;
			for (var i:int = endIndex; i > startIndex; i--){
				var randomNumber:int = Math.floor(Math.random() * endIndex) + startIndex;
				var tmp:* = array[i];
				array[i] = array[randomNumber];
				array[randomNumber] = tmp;
			}
			//return this;
		}
	}

}