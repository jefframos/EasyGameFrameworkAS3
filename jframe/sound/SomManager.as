package jframe.sound
{
	import com.box3.models.SoundItemModel;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	/**
	 * ...
	 * @author Jeff
	 */
	public class SomManager
	{
		
		// Todos os tipos de sons, você declara aqui
		public static var SOM_WHIP:Sound = new somWhip();
		public static var SOM_AMBIENTE:Sound = new somAmbiente1();
		public static var SOM_AMBIENTE2:Sound = new somAmbiente2();
		public static var SOM_AMBIENTE3:Sound = new somAmbiente3();
		public static var SOM_CLICK:Sound = new somClick();
		public static var SOM_CAR:Sound = new somCar();
		public static var SOM_CAR_BREAK:Sound = new somCarBreak();
		static public const SOM_ASSOVIO:Sound = new somAssovio();
		static public const SOM_KILL:Sound = new somMorte();
		static public const SOM_PASSOS:Sound = new somPassos();
		static public const SOM_ALERT:Sound = new somAlert();
		static public const SOM_ACELERACAO:Sound = new somAceleracao();
		static public const SOM_SETA:Sound = new somSeta();
		static public const SOM_END:Sound = new somEndGame();
		//public static var SOM_OPENSCREEN:Sound = new somOpenScreen();
		
		private static var somAtual:Sound;
		
		public static var VOLUME:Number = 1;
		
		static private var soundChann:SoundChannel;
		static private var soundTransf:SoundTransform;
		static private var _varMute:Boolean = false;
		static private var soundTransfAmbiente:SoundTransform;
		static private var soundChannAmbiente:SoundChannel;
		static private var _somAmbiente:Sound;
		
		public function SomManager()
		{
		
		}
		
		// Esse método será o responsável por reproduzir o som.
		// Perceba como esse método é "static", para que eu possa usá-lo sem a necessidade de instanciar a classe (assim como todos os tipos de sons que declarei lá em cima também são static por essa mesma razão!)
		public static function playSound(snd:Sound, loops:Number = 1):void
		{
			
			if (!_varMute)
			{
				somAtual = snd;
				
				// ".5" é o que controla de qual lado um som estéreo sairá. .5 seria o meio termo (sai o mesmo volume tanto do lado esquerdo, quanto do direito)
				soundTransf = new SoundTransform(VOLUME, .5);
				soundChann = somAtual.play(0, loops);
				soundChann.soundTransform = soundTransf;
			}
		}
		
		public static function changeSoundAmbiente(_sound:Sound):void
		{
			{
				try
				{
					soundChannAmbiente.stop();
				}
				catch (err:Error)
				{
					
				}
				soundChannAmbiente = new SoundChannel()
				_somAmbiente = _sound
			}
		}
		
		// Esse método será o responsável por reproduzir o som.
		// Perceba como esse método é "static", para que eu possa usá-lo sem a necessidade de instanciar a classe (assim como todos os tipos de sons que declarei lá em cima também são static por essa mesma razão!)
		public static function playSoundAmbiente(id:int = 1):void
		{
			if (!_varMute)
			{
				// ".5" é o que controla de qual lado um som estéreo sairá. .5 seria o meio termo (sai o mesmo volume tanto do lado esquerdo, quanto do direito)
				soundTransfAmbiente = new SoundTransform(.4, .5);
				soundChannAmbiente = _somAmbiente.play(0, int.MAX_VALUE);
				soundChannAmbiente.soundTransform = soundTransfAmbiente;
			}
		}
		
		public static function mute():void
		{
			_varMute = true;
			if (soundChann)
				soundChann.stop();
			if (soundChannAmbiente)
				soundChannAmbiente.stop();
		}
		
		public static function unmute(_loop:int = 1):void
		{
			_varMute = false;
			playSoundAmbiente();
		}
		
		static public function get varMute():Boolean 
		{
			return _varMute;
		}
	
	}
}
