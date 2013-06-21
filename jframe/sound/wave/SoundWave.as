package jframe.sound.wave
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import flash.utils.setInterval;
	import flash.utils.Timer;
	import game.music.ContainerMusic;
	import game.testes.EdgePoint;
	import jframe.misc.CubicBezier;
	import jframe.misc.Hermite;
	import jframe.worlds.pointworld.PointWorld;
	
	/**
	 * ...
	 * @author Jeff
	 */
	public class SoundWave extends Sprite
	{
		private var _spectrumGraphic:Sprite
		private var _song:SoundChannel;
		private var _sound:Sound;
		private var _request:URLRequest;
		private var _url:String;
		private var _baSpec:ByteArray;
		private var time:Timer;
		private var timer2:uint;
		private var max:Number;
		private var _curves:Sprite
		private var _containerMusic:PointWorld
		private var _bezierLine:CubicBezier;
		private var max2:int;
		private var max3:int;
		private var player:LinePlayer;
		private var arryURLS:Array;
		
		public function SoundWave()
		{
			arryURLS = new Array
			_url = "Lady Gaga - Born this way - Yo&uuml; And I.mp3";
			arryURLS.push(_url)
			_url = "smb1-1.mp3";
			arryURLS.push(_url)
			
			_url = "Abril - O Que Te Faz Feliz_ - Noite.mp3";
			arryURLS.push(_url)
			_url = "Kids.mp3";
			arryURLS.push(_url)
			_url = "yoshi-s-jingle.mp3";
			arryURLS.push(_url)
			_url = "02 Franz Ferdinand - Do You Want To.mp3";
			arryURLS.push(_url)
			_url = "Electric Feel.mp3";
			arryURLS.push(_url)
			_url = "01-The Place I'll Return To Someday.mp3";
			arryURLS.push(_url)
			_url = "05 Sleep Now In The Fire.mp3";
			arryURLS.push(_url)
			_url = "black_eyed_peas.mp3";
			arryURLS.push(_url)
			addEventListener(Event.ADDED_TO_STAGE, addStage)
		
		}
		
		private function addStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, addStage);
			var temp:int = Math.random() * (arryURLS.length - 1)
			var tmpURL:String = arryURLS[0];
			_request = new URLRequest(tmpURL);
			_sound = new Sound();
			_sound.addEventListener(Event.COMPLETE, completeHandler);
			_sound.load(_request);
			_song = _sound.play();
			_song.addEventListener(Event.SOUND_COMPLETE, soundCompleteHandler);
			
			//_curves = new Sprite
			//_curves.y = 200;
			//_curves.x = -150
			//_curves.filters = [new GlowFilter(0x0099EE, 1, 5, 5)]
			//addChild(_curves)
			
			_containerMusic = new ContainerMusic
			
			_containerMusic.scaleX = 2
			_containerMusic.scaleY = 2
			
			_containerMusic.y = stage.stageHeight// / _containerMusic.scaleY;
			
			player = new LinePlayer(_containerMusic);
			player.y = -200
			player.x = stage.stageWidth / _containerMusic.scaleX;
			_containerMusic.addChild(player);
			
			
			
			addChild(_containerMusic)
			_containerMusic.filters = [new GlowFilter(0x0099EE, 1, 15, 15, 5, 3)]
			
			_baSpec = new ByteArray();
			
			//_spectrumGraphic = new Sprite();
			//_spectrumGraphic.y = stage.stageHeight - 200;
			//_spectrumGraphic.filters = [new GlowFilter(0x0099EE, 1, 25, 25)]
			//addChild(_spectrumGraphic);
			
			time = new Timer(500);
			time.addEventListener(TimerEvent.TIMER, timerHandler);
			time.start();
			
		//	this.y = 200
			
			timer2 = setInterval(interval, 250);
			
			this.addEventListener(Event.ENTER_FRAME, enterFrame)
		}
		
		private function enterFrame(e:Event):void
		{
			try
			{
				_containerMusic.update();
				if (player.y < 0)
				{
					//trace( "player.y : " + player.y );
					player.update()
				}
					//_containerMusic.graphics.moveTo(_curves.getChildAt(0).x, _curves.getChildAt(0).y);
				
					//for (var i:int = 1; i < _curves.numChildren; i++)
					//{	/**
					//* PLATAFORM LINEAR
					//*/
					//var firstPoint:Point = new Point(_curves.getChildAt(i).x, _curves.getChildAt(i).y)
					//var finalPoint:Point = new Point(_curves.getChildAt(i + 1).x, _curves.getChildAt(i + 1).y)
					//
					//var firstAnchor:Point = new Point(_curves.getChildAt(i).x, _curves.getChildAt(i).y)
					//var finalAnchor:Point = new Point(_curves.getChildAt(i).x, _curves.getChildAt(i).y)
					//
					//_containerMusic.graphics.lineTo(_curves.getChildAt(i + 1).x,_curves.getChildAt(i + 1).y)
					//
					///**
					//* PLATAFORM
					//*/
					//var firstPoint:Point = new Point(_curves.getChildAt(i-1).x, _curves.getChildAt(i-1).y)
					//var firstAnchor:Point = new Point((_curves.getChildAt(i).x, _curves.getChildAt(i).y))
					//var finalPoint:Point = new Point(_curves.getChildAt(i).x, _curves.getChildAt(i).y)
					//var finalAnchor:Point = new Point((_curves.getChildAt(i).x, _curves.getChildAt(i).y))
					//Hermite.makeCurve(firstPoint, finalPoint, firstAnchor, finalAnchor, _containerMusic);
					//
					///**
					//* CURVE
					//*/
					//var firstPoint:Point = new Point(_curves.getChildAt(i - 1).x, _curves.getChildAt(i - 1).y)
					//var firstAnchor:Point = new Point((_curves.getChildAt(i).x, _curves.getChildAt(i).y))
					//var finalPoint:Point = new Point(_curves.getChildAt(i).x, _curves.getChildAt(i).y)
					//var finalAnchor:Point = new Point((_curves.getChildAt(i).x, _curves.getChildAt(i).y))
					//Hermite.makeCurve(firstPoint, finalPoint, firstAnchor, finalAnchor, _containerMusic);
					//}
			}
			catch (err:Error)
			{
				
			}
		
		}
		
		private function interval():void
		{
			
			var obj:EdgePoint = new EdgePoint
			obj.y = -(max + max2 + max3) / 3 - obj.height;
			obj.x = -_containerMusic.x + stage.stageWidth/_containerMusic.scaleX + 50
			
			_containerMusic.addPoint(obj.x, obj.y)
			//trace( "max : " + max );
			//trace( "max3 : " + max3 );
			//trace( "max2 : " + max2 );
			_containerMusic.addChild(obj)
		
		}
		
		private function completeHandler(event:Event):void
		{
			Sound(event.target).play(0, 10);
		}
		
		private function soundCompleteHandler(event:Event):void
		{
			//time.stop();
		}
		
		private function timerHandler(event:TimerEvent):void
		{
			SoundMixer.computeSpectrum(_baSpec, true);
			var i:int;
			//_spectrumGraphic.graphics.clear();
			//_spectrumGraphic.graphics.beginFill(0x0099EE, .1);
			//_spectrumGraphic.graphics.moveTo(0, 0);
			var w:int = 3;
			var amplitude:Number = 80
			max = 0 //int.MIN_VALUE;
			
			max2 = 0 //int.MIN_VALUE;
			max3 = 0 //int.MIN_VALUE;
			var valueController:int = stage.stageWidth / 3
			//trace( "valueController : " + valueController );
			for (i = 0; i < stage.stageWidth; i += w)
			{
				var t:Number = _baSpec.readFloat();
				var n:Number = (t * amplitude);
				//_spectrumGraphic.graphics.drawRect(i, 0, w, -n);
				if (i < valueController)
				{
					//if (max < n)
					max += n;
				}
				else if (i < valueController * 2)
				{
					//if (max2 < n)
					max2 += n;
				}
				else
				{
					//if (max3 < n)
					max3 += n;
				}
			}
			max = max / valueController * 15
			max2 = max2 / valueController * 25
			max3 = max3 / valueController * 15
		
		}
	
	}
}