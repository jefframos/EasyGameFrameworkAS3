package jframe.layer
{
	import flash.display.DisplayObject;
	
	/**
	 * ...
	 * @author Jeff
	 */
	public interface IGameLayer
	{
		function set layerName(name:String):void
		function get layerName():String
		function get layerManager():LayerManager		
		function set layerManager(value:LayerManager):void		
		function addChild(child:DisplayObject):DisplayObject
		function removeChild(child:DisplayObject):DisplayObject
		function removeAllChildren():void
		function getLayerChilds():Array
		function debugLayer(debugging:Boolean = true):void
		function build(args:Object = null):void
		function destroy():void
		function update():void
		function pauseLayer():void
		function unpauseLayer():void
	}

}