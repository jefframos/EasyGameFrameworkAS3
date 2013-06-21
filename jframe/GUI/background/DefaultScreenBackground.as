package jframe.GUI.background
{
	import application.ApplicationConfig;
	import factory.AbstractFactory;
	import factory.IAbstractFactory;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import jframe.image.ImageManipulation;
	
	/**
	 * ...
	 * @author Jeff
	 */
	public class DefaultScreenBackground extends Sprite implements IAbstractFactory
	{
		private var _factory:AbstractFactory;
		private var _background:Sprite;
		
		public function DefaultScreenBackground(absFactory:AbstractFactory)
		{
			this._factory = absFactory;
			build();
		}
		
		/* INTERFACE factory.IAbstractFactory */
		
		public function redraw(absFactory:AbstractFactory):void
		{
			this._factory = absFactory;
			if (_background != null && _background.stage)
				this.removeChild(_background);
			
			build();
		}
		
		public function build():void
		{
			if (_factory.backgroundFactory != null)
			{
				if (_factory.backgroundFactory.randomBackgrounds.length > 0)
				{
					_background = new Sprite();
					var rnd:uint = _factory.backgroundFactory.randomBackgrounds.length * Math.random()
					//trace( "rnd : " + rnd );
					if (rnd > _factory.backgroundFactory.randomBackgrounds.length - 1)
						rnd = _factory.backgroundFactory.randomBackgrounds.length - 1;
					var bgBmp:Bitmap;
					if (_factory.backgroundFactory.randomBackgrounds[rnd] is Bitmap)
					{
						bgBmp = ImageManipulation.copyBitmap(Bitmap(_factory.backgroundFactory.randomBackgrounds[rnd]));
						bgBmp.smoothing = true;
					}
					else
						bgBmp = ImageManipulation.copyBitmap(ImageManipulation.displayObjectToBitmap(_factory.backgroundFactory.randomBackgrounds[rnd]))
					
					_background.addChild(bgBmp);
					addChild(_background)
					
				}
				if (this.width < ApplicationConfig.resolution.x)
					this.width = ApplicationConfig.resolution.x;
				
				if (this.height < ApplicationConfig.resolution.y)
					this.height = ApplicationConfig.resolution.y;
			}
		}
	
	}

}