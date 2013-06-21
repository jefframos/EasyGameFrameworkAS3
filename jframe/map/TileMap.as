package jframe.map
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import jframe.application.ApplicationModel;
	import jframe.image.ImageManipulation;
	
	/**
	 * Classe que monta o tile map através de uma string com as posições do mapa e uma imagem com o tile map
	 * Ela tem como um array com todas as posições do tilemap
	 * @author Jefferson Ramos
	 */
	public class TileMap extends Sprite
	{
		protected var _data:Array;
		protected var heightInTiles:uint;
		protected var widthInTiles:uint;
		protected var _dataMap:Vector.<int>;
		protected var arrayBitMaps:Array;
		protected var arrayMultiBitMaps:Array;
		protected var tileWidth:uint;
		protected var tileHeight:uint;
		protected var _arrayTiles:Array;
		protected var _arrayMultiplesTiles:Array;
		protected var _scope:Sprite;
		protected var _arrayDivideMap:Array;
		protected var _bitmapCompleteMap:Bitmap;
		
		public function TileMap()
		{
		}
		
		/**
		 * Load the tilemap with string data and a tile graphic.
		 *
		 * @param	MapData	A string of comma and line-return delineated indices indicating what order the tiles should go in.
		 *
		 * @return	um objeto ,"objectMap.gridWidth <- tiles horizontais",
		 * "objectMap.gridHeight = heightInTiles <- tiles verticais",
		 * "objectMap.data = _data" <- Array de tiles
		 */
		public function loadMap(MapData:String):Object
		{
			var c:uint;
			var cols:Array;
			var rows:Array = MapData.split("\n");
			heightInTiles = rows.length;
			_data = new Array();
			for (var r:uint = 0; r < heightInTiles; r++)
			{
				cols = rows[r].split(",");
				if (cols.length <= 1)
				{
					heightInTiles--;
					continue;
				}
				if (widthInTiles == 0)
					widthInTiles = cols.length;
				
				for (c = 0; c < widthInTiles; c++)
					_data.push(uint(cols[c]));
				
			}
			_dataMap = new Vector.<int>();
			for (var i:int = 0; i < _data.length; i++)
			{
				_dataMap.push(_data[i])
			}
			return {dataMap: _dataMap, widthInTiles: widthInTiles, heightInTiles: heightInTiles}
		}
		
		/**
		 * Monta a imagem do tilemap
		 * @param	bitmap Imagem com os tiles
		 * @param	tileWidth Largura dos tiles
		 * @param	tileHeight Altura dos tiles
		 * @return
		 */
		public function cutImage(bitmap:Bitmap, tileWidth:uint, tileHeight:uint):void
		{
			this.tileHeight = tileHeight;
			this.tileWidth = tileWidth;
			arrayBitMaps = new Array();
			var mapa:BitmapData = bitmap.bitmapData;
			var cutRect:Rectangle = new Rectangle(0, 0, tileWidth, tileHeight);
			var colums:uint = mapa.height / tileHeight;
			var lines:uint = mapa.width / tileWidth;
			if (arrayMultiBitMaps == null || arrayMultiBitMaps.length <= 0)
				arrayMultiBitMaps = new Array();
			var tempArrayBits:Array = new Array;
			for (var i:int = 0; i < colums; i++)
			{
				for (var j:int = 0; j < lines; j++)
				{
					
					cutRect.x = tileWidth * j;
					cutRect.y = tileHeight * i;
					
					var tempBitData:BitmapData = new BitmapData(tileWidth, tileHeight);
					tempBitData.copyPixels(mapa, cutRect, new Point(0, 0));
					
					var tempBitmap:Bitmap = new Bitmap(tempBitData, "auto", true);
					tempArrayBits.push(tempBitmap);
				}
			}
			
			arrayMultiBitMaps.push(tempArrayBits);
		}
		
		/**
		 * Corta mais de um mapa e armazena em um array
		 * @param	multipleMaps
		 * @param	tileWidth
		 * @param	tileHeight
		 */
		public function cutMultiples(multipleMaps:Array, tileWidth:uint, tileHeight:uint):void
		{
			this.tileHeight = tileHeight;
			this.tileWidth = tileWidth;
			arrayMultiBitMaps = new Array();
			var it:int = 0;
			for each (var item:Bitmap in multipleMaps)
			{
				var tempArrayBits:Array = new Array;
				var mapa:BitmapData = item.bitmapData;
				var cutRect:Rectangle = new Rectangle(0, 0, tileWidth, tileHeight);
				var colums:uint = mapa.height / tileHeight;
				var lines:uint = mapa.width / tileWidth;
				
				for (var i:int = 0; i < colums; i++)
				{
					for (var j:int = 0; j < lines; j++)
					{
						
						cutRect.x = tileWidth * j;
						cutRect.y = tileHeight * i;
						
						var tempBitData:BitmapData = new BitmapData(tileWidth, tileHeight);
						tempBitData.copyPixels(mapa, cutRect, new Point(0, 0));
						
						var tempBitmap:Bitmap = new Bitmap(tempBitData, "auto", true);
						tempArrayBits.push(tempBitmap);
					}
				}
				arrayMultiBitMaps.push(tempArrayBits)
			}
		}
		
		/**
		 * Monta a imagem
		 * Deve ser chamada após a função "cutImage"
		 * Esta só funciona se o tilemap já tiver sido cortado
		 * @return
		 */
		public function buildImage():void
		{
			//trace("arrayMultiBitMaps : " + arrayMultiBitMaps);
			//trace( "buildImage : " + buildImage );
			_arrayTiles = new Array();
			var acum:int = 0;
			var acumNewContainer:int = 0;
			var container:Sprite = new Sprite
			arrayBitMaps = arrayMultiBitMaps[0]
			var tempContainer:Sprite = new Sprite;
			for (var i:int = 0; i < heightInTiles; i++)
			{
				for (var j:int = 0; j < widthInTiles; j++)
				{
					
					if (acum >= _dataMap.length)
						break
					
					var tempTile:Bitmap = ImageManipulation.copyBitmap(arrayBitMaps[_dataMap[acum]]);
					//trace( "_dataMap[i] : " + _dataMap[i] );
					
					tempTile.x = tileWidth * j
					tempTile.y = tileHeight * i
					//trace(i,j)
					container.addChild(tempTile)					
					//_arrayTiles.push(tempTile);
					
					acum++
				}
			}
			addChild(container)
			_scope = new Sprite();
			_bitmapCompleteMap = ImageManipulation.displayObjectToBitmap(container)
			_scope.addChild(ImageManipulation.copyBitmap(_bitmapCompleteMap))
			//ApplicationModel.stage.addChild(_scope)
		
		}
		
		/**
		 *Atualiza a imagem do tilemap
		 */
		public function updateMap():void
		{
			removeChild(_scope);
			buildImage()
		}
		
		/**
		 * Retorna o escopo, onde está o tilemap
		 */
		public function get scope():Sprite
		{
			return _scope;
		}
	
	}

}