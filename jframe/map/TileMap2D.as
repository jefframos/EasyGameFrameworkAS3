package jframe.map {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * ...
	 * @author Jefferson Ramos
	 */
	public class TileMap2D {
		private var _data:Array;
		private var heightInTiles:uint;
		private var widthInTiles:uint;

		public function TileMap2D(){
		}

		/**
		 * Load the tilemap with string data and a tile graphic.
		 *
		 * @param	MapData			A string of comma and line-return delineated indices indicating what order the tiles should go in.
		 *
		 * @return	um objeto ,"objectMap.gridWidth <- tiles horizontais",
		 * "objectMap.gridHeight = heightInTiles <- tiles verticais",
		 * "objectMap.data = _data" <- Array de tiles
		 */
		public function loadMap(MapData:String):Object {

			//Figure out the map dimensions based on the data string
			var c:uint;
			var cols:Array;
			var rows:Array = MapData.split("\n");
			heightInTiles = rows.length;
			_data = new Array();
			for (var r:uint = 0; r < heightInTiles; r++){
				cols = rows[r].split(",");
				if (cols.length <= 1){
					heightInTiles--;
					continue;
				}
				if (widthInTiles == 0)
					widthInTiles = cols.length;

				for (c = 0; c < widthInTiles; c++)
					_data.push(uint(cols[c]));

			}

			var objectMap:Object = new Object();
			objectMap.gridWidth = widthInTiles
			objectMap.gridHeight = heightInTiles
			objectMap.data = _data

			return objectMap

		}

		public function cutImage(bitMap:Bitmap, tileWidth:uint, tileHeight:uint):Array {
			var arrayBitMaps:Array = new Array();
			var mapa:BitmapData = bitMap.bitmapData;
			var cutRect:Rectangle = new Rectangle(0, 0, tileWidth, tileHeight);
			var colums:uint = mapa.height / tileHeight;
			var lines:uint = mapa.width / tileWidth;

			for (var i:int = 0; i < colums; i++){
				for (var j:int = 0; j < lines; j++){

					cutRect.y = tileWidth * i;
					cutRect.x = tileHeight * j;

					var tempBitData:BitmapData = new BitmapData(tileWidth, tileHeight);
					tempBitData.copyPixels(mapa, cutRect, new Point(0, 0));
					
					var tempBitmap:Bitmap = new Bitmap(tempBitData, "auto", true);
					arrayBitMaps.push(tempBitmap);
				}
			}
			return arrayBitMaps
		}

	}

}