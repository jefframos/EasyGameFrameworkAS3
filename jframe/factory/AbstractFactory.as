package jframe.factory
{
	import com.greensock.plugins.AutoAlphaPlugin;
	import com.greensock.plugins.TweenPlugin;
	import jframe.factory.background.BackgroundFactory;
	import jframe.factory.box.BoxFactory;
	import jframe.factory.button.ButtonFactory;
	import jframe.factory.input.InputFactory;
	import jframe.factory.label.LabelFactory;
	import jframe.factory.slider.SliderFactory;
	import jframe.factory.sound.SoundFactory;
	import jframe.factory.window.WindowFactory;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Jeff
	 */
	public class AbstractFactory
	{
		static public var IS_DEBUG:Boolean = false;
		private var _buttonFactory:ButtonFactory;
		private var _boxFactory:BoxFactory;
		private var _labelFactory:LabelFactory;
		private var _inputFactory:InputFactory;
		private var _windowFactory:WindowFactory;
		private var _backgroundFactory:BackgroundFactory;
		private var _soundFactory:SoundFactory;
		private var _sliderFactory:SliderFactory;
		
		public function AbstractFactory()
		{
			TweenPlugin.activate([AutoAlphaPlugin])
		}
		
		public function get buttonFactory():ButtonFactory
		{
			if (_buttonFactory == null && IS_DEBUG)
				trace("buttonFactory não implementado nessa Factory");
			return _buttonFactory;
		}
		
		public function set buttonFactory(value:ButtonFactory):void
		{
			_buttonFactory = value;
		}
		
		public function get boxFactory():BoxFactory
		{
			if (_boxFactory == null && IS_DEBUG)
				trace("boxFactory não implementado nessa Factory");
			return _boxFactory;
		}
		
		public function set boxFactory(value:BoxFactory):void
		{
			_boxFactory = value;
		}
		
		public function get labelFactory():LabelFactory
		{
			if (_labelFactory == null && IS_DEBUG)
				trace("labelFactory não implementado nessa Factory");
			return _labelFactory;
		}
		
		public function set labelFactory(value:LabelFactory):void
		{
			_labelFactory = value;
		}
		
		public function get inputFactory():InputFactory
		{
			if (_inputFactory == null && IS_DEBUG)
				trace("inputFactory não implementado nessa Factory");
			return _inputFactory;
		}
		
		public function set inputFactory(value:InputFactory):void
		{
			_inputFactory = value;
		}
		
		public function get windowFactory():WindowFactory
		{
			if (_windowFactory == null && IS_DEBUG)
				trace("windowFactory não implementado nessa Factory");
			return _windowFactory;
		}
		
		public function set windowFactory(value:WindowFactory):void
		{
			_windowFactory = value;
		}
		
		public function get backgroundFactory():BackgroundFactory
		{
			if (_backgroundFactory == null && IS_DEBUG)
				trace("_backgroundFactory não implementado nessa Factory");
			return _backgroundFactory;
		}
		
		public function set backgroundFactory(value:BackgroundFactory):void
		{
			_backgroundFactory = value;
		}
		
		public function get soundFactory():SoundFactory
		{
			if (_soundFactory == null && IS_DEBUG)
				trace("_soundFactory não implementado nessa Factory");
			return _soundFactory;
		}
		
		public function set soundFactory(value:SoundFactory):void
		{
			_soundFactory = value;
		}
		
		public function get sliderFactory():SliderFactory 
		{
			if (_sliderFactory == null && IS_DEBUG)
				trace("_sliderFactory não implementado nessa Factory");
			return _sliderFactory;
		}
		
		public function set sliderFactory(value:SliderFactory):void 
		{
			_sliderFactory = value;
		}
		
		public function clone():Object
		{
			return null;
		}
		
		public function redraw(parent:DisplayObjectContainer):void
		{
			for (var i:int = 0; i < parent.numChildren; i++)
			{
				if (parent.getChildAt(i) is DisplayObjectContainer)
				{
					var obj:DisplayObjectContainer = DisplayObjectContainer(parent.getChildAt(i));
					if (obj is IAbstractFactory)
					{
						IAbstractFactory(obj).redraw(this);
					}					
					try
					{
						if (obj.numChildren > 0)
							redraw(obj);
					}
					catch (err:Error)
					{
						trace("Factory Redraw: " + err);
					}
				}
			}
		}
	}

}