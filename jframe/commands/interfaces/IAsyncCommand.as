package jframe.commands.interfaces
{
	
	/**
	 * ...
	 * @author Jeff
	 */
	public interface IAsyncCommand
	{
		/**
		 * 
		 * @param	callback
		 */
		function addCompleteCallback(callback:Function, label:String):void
		function complete():void		
		function kill():void
		function pause():void
		function unPause():void
		function execute():void
		function get label():String;
	}
	
}