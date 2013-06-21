package jframe.manager
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import jframe.layer.GameLayer;
	import jframe.layer.LayerManager;
	
	/**
	 * ...
	 * @author Jeff
	 */
	public class GameManager extends Sprite
	{
		static public const UPDATE_HEAD_UP:String = "updateHeadUp";
		private var _root:DisplayObject;
		private var _layerManager:LayerManager;
		private static var _stage:Stage;
		private static var _self:GameManager;
		private var _mask:Shape;
		private var _gameWidth:int;
		private var _gameHeight:int;
		protected var _pause:Boolean;
		
		public function GameManager(_root:DisplayObject, _gameWidth:int, _gameHeight:int, _layerManager:LayerManager = null, _backColor:uint = 0x000000, _setMask:Boolean = true)
		{
			this._gameHeight = _gameHeight;
			this._gameWidth = _gameWidth;
			this.addEventListener(Event.ADDED_TO_STAGE, addedStage)
			if (_layerManager == null)
				this._layerManager = new LayerManager();
			else
				this._layerManager = _layerManager;
			this._root = _root;
			this.scrollRect = new Rectangle(0, 0, _gameWidth, _gameHeight);
			
			if (_setMask)
			{
				_mask = new Shape
				_mask.graphics.beginFill(_backColor);
				_mask.graphics.drawRect(0, 0, _gameWidth, _gameHeight);
				this.addChild(_mask)
				this.mask = _mask
			}
			_self = this;
		
		}
		
		protected function addedStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedStage);
			_stage = this.stage;
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
		}
		
		/**
		 * Singleton
		 * @return
		 */
		public static function getInstance():GameManager
		{
			return _self;
		}
		
		/**
		 * Pausa o loop principal
		 */
		public function pauseGame():void
		{
			_pause = true;
			_root.removeEventListener(Event.ENTER_FRAME, update)
			if (_layerManager != null)
				_layerManager.pauseAllLayers();
		}
		
		/**
		 * Inicia o loop principal
		 */
		public function beginGame():void
		{
			
			_root.addEventListener(Event.ENTER_FRAME, update)
			if (_layerManager != null && _pause === true)
				_layerManager.unpauseAllLayers();
			
			_pause = false;
		}
		
		/**
		 * Atualiza as layers
		 * @param	e
		 */
		protected function update(e:Event):void
		{
			_layerManager.update();
		}
		public function destroy():void
		{
			pauseGame();
			_layerManager.destroyAllLayers();
		}
		/**
		 * Adiciona uma layer na layer manager
		 * @param	gameLayer
		 */
		public function addLayer(gameLayer:GameLayer):void
		{
			_layerManager.addLayer(gameLayer, gameLayer.layerName);
		}
		
		public function get layerManager():LayerManager
		{
			return _layerManager;
		}
		
		public static function get stage():Stage
		{
			return _stage;
		}
		
		public static function set stage(value:Stage):void
		{
			_stage = value;
		}
		
		public function get mainRoot():DisplayObject
		{
			return _root;
		}
		
		public function get gameWidth():int
		{
			return _gameWidth;
		}
		
		public function set gameWidth(value:int):void
		{
			_gameWidth = value;
		}
		
		public function get gameHeight():int
		{
			return _gameHeight;
		}
		
		public function set gameHeight(value:int):void
		{
			_gameHeight = value;
		}
	
	}

}