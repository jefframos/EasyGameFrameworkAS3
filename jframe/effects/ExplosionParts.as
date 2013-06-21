package jframe.effects 
{
	import flash.display.Bitmap;
	/**
	 * ...
	 * @author Jeff
	 */
	public class ExplosionParts 
	{
		private var _gravity:Number;
		private var _xVelocity:Number;
		private var _yVelocity:Number;
		private var _scope:Bitmap;
		private var _alphaDecress:Number;
		public function ExplosionParts(gravity:Number, xVelocity:Number, yVelocity:Number,scope:Bitmap, _alphaDecress:Number = .05) 
		{
			this._alphaDecress = _alphaDecress;
			this._scope = scope;
			this._xVelocity = xVelocity;
			this._yVelocity = yVelocity;
			this._gravity = gravity;
		}
		
		public function get gravity():Number 
		{
			return _gravity;
		}
		
		public function set gravity(value:Number):void 
		{
			_gravity = value;
		}
		
		public function get xVelocity():Number 
		{
			return _xVelocity;
		}
		
		public function set xVelocity(value:Number):void 
		{
			_xVelocity = value;
		}
		
		public function get scope():Bitmap 
		{
			return _scope;
		}
		
		public function set scope(value:Bitmap):void 
		{
			_scope = value;
		}
		
		public function get yVelocity():Number 
		{
			return _yVelocity;
		}
		
		public function set yVelocity(value:Number):void 
		{
			_yVelocity = value;
		}
		
		public function get alphaDecress():Number 
		{
			return _alphaDecress;
		}
		
		public function set alphaDecress(value:Number):void 
		{
			_alphaDecress = value;
		}
		
	}

}