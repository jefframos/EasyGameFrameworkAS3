package jframe.factory 
{
	
	/**
	 * ...
	 * @author Jeff
	 */
	public interface IAbstractFactory 
	{
		function redraw(absFactory:AbstractFactory):void;
		function build():void;
	}
	
}