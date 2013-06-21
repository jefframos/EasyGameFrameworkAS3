package jframe.image
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Jefferson Ramos
	 */
	public class ImageManipulation
	{
		
		public function ImageManipulation()
		{
		
		}
		
		/**
		 * Faz um silples ThresHold apenas enviando uma imagem
		 * @param	imagem
		 * @return
		 */
		public static function simpleThresHold(imagem:BitmapData):BitmapData
		{
			var tempBit:BitmapData = new BitmapData(imagem.width, imagem.height)
			tempBit.copyPixels(imagem, imagem.rect, new Point());
			tempBit.threshold(tempBit, tempBit.rect, new Point(), ">=", 0xffefefef, 0x00000000, 0xffffffff, true);
			return tempBit;
		}
		
		/**
		 * Troca um range de cores específicas de um bitmapData
		 * @param	bitmapData É o BitmapData da imagem que será ultilizada
		 * @param	color1 ARGB da primeira cor do range de comparação
		 * @param	color2 ARGB da segunda cor do range de comparação
		 * @param	swapColor ARGB da cor que vai trocar
		 * @return
		 */
		public static function swapColors(bitmapData:BitmapData, color1:uint, color2:uint, swapColor:uint):BitmapData
		{
			var vecCores:Vector.<uint> = bitmapData.getVector(bitmapData.rect);
			var n:int = bitmapData.width * bitmapData.height;
			for (var i:int = 0; i < vecCores.length; i++)
			{
				var color:uint = vecCores[i];
				if (color > color1 && color <= color2)
				{
					color = swapColor
				}
				vecCores[i] = color;
				
			}
			bitmapData.setVector(bitmapData.rect, vecCores);
			
			return bitmapData;
		}
		
		/**
		 * Faz uma cópia do bitmap
		 * @param	bitmap que será copiado
		 * @return cópia do bitmap
		 */
		public static function copyBitmap(imagem:Bitmap):Bitmap
		{
			try
			{
				var tempBitmapData:BitmapData = new BitmapData(imagem.width, imagem.height);
				tempBitmapData.copyPixels(imagem.bitmapData, imagem.bitmapData.rect, new Point(), null, null, false);
				var returnBitmap:Bitmap = new Bitmap(tempBitmapData, "auto", false)
				return returnBitmap;
			}
			catch (err:Error)
			{
				trace("copyBitmap error : " + err);
			}
			return new Bitmap
		}
		
		/**
		 * Faz uma copia de um display objet qualquer
		 * @param	displ DisplayObject que será copiado
		 * @param	center indica que o display object está centralizado
		 * @return retorna a cópia do display object
		 */
		public static function displayObjectToBitmap(displ:*, center:Boolean = false):Bitmap
		{
			displ as DisplayObject;
			var matrix:Matrix = null;
			if (center)
			{
				matrix = new Matrix(1, 0, 0, 1, displ.width / 2, displ.height / 2)
			}
			if (displ.width + displ.height > 0)
			{
				var tempBitmapData:BitmapData = new BitmapData(displ.width, displ.height, true, 0xffffff);
				tempBitmapData.draw(displ, matrix);
				var returnBitmap:Bitmap = new Bitmap(tempBitmapData, "auto", false)
				return returnBitmap;
			}
			return null
		
		}
	
	}

}