package jframe.GUI.button
{
	import com.greensock.data.ColorMatrixFilterVars;
	import com.greensock.easing.Cubic;
	import com.greensock.easing.Linear;
	import com.greensock.plugins.TransformMatrixPlugin;
	import com.greensock.plugins.TweenPlugin;
	import com.greensock.TimelineMax;
	import com.greensock.TweenMax;
	import com.greensock.TweenNano;
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Matrix3D;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.geom.Vector3D;
	import flash.media.Sound;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import jframe.factory.AbstractFactory;
	import jframe.factory.button.ButtonFactory;
	import jframe.factory.IAbstractFactory;
	import jframe.GUI.button.transitionProps.FloatTransitionProps;
	import jframe.GUI.button.transitionProps.TransitionProps;
	import jframe.image.ImageManipulation;
	import jframe.sound.SoundManager;
	import jframe.util.PositionUtil;
	
	/**
	 * ...
	 * @author Jeff
	 */
	public class DefaultButton extends Sprite implements IAbstractFactory
	{
		private var _scale:Number;
		private var timeline:TimelineMax;
		private var auxContainer:Sprite;
		private var initMotionPoint:Point;
		private var shapeFront:Shape;
		private var _labelSize:int;
		private var _enabled:Boolean;
		static public const ROUND:String = "round";
		static public const SQUARE:String = "square";
		protected var _returnFunction:Object;
		protected var _type:String;
		protected var _clickFunction:Function;
		protected var _upState:Sprite;
		protected var _overState:Sprite;
		protected var _textLabel:String;
		protected var _textFieldLabel:TextField;
		protected var _over:Boolean;
		protected var _margin:Point;
		protected var _sizeType:String;
		protected var _transition:String;
		protected var _factory:AbstractFactory;
		protected var _fixedSize:Point;
		protected var _soundOver:Sound;
		protected var _soundOut:Sound;
		protected var _transitionProps:TransitionProps;
		
		public function DefaultButton(absFactory:AbstractFactory, textLabel:String = "", _fixedSize:Point = null, _clickFunction:Function = null, _returnFunction:Object = null, _type:String = "null")
		{
			this._type = _type;
			this._enabled = true;
			this._returnFunction = _returnFunction;
			this._clickFunction = _clickFunction;
			this._fixedSize = _fixedSize;
			this._factory = absFactory;
			_textLabel = textLabel;
			this.addEventListener(MouseEvent.CLICK, callClickFunction);
			_scale = 1;
			TweenPlugin.activate([TransformMatrixPlugin])
			build();
		}
		
		public function fix():void
		{
			if (_transitionProps == null)
			{
				if (_transition == ButtonFactory.FLOAT_TRANSITIONS)
				{
					_transitionProps = new FloatTransitionProps();
					FloatTransitionProps(_transitionProps).maxSteps = 5;
					FloatTransitionProps(_transitionProps).step = int(FloatTransitionProps(_transitionProps).maxSteps * Math.random());
					FloatTransitionProps(_transitionProps).incress = Math.random() > .5 ? 1 : -1;
					FloatTransitionProps(_transitionProps).maxZAngle = 10;
					_transitionProps.initPos = new Point(this.x, this.y);
				}
			}
		}
		
		public function redraw(absFactory:AbstractFactory):void
		{
			this._factory = absFactory;
			removeChild(_upState);
			removeChild(_overState);
			if (_textFieldLabel)
				removeChild(_textFieldLabel);
			
			this.removeEventListener(MouseEvent.ROLL_OVER, mouseHandler);
			this.removeEventListener(MouseEvent.ROLL_OUT, mouseHandler);
			
			this.filters = [];
			_soundOver = _factory.soundFactory.buttonOver;
			build()
		}
		
		public function build():void
		{
			if (_type == "null")
			{
				_type = SQUARE;
			}
			
			if (_type == SQUARE)
			{
				_upState = new _factory.buttonFactory.buttonUpState;
				_overState = new _factory.buttonFactory.buttonOverState;
			}
			else
			{
				_upState = new _factory.buttonFactory.buttonRoundUpState;
				_overState = new _factory.buttonFactory.buttonRoundOverState;
			}
			
			if (_factory.soundFactory)
			{
				if (_factory.soundFactory.buttonOver)
					_soundOver = _factory.soundFactory.buttonOver;
				
				if (_factory.soundFactory.buttonOut)
					_soundOut = _factory.soundFactory.buttonOut;
			}
			
			_textFieldLabel = new TextField();
			_textFieldLabel.embedFonts = true;
			_textFieldLabel.antiAliasType = AntiAliasType.ADVANCED;
			_textFieldLabel.defaultTextFormat = _factory.buttonFactory.textFormat;
			_textFieldLabel.mouseEnabled = false;
			_textFieldLabel.text = _textLabel;
			_textFieldLabel.textColor = _factory.buttonFactory.colorUp;
			
			if (_factory.buttonFactory.textFilters.length > 0)
				_textFieldLabel.filters = _factory.buttonFactory.textFilters;
			
			if (_factory.buttonFactory.buttonFilters.length > 0)
				this.filters = _factory.buttonFactory.textFilters;
			
			_margin = _factory.buttonFactory.margin;
			_sizeType = _factory.buttonFactory.sizeType;
			_transition = _factory.buttonFactory.transition;
			
			if (_sizeType == ButtonFactory.TEXT_AUTO_SIZE)
			{
				_textFieldLabel.autoSize = TextFieldAutoSize.LEFT;
				
				_upState.width = _textFieldLabel.width + _margin.x * 2;
				_upState.height = _textFieldLabel.height + _margin.y * 2;
				
				_overState.width = _textFieldLabel.width + _margin.x * 2;
				_overState.height = _textFieldLabel.height + _margin.y * 2;
				_overState.x = 0;
				_overState.y = 0;
				
				_textFieldLabel.x = _upState.width / 2 - _textFieldLabel.width / 2;
				_textFieldLabel.y = _upState.height / 2 - _textFieldLabel.height / 2;
				
				PositionUtil.centerByObject(_textFieldLabel, _overState)
			}
			if (_fixedSize)
			{
				if (_fixedSize.x > 0)
				{
					_overState.width = _upState.width = _fixedSize.x;
					_textFieldLabel.x = _upState.width / 2 - _textFieldLabel.width / 2;
				}
				if (_fixedSize.y > 0)
				{
					_overState.height = _upState.height = _fixedSize.y;
					_textFieldLabel.y = _upState.height / 2 - _textFieldLabel.height / 2;
				}
			}
			_over = false;
			
			addChild(_upState);
			addChild(_overState);
			addChild(_textFieldLabel);
			shapeFront = new Shape();
			shapeFront.graphics.beginFill(0, 0);
			shapeFront.graphics.drawRect(0, -10, _overState.width, _overState.height + 20);
			//shapeFront.x = 
			
			_overState.alpha = 0;
			
			this.buttonMode = true;
			
			this.addEventListener(MouseEvent.ROLL_OVER, mouseHandler);
			this.addEventListener(MouseEvent.ROLL_OUT, mouseHandler);
			
			PositionUtil.centerByObject(_textFieldLabel, _overState)
		
		}
		
		public function get enabled():Boolean
		{
			return _enabled;
		}
		
		public function set enabled(value:Boolean):void
		{
			_enabled = value;
			if (!_enabled)
			{
				this.removeEventListener(MouseEvent.CLICK, callClickFunction);
				this.removeEventListener(MouseEvent.ROLL_OVER, mouseHandler);
				this.removeEventListener(MouseEvent.ROLL_OUT, mouseHandler);
				this.mouseEnabled = false;
				this.mouseChildren = false;
				if (_textFieldLabel != null)
					_textFieldLabel.alpha = .3;
					//this.alpha = .8;
			}
			else
			{
				this.removeEventListener(MouseEvent.CLICK, callClickFunction);
				this.removeEventListener(MouseEvent.ROLL_OVER, mouseHandler);
				this.removeEventListener(MouseEvent.ROLL_OUT, mouseHandler);
				this.addEventListener(MouseEvent.CLICK, callClickFunction);
				this.addEventListener(MouseEvent.ROLL_OVER, mouseHandler);
				this.addEventListener(MouseEvent.ROLL_OUT, mouseHandler);
				this.mouseEnabled = true;
				this.mouseChildren = true;
				if (_textFieldLabel != null)
					_textFieldLabel.alpha = 1;
					//this.alpha = 1;
			}
		
		}
		
		private function callClickFunction(e:MouseEvent):void
		{
			if (_clickFunction != null)
			{
				if (_returnFunction != null)
					_clickFunction(_returnFunction)
				else
					_clickFunction()
			}
		}
		
		private function mouseHandler(e:MouseEvent):void
		{
			
			//addEventListener(Event.ENTER_FRAME, initFloatButton);
			if (e.type == MouseEvent.ROLL_OVER)
			{
				if (_soundOver)
					SoundManager.playSound(_soundOver);
				TweenNano.to(this, .2, {scaleX: _scale, scaleY: _scale});
				_over = true;
				if (_transition == ButtonFactory.ALPHA_TRANSITIONS)
				{
					TweenNano.to(_overState, _factory.buttonFactory.timeTransition, {alpha: 1});
					TweenNano.to(_upState, _factory.buttonFactory.timeTransition, {delay: _factory.buttonFactory.timeTransition / 2, alpha: 0});
					_textFieldLabel.textColor = _factory.buttonFactory.colorOver;
					
				}
				else if (_transition == ButtonFactory.FLOAT_TRANSITIONS)
				{
					
					_overState.alpha = 1;
					_upState.alpha = 0;
					initMotionPoint = new Point(this.x, this.y)
					
					auxContainer = new Sprite();
					var tempBmp:Bitmap = ImageManipulation.displayObjectToBitmap(this)
					this.parent.addChild(auxContainer);
					this.x = -this.width / 2
					this.y = -this.height / 2
					auxContainer.addChild(this)
					auxContainer.x = initMotionPoint.x + this.width / 2
					auxContainer.y = initMotionPoint.y + this.height / 2
					
					timelineFloat()
					
					if (shapeFront.parent == null)
						addChild(shapeFront)
					
					this.filters = [new DropShadowFilter(3, 45, 0, .3)];
					_textFieldLabel.textColor = _factory.buttonFactory.colorOver;
					
				}
				else
				{
					_overState.alpha = 1;
					_upState.alpha = 0;
				}
				
			}
			else if (e.type == MouseEvent.ROLL_OUT)
			{
				if (_soundOut)
					SoundManager.playSound(_soundOut);
				TweenNano.to(this, .2, {scaleX: _scale, scaleY: _scale});
				_over = false;
				if (_transition == ButtonFactory.ALPHA_TRANSITIONS)
				{
					TweenNano.to(_overState, _factory.buttonFactory.timeTransition, {delay: _factory.buttonFactory.timeTransition / 2, alpha: 0});
					TweenNano.to(_upState, _factory.buttonFactory.timeTransition, {alpha: 1});
					_textFieldLabel.textColor = _factory.buttonFactory.colorUp;
				}
				else if (_transition == ButtonFactory.FLOAT_TRANSITIONS)
				{
					_overState.alpha = 0;
					_upState.alpha = 1;
					
					//auxContainer = new Sprite();
					timeline.kill();
					timeline = null;
					auxContainer.parent.addChild(this)
					this.x = initMotionPoint.x
					this.y = initMotionPoint.y
					auxContainer = null;
					this.filters = [];
					
					if (shapeFront.parent != null)
						shapeFront.parent.removeChild(shapeFront)
					
					FloatTransitionProps(_transitionProps).step = int(FloatTransitionProps(_transitionProps).maxSteps * Math.random());
					FloatTransitionProps(_transitionProps).incress = Math.random() > .5 ? 1 : -1;
				}
				else
				{
					_overState.alpha = 0;
					_upState.alpha = 1;
				}
			}
		}
		
		private function timelineFloat():void
		{
			var zangle:Number = FloatTransitionProps(_transitionProps).maxZAngle * FloatTransitionProps(_transitionProps).step / FloatTransitionProps(_transitionProps).maxSteps - FloatTransitionProps(_transitionProps).maxZAngle / 2
			trace(zangle);
			timeline = new TimelineMax({repeat: 1, yoyo: true, ease: Cubic.easeInOut, onComplete: timelineFloat});
			timeline.append(TweenMax.to(auxContainer, _factory.buttonFactory.timeTransition, {y: initMotionPoint.y + 25, rotationX: 20 + (Math.random() * 5), rotationZ: zangle}));
			timeline.play()
			
			FloatTransitionProps(_transitionProps).step += FloatTransitionProps(_transitionProps).incress;
			if (FloatTransitionProps(_transitionProps).step > FloatTransitionProps(_transitionProps).maxSteps || FloatTransitionProps(_transitionProps).step < 0)
				FloatTransitionProps(_transitionProps).incress *= -1;
		}
		
		public function changeLabelSize(value:Number):void
		{
			_labelSize = value;
			var f:TextFormat = _textFieldLabel.getTextFormat();
			f.size = value;
			_textFieldLabel.setTextFormat(f);
			//if (_fixedSize != null)
			//{
			//if (_overState != null)
			//{
			//_overState.width = _fixedSize.x;
			//_overState.height = _fixedSize.y;
			//}
			//_upState.width = _fixedSize.x;
			//_upState.height = _fixedSize.y;
			//}
			if (_sizeType == ButtonFactory.TEXT_AUTO_SIZE)
			{
				_textFieldLabel.autoSize = TextFieldAutoSize.LEFT;
				
				if (_fixedSize != null)
				{
					_upState.width = _fixedSize.x;
					_upState.height = _fixedSize.y;
				}
				else
				{
					_upState.width = _textFieldLabel.width + _margin.x * 2;
					_upState.height = _textFieldLabel.height + _margin.y * 2;
					
				}
				if (_overState != null)
				{
					if (_fixedSize != null)
					{
						_overState.width = _fixedSize.x;
						_overState.height = _fixedSize.y;
					}
					else
					{
						_overState.width = _textFieldLabel.width + _margin.x * 2;
						_overState.height = _textFieldLabel.height + _margin.y * 2;
					}
					_overState.x = -_overState.width / 2;
					_overState.y = 0;
				}
				
				_textFieldLabel.x = Math.round(_upState.width / 2 - _textFieldLabel.width / 2);
				_textFieldLabel.y = Math.round(_upState.height / 2 - _textFieldLabel.height / 2);
				
				_upState.x = 0 //-_upState.width / 2;
				
				//trace( "_textFieldLabel.y : " , _textFieldLabel.y);
				
				if (_overState != null)
					_overState.x = 0 //-_overState.width / 2;
				_textFieldLabel.x = -_textFieldLabel.width / 2;
				
				if (_overState != null)
					PositionUtil.centerByObject(_textFieldLabel, _overState)
			}
		
		}
		
		public function changeScale(_scale:Number):void
		{
			this._scale = _scale;
			this.scaleX = this.scaleY = _scale;
		}
		
		public function changeLabelAlignament(_align:String, _spacing:int = 0):void
		{
			var f:TextFormat = _textFieldLabel.getTextFormat();
			f.align = _align;
			_textFieldLabel.setTextFormat(f);
			
			if (_align == TextFormatAlign.LEFT)
				_textFieldLabel.x = _spacing
		}
		
		public function changeLabelText(string:String):void
		{
			_textFieldLabel.text = string;
		}
		
		public function chanceBackColor(object:uint):void
		{
			var ct:ColorTransform = new ColorTransform()
			ct.color = object;
			_upState.transform.colorTransform = ct;
		}
		
		public function removeListeners():void
		{
			this.removeEventListener(MouseEvent.CLICK, callClickFunction);
			this.removeEventListener(MouseEvent.ROLL_OVER, mouseHandler);
			this.removeEventListener(MouseEvent.ROLL_OUT, mouseHandler);
		}
		
		public function get factory():AbstractFactory
		{
			return _factory;
		}
		
		public function set factory(value:AbstractFactory):void
		{
			_factory = value;
		}
		
		public function set returnFunction(value:Object):void
		{
			_returnFunction = value;
		}
	
	}

}