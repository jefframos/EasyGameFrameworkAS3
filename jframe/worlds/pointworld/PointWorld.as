package jframe.worlds.pointworld
{
	import flash.display.CapsStyle;
	import flash.display.GradientType;
	import flash.display.LineScaleMode;
	import flash.display.Shader;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.utils.ByteArray;
	import game.miniGames.minigameWaves.EdgePoint;
	
	/**
	 * ...
	 * @author Jeff
	 */
	public class PointWorld extends Sprite
	{
		protected var _scope:Sprite
		protected var _arrayPoints:Array;
		protected var _color:uint;
		protected var _velocity:int
		protected var _lineSize:int;
		protected var _lineColor:int;
		
		public function PointWorld()
		{
			//build()
			
		}
		
		public function build():void
		{
			_scope = new Sprite();
			_arrayPoints = new Array();
			addChild(_scope)
			_lineSize = 4;
			_lineColor = 0xFFFFFF;
		}
		
		public function update():void
		{
		
		}
		
		public function addPoint(_x:Number, _y:Number):void
		{
			_arrayPoints.push(new Point(_x + _scope.x, _y + _scope.y))
		}
		
		protected function draw():void
		{
			_scope.graphics.clear();
			_scope.graphics.lineStyle(_lineSize, _lineColor, 1, true, LineScaleMode.HORIZONTAL, CapsStyle.ROUND)
			
			if (_arrayPoints[0])
				_scope.graphics.moveTo(_arrayPoints[0].x, _arrayPoints[0].y);
			
			for (var i:int = 1; i < _arrayPoints.length; i++)
			{
				
				_scope.graphics.lineTo(_arrayPoints[i].x, _arrayPoints[i].y);
			}
		}
		
		/**
		 * retorna o ponto referente ao ponto que for passado
		 * @param	_refPoint
		 * @return
		 */
		public function getWorldPoint(_refPoint:Point):Point
		{
			for (var i:int = 0; i < _arrayPoints.length - 1; i++)
			{
				if (_refPoint.x > _arrayPoints[i].x && _refPoint.x < _arrayPoints[i + 1].x)
					return _arrayPoints[i]
			}
			return _arrayPoints[0]
		}
		
		/**
		 * Retorna o próximo ponto que possui elevação
		 * @param	_refPoint
		 * @return
		 */
		public function getFrontPoint(_refPoint:Point):Point
		{
			for (var i:int = 0; i < _arrayPoints.length - 1; i++)
			{
				if (_refPoint.x > _arrayPoints[i].x && _refPoint.x < _arrayPoints[i + 1].x)
					for (var j:int = i; j < _arrayPoints.length - 1; j++)
					{
						if (_arrayPoints[j].y != _arrayPoints[j + 1].y)
							return _arrayPoints[j + 1]
					}
			}
			return _arrayPoints[0]
		}
		
		/**
		 * Retorna o ponto de trás, que possui elevação
		 * @param	_refPoint
		 * @return
		 */
		public function getBackPoint(_refPoint:Point):Point
		{
			for (var i:int = _arrayPoints.length - 1; i >= 0; i--)
			{
				if (_refPoint.x > _arrayPoints[i].x && _refPoint.x < _arrayPoints[i + 1].x)
					for (var j:int = i; j >= 0; j--)
					{
						if (_arrayPoints[j].y != _arrayPoints[j + 1].y)
							return _arrayPoints[j]
					}
			}
			return _arrayPoints[0]
		}
		
		/**
		 * Retorna o ponto seguindo do que foi enviado
		 * @param	worldPoint
		 * @return
		 */
		public function getNextPoint(worldPoint:Point):Point
		{
			for (var i:int = 0; i < _arrayPoints.length - 1; i++)
			{
				if (_arrayPoints[i] == worldPoint)
				{
					return _arrayPoints[i + 1]
				}
			}
			return _arrayPoints[0]
		}
		
		public function addEdgePoint(obj:EdgePoint):void
		{
		
		}
		
		public function get scope():Sprite
		{
			return _scope;
		}
		
		public function get arrayPoints():Array
		{
			return _arrayPoints;
		}
		
		public function set velocity(value:int):void
		{
			_velocity = value;
		}
		
		public function get color():uint
		{
			return _color;
		}
		
		public function set color(value:uint):void
		{
			_color = value;
		}
	
	}

}