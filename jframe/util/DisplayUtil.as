package jframe.util 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	/**
	 * ...
	 * @author Jeff
	 */
	public class DisplayUtil 
	{
		
		public function DisplayUtil() 
		{
			
		}
		public static function recursiveDisable(display:DisplayObjectContainer, type:Class):void
		{
			for (var i:int = 0; i < display.numChildren; i++)
			{
				if (display.getChildAt(i) is type)
				{
					try
					{
						if (display.getChildAt(i) is InteractiveObject)
						{
							InteractiveObject(display.getChildAt(i))["mouseEnabled"] = false;
						}
					}
					catch (err:Error)
					{
						trace("recursiveDisable 1: " + err);
					}
				}
				else if (display.getChildAt(i) is DisplayObjectContainer)
				{
					
					var obj:DisplayObjectContainer = DisplayObjectContainer(display.getChildAt(i));
					try
					{
						if (obj.numChildren > 0)
							recursiveDisable(obj, type);
					}
					catch (err:Error)
					{
						trace("recursiveDisable 2: " + err);
					}
				}
			}
		}
	}

}