package jframe.graphics.spriteSheet
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.system.System;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	/**
	 * ...
	 * @author Jeff
	 */
	public class SpriteSheet extends Sprite
	{
		static public const END_ANIMATION:String = "EndAnimation";
		private var _bitmap:Bitmap;
		private var _arrayBitMaps:Array;
		private var _imagemAtual:Bitmap;
		private var _arrayAnimacao:Array;
		private var _arrayTempos:Array;
		private var _animacaoAtual:Array;
		private var totFrames:uint;
		private var _frameAtual:uint;
		private var _labelAtual:String;
		private var _time:Number;
		private var _contentImage:Boolean = false;
		private var _paused:Boolean = false;
		private var _center:Boolean;
		private var _repeat:Boolean;
		private var _animaTimer:uint;
		
		public function SpriteSheet()
		{
		}
		
		/**
		 * Seta a imagem do sprite sheet
		 * @param	_bit
		 */
		public function setImage(_bit:Bitmap):void
		{
			_contentImage = true;
			_bitmap = _bit;
			this.addChild(_bitmap);
		}
		
		/**
		 * Seta a imagem do sprite sheet
		 * @param	_bit
		 */
		public function removeImage():void
		{
			_contentImage = false;
			this.removeChild(_bitmap);
			_bitmap = null;
		}
		
		/**
		 * Corta a imagem em vários tiles
		 * @param	tileWidth Width
		 * @param	tileHeight Height
		 */
		public function cutImages(tileWidth:int, tileHeight:int, center:Boolean = false):void
		{
			this._center = center;
			_arrayBitMaps = new Array();
			if (!tileWidth || !tileHeight)
			{
				_arrayBitMaps.push(_bitmap);
				return;
			}
			
			var mapa:BitmapData = _bitmap.bitmapData;
			var cutRect:Rectangle = new Rectangle(0, 0, tileWidth, tileHeight);
			var colums:uint = mapa.height / tileHeight;
			var lines:uint = mapa.width / tileWidth;
			
			/**
			 * Corta a imagem e coloca num array
			 */
			for (var i:int = 0; i < colums; i++)
			{
				for (var j:int = 0; j < lines; j++)
				{
					
					cutRect.x = tileWidth * j;
					cutRect.y = tileHeight * i;
					
					var tempBitData:BitmapData = new BitmapData(tileWidth, tileHeight);
					tempBitData.copyPixels(mapa, cutRect, new Point(0, 0));
					
					var tempBitmap:Bitmap = new Bitmap(tempBitData, "auto", true);
					if (center)
					{
						tempBitmap.x -= tempBitmap.width / 2;
						tempBitmap.y -= tempBitmap.height / 2;
					}
					_arrayBitMaps.push(tempBitmap);
				}
			}
			setFrame(-1);
		}
		
		/**
		 * Pausa a animação
		 */
		public function pause():void
		{
			clearInterval(_animaTimer);
		}
		
		/**
		 * Despausa a animação
		 */
		public function unpause():void
		{
			clearInterval(_animaTimer);
			_animaTimer = setInterval(animaNext, _time * 1000)
		}
		
		/**
		 * Seta o bitmap
		 * @param	bit
		 */
		public function setFrame(frame:int):void
		{
			for (var i:int = 0; i < numChildren; i++)
			{
				removeChildAt(i);
			}
			if (frame < 0)
				_imagemAtual = new Bitmap()
			else
				_imagemAtual = _arrayBitMaps[frame];
			
			addChild(_imagemAtual);
		}
		
		/**
		 * Adiciona uma animação
		 * @param	label o nome da animação
		 * @param	frames o array com os frames
		 * @param	time é o tempo da troca de frames
		 */
		public function addAnimation(label:String, frames:Array, time:Number = 1):void
		{
			if (_arrayAnimacao == null)
				_arrayAnimacao = new Array();
			if (_arrayTempos == null)
				_arrayTempos = new Array();
			
			for (var i:int = 0; i < frames.length; i++)
			{
				var tempArray:Array = new Array();
				tempArray.push(_arrayBitMaps[frames[i]]);
			}
			_arrayAnimacao[label] = frames
			_arrayTempos[label] = time;
		}
		
		/**
		 * Inicia a animação
		 * @param	label
		 */
		public function play(label:String, repeat:Boolean, force:Boolean = false):void
		{
			if ((label != _labelAtual) || force)
			{
				this._repeat = repeat;
				_labelAtual = label;
				_animacaoAtual = _arrayAnimacao[label];
				_time = _arrayTempos[label];
				totFrames = _animacaoAtual.length;
				_frameAtual = 0;
				clearInterval(_animaTimer);
				_animaTimer = setInterval(animaNext, _time * 1000)
				animaNext();
			}
		}
		
		/**
		 * Troca o frame
		 */
		public function animaNext():void
		{
			_paused = false;
			setFrame(_animacaoAtual[_frameAtual]);
			_frameAtual++;
			if (_frameAtual >= totFrames)
			{
				dispatchEvent(new Event(END_ANIMATION));
				_frameAtual = 0;
				if (!_repeat)
				{
					_paused = true;
				}
			}
		}
		
		/**
		 * Para a animação
		 * @param	label
		 */
		public function stop(label:String, frame:uint):void
		{
			try
			{
				clearInterval(_animaTimer);
				_paused = true;
				setFrame(_arrayAnimacao[label][frame]);
			}
			catch (err:Error)
			{
				trace("stopError : " + err);
			}
		}
		
		public function getAnimation(label:String):Array
		{
			return _arrayAnimacao[label]
		}
		
		public function update():void
		{
			//throw("criar um autoupdate");
		}
		
		public function disposeAnimations():void
		{
			_arrayAnimacao = new Array
		}
		
		public function get bitmap():Bitmap
		{
			return _bitmap;
		}
		
		public function set bitmap(value:Bitmap):void
		{
			_bitmap = value;
		}
		
		public function get imagemAtual():Bitmap
		{
			return _imagemAtual;
		}
		
		public function get arrayBitMaps():Array
		{
			return _arrayBitMaps;
		}
		
		public function get contentImage():Boolean
		{
			return _contentImage;
		}
		
		public function get paused():Boolean
		{
			return _paused;
		}
		
		public function set paused(value:Boolean):void
		{
			_paused = value;
		}
		
		public function get labelAtual():String
		{
			return _labelAtual;
		}
		
		public function get frameAtual():uint
		{
			return _frameAtual;
		}
		
		public function get center():Boolean
		{
			return _center;
		}
	
	}

}
