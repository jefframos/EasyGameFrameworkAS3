package jframe.sound
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	/**
	 * ...
	 * @author Jeff
	 */
	public class SoundManager
	{
		
		// Todos os tipos de sons, você declara aqui
		
		private static var somAtual:Sound;
		//public static var VOLUME:Number = 1;		
		static private var soundChann:SoundChannel;
		static private var soundTransf:SoundTransform;
		static private var _varMute:Boolean = false;
		static private var soundTransfAmbiente:SoundTransform;
		static private var soundChannAmbiente:SoundChannel;
		static private var _somAmbiente:Sound;
		static private var _ambientSoundPosition:Number;
		static private var _ambientVolume:Number = -1;
		static private var _soundVolume:Number = -1;
		
		public function SoundManager()
		{
		
		}
		
		// Esse método será o responsável por reproduzir o som.
		// Perceba como esse método é "static", para que eu possa usá-lo sem a necessidade de instanciar a classe (assim como todos os tipos de sons que declarei lá em cima também são static por essa mesma razão!)
		public static function playSound(snd:Sound, loops:Number = 1):void
		{
			
			if (!_varMute)
			{
				somAtual = snd;
				
				if (_soundVolume < 0)
					_soundVolume = .5;
				// ".5" é o que controla de qual lado um som estéreo sairá. .5 seria o meio termo (sai o mesmo volume tanto do lado esquerdo, quanto do direito)
				soundTransf = new SoundTransform(_soundVolume, .5);
				soundChann = somAtual.play(0, loops);
				soundChann.soundTransform = soundTransf;
			}
		}
		
		public static function changeSoundAmbiente(_sound:Sound):Boolean
		{
			if (_somAmbiente != _sound)
			{
				
				if (soundChannAmbiente)
					soundChannAmbiente.stop();
				
				soundChannAmbiente = new SoundChannel()
				_somAmbiente = _sound
				
				return true
			}
			
			return false
		
		}
		
		// Esse método será o responsável por reproduzir o som.
		// Perceba como esse método é "static", para que eu possa usá-lo sem a necessidade de instanciar a classe (assim como todos os tipos de sons que declarei lá em cima também são static por essa mesma razão!)
		public static function playSoundAmbiente(id:int = 1):void
		{
			if (!_varMute)
			{
				if (soundChannAmbiente != null)
					soundChannAmbiente.stop();
				// ".5" é o que controla de qual lado um som estéreo sairá. .5 seria o meio termo (sai o mesmo volume tanto do lado esquerdo, quanto do direito)
				if (_ambientVolume < 0)
					_ambientVolume = .5;
				soundTransfAmbiente = new SoundTransform(_ambientVolume, .5);
				soundChannAmbiente = _somAmbiente.play(_ambientSoundPosition, int.MAX_VALUE);
				soundChannAmbiente.soundTransform = soundTransfAmbiente;
			}
		}
		
		public static function stopSoundAmbiente(id:int = 1):void
		{
			if (soundChannAmbiente)
			{
				soundChannAmbiente.stop();
				_ambientSoundPosition = 0;
			}
		}
		
		public static function mute():void
		{
			_varMute = true;
			if (soundChann)
				soundChann.stop();
			if (soundChannAmbiente)
			{
				_ambientSoundPosition = soundChannAmbiente.position;
				soundChannAmbiente.stop();
			}
		}
		
		public static function unmute(_loop:int = 1):void
		{
			_varMute = false;
			if (_somAmbiente != null)
				playSoundAmbiente();
		}
		
		static public function get varMute():Boolean
		{
			return _varMute;
		}
		
		static public function set soundVolume(value:Number):void
		{
			_soundVolume = value;
		}
		
		static public function set ambientVolume(value:Number):void
		{
			_ambientVolume = value;
			if (soundChannAmbiente != null)
			{
				soundChannAmbiente.soundTransform = new SoundTransform(_ambientVolume, .5);
			}
		}
		
		static public function get soundVolume():Number
		{
			return _soundVolume;
		}
		
		static public function get ambientVolume():Number
		{
			return _ambientVolume;
		}
	
	}
}
