package jframe.layer
{
	import flash.display.Sprite;
	
	/**
	 * Gerencia as layers
	 * @author Jeff Ramos
	 */
	public class LayerManager extends Sprite
	{
		private var _layers:Object;
		private var _contentGame:Sprite;
		private var _arrayLayers:Array;
		
		public function LayerManager()
		{
		}
		
		/**
		 * Adiciona uma layer
		 * @param	content
		 * @param	label
		 */
		public function addLayer(content:IGameLayer, label:String):void
		{
			content.layerName = label;
			content.layerManager = this;
			
			if (!_arrayLayers)
				_arrayLayers = new Array();
			
			_arrayLayers.push(content)
		}
		
		/**
		 * Retorna uma layer
		 * @param	label
		 * @return
		 */
		public function getLayer(label:String):GameLayer
		{
			var contentReturn:GameLayer = null;
			for (var i:int = 0; i < _arrayLayers.length; i++)
			{
				if (_arrayLayers[i].layerName == label)
					contentReturn = _arrayLayers[i];
			}
			if (contentReturn)
				return contentReturn
			throw("Layer ", label, " nao encontrada");
			return null
		}
		
		/**
		 * Pausa todas as layers
		 */
		public function pauseAllLayers():void
		{
			for (var i:int = 0; i < _arrayLayers.length; i++)
			{
				try
				{
					var gameLayerObject:IGameLayer = IGameLayer(_arrayLayers[i]);
					gameLayerObject.pauseLayer();
				}
				catch (err:Error)
				{
					trace("LayerManager.pauseAllLayers : " + err);
				}
			}
		}
		
		/**
		 * Despausa todas as layers
		 */
		public function unpauseAllLayers():void
		{
			for (var i:int = 0; i < _arrayLayers.length; i++)
			{
				try
				{
					var gameLayerObject:IGameLayer = IGameLayer(_arrayLayers[i]);
					if (gameLayerObject != null)
						gameLayerObject.unpauseLayer();
				}
				catch (err:Error)
				{
					
					trace("LayerManager.unpauseAllLayers ---> ", gameLayerObject.layerName, "<---", err);
				}
			}
		}
		
		/**
		 * Remove todas as layers, e destrói.
		 */
		public function destroyAllLayers():void
		{
			for (var i:int = 0; i < _arrayLayers.length; i++)
			{
				try
				{
					var gameLayerObject:IGameLayer = IGameLayer(_arrayLayers[i]);
					gameLayerObject.removeAllChildren();
					gameLayerObject.destroy();
				}
				catch (err:Error)
				{
					
				}
			}
		}
		
		/**
		 * Atualiza todos os filhos
		 */
		public function update():void
		{
			for each (var item:IGameLayer in _arrayLayers)
			{
				item.update();
			}
		}
	
	}

}