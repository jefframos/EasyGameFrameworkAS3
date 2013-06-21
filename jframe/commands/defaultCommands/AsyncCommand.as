package jframe.commands.defaultCommands 
{
	import jframe.commands.interfaces.IAsyncCommand;
	
	/**
	 * ...
	 * @author Jeff
	 */
	public class AsyncCommand implements IAsyncCommand 
	{
		private var _callback:Function;
		private var _label:String = " ";
		//protected var myTween:TweenMax;
		public function AsyncCommand() 
		{
			
		}
		public function execute():void
		{
			
		}
		/* INTERFACE patterncraft.command.IAsyncCommand */
		
		public function addCompleteCallback(callback:Function, label:String):void 
		{
			_label = label;
			_callback = callback;			
		}
		
		public function complete():void 
		{
			_callback.call();
		}
		
		/* INTERFACE patterncraft.command.IAsyncCommand */
		
		public function kill():void 
		{
			
		}
		
		/* INTERFACE jframe.commands.interfaces.IAsyncCommand */
		
		public function pause():void 
		{
			
		}
		
		/* INTERFACE jframe.commands.interfaces.IAsyncCommand */
		
		public function unPause():void 
		{
			
		}
		
		public function get label():String 
		{
			return _label;
		}
		
		/* INTERFACE jeff.commands.interfaces.IAsyncCommand */
		
		
	}

}