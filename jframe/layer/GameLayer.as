package jframe.layer
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import jframe.entity.defaultEntity.DefaultEntity;
	import jframe.entity.DefaultSprite;
	import jframe.manager.GameManager;
	
	/**
	 * Layer
	 * @author Jeff
	 */
	public class GameLayer extends Sprite implements IGameLayer
	{
		static public const ITEM_REMOVED:String = "ItemRemoved";
		/**
		 * Array dos filhos
		 */
		protected var _arrayChilds:Array;
		private var _layerName:String;
		protected var _world:GameManager
		protected var _layerManager:LayerManager;
		
		public function GameLayer(_layerName:String)
		{
			this._layerName = _layerName;
			this.addEventListener(Event.ADDED_TO_STAGE, addStage)
		}
		
		protected function addStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, addStage);
		
		}
		
		/**
		 * Call update for all childrens
		 */
		public function updateChildren():void
		{
			for each (var item:DefaultSprite in _arrayChilds)
			{
				if (item.updateable)
					item.update();
				if (item is DefaultEntity && DefaultEntity(item).dead)
				{
					item.kill()
					item = null;
				}
				
			}
		}
		
		/**
		 * Sobreescreve essa função para incluir objetos na layer
		 */
		public function build(args:Object = null):void
		{
		}
		
		/**
		 * Despausa todos os filhos da layer
		 */
		public function unpauseLayer():void
		{
			for each (var item:DisplayObject in _arrayChilds)
			{
				try
				{
					if (item is DefaultEntity && !DefaultEntity(item).dead)
						DefaultEntity(item).unpauseEntity();
				}
				catch (err:Error)
				{
					trace("GameLayer.unpauseLayer: " + err);
				}
			}
		}
		
		/**
		 * Pausa todos os filhos da layer
		 */
		public function pauseLayer():void
		{
			for each (var item:DisplayObject in _arrayChilds)
			{
				try
				{
					DefaultEntity(item).pauseEntity();
				}
				catch (err:Error)
				{
					
				}
			}
		}
		
		/**
		 * Remove a camada
		 */
		public function destroy():void
		{
			this.parent.removeChild(this);
		}
		
		/**
		 * Adiciona filhos na layer, a layer é um container, logo, adiciona e coloca num array o que for adicionado para faciltar a busca
		 * @param	object
		 */
		override public function addChild(child:DisplayObject):DisplayObject
		{
			if (child as DefaultEntity)
				DefaultEntity(child).layer = this;
			
			if (!_arrayChilds)
				_arrayChilds = new Array();
			
			_arrayChilds.push(child);
			
			return super.addChild(child);
		}
		
		/**
		 * Remove todos os filhos
		 */
		public function removeAllChildren():void
		{
			while (_arrayChilds.length)
			{
				_arrayChilds[0].kill();
				_arrayChilds.splice(0,1)
			}
		}
		
		/**
		 * Remove os filhos, do array e do container
		 * @param	child
		 * @return
		 */
		override public function removeChild(child:DisplayObject):DisplayObject
		{
			trace( "child : " + child );
			for (var i:int = 0; i < _arrayChilds.length; i++)
			{
				if (_arrayChilds[i] == child)
				{
					_arrayChilds.splice(i, 1);
				}
			}
			dispatchEvent(new Event(ITEM_REMOVED));
			
			return super.removeChild(child);
			
		}
		
		/**
		 * Colisão pelo range da entidade com o centro de outra
		 * @param	collideObject
		 * @param	ignoreSpecificEntity Classes que devem ser ignoradas aqui
		 * @return
		 */
		public function collideRangeHit(collideObject:DefaultEntity, ignoreSpecificEntity:Array = null):Array
		{
			var arrayReturn:Array = new Array;
			if (!ignoreSpecificEntity)
				ignoreSpecificEntity = new Array
			for each (var itemThis:DefaultEntity in _arrayChilds)
			{
				var pass:Boolean = true;
				for (var i:int = 0; i < ignoreSpecificEntity.length; i++)
				{
					if (itemThis is ignoreSpecificEntity[i])
						pass = false
				}
				if (itemThis == collideObject)
					pass = false
				if (pass)
				{
					var dist:Number = Point.distance(new Point(itemThis.x, itemThis.y), new Point(collideObject.x, collideObject.y))
					if (dist < (itemThis.rangeCenterHit + collideObject.rangeColision))
						arrayReturn.push(itemThis)
				}
			}
			return arrayReturn
		}
		
		/**
		 * Colisão pelas default entity, facilmente adaptavel para outros casos
		 * @param	collideObject
		 * @return
		 */
		public function collideRange(collideObject:DefaultEntity, ignoreSpecificEntity:Array = null, acumRange:Boolean = false):Array
		{
			var arrayReturn:Array = new Array;
			if (!ignoreSpecificEntity)
				ignoreSpecificEntity = new Array
			for (var j:int = 0; j < _arrayChilds.length; j++)
			{
				var itemThis:* = _arrayChilds[j]
				if (itemThis is DefaultEntity)
				{
					var pass:Boolean = true;
					for (var i:int = 0; i < ignoreSpecificEntity.length; i++)
					{
						if (itemThis is ignoreSpecificEntity[i])
							pass = false
					}
					if (itemThis == collideObject)
						pass = false
					if (pass)
					{
						var dist:Number = Point.distance(new Point(itemThis.x, itemThis.y), new Point(collideObject.x, collideObject.y))
						var totDist:Number = acumRange ? itemThis.rangeColision + collideObject.rangeColision : itemThis.rangeColision
						if (dist < totDist)
							arrayReturn.push(itemThis)
					}
					
				}
			}
			return arrayReturn
		}
		
		/**
		 * Testa colisão entre duas entidades especificas
		 * @param	entity1
		 * @param	entity2
		 */
		public function setBaseBoundsCollisions2(entity1:DefaultEntity, entity2:DefaultEntity):Boolean
		{
			if (entity1.x + entity1.baseBounds.x < entity2.x + entity2.baseBounds.x + entity2.baseBounds.width && entity1.x + entity1.baseBounds.width > entity2.x && entity1.y + entity1.baseBounds.y < entity2.y && entity1.y + entity1.baseBounds.height > entity2.y + entity2.baseBounds.y + entity2.baseBounds.height)
				return true
			return false
		}
		
		/**
		 * Testa colisão por um retangulo
		 * @param	hitBounds
		 */
		public function setBaseBoundsCollision(collideObject:DefaultEntity, ignoreSpecificEntity:Array = null):Array
		{
			var tempDef:DefaultEntity;
			if (ignoreSpecificEntity == null)
				ignoreSpecificEntity = new Array();
			var returnArray:Array = new Array;
			for each (var itemThis:Sprite in _arrayChilds)
			{
				
				if (itemThis is DefaultEntity && itemThis != collideObject)
				{
					var pass:Boolean = true;
					
					for (var i:int = 0; i < ignoreSpecificEntity.length; i++)
					{
						if (itemThis is ignoreSpecificEntity[i])
							pass = false
					}
					if (itemThis == collideObject)
						pass = false
					if (pass)
					{
						tempDef = itemThis as DefaultEntity;
						if (tempDef.x - tempDef.baseBounds.x - tempDef.baseBounds.width + tempDef.velocity.x < collideObject.x + collideObject.baseBounds.x + collideObject.baseBounds.width + collideObject.velocity.x && tempDef.x + tempDef.baseBounds.width + tempDef.velocity.x > collideObject.x + collideObject.velocity.x && tempDef.y + tempDef.baseBounds.y + tempDef.velocity.y < collideObject.y + collideObject.baseBounds.y + collideObject.baseBounds.height + collideObject.velocity.y && tempDef.y + tempDef.baseBounds.height + tempDef.velocity.y > collideObject.y + collideObject.velocity.y)
							returnArray.push(tempDef);
					}
				}
			}
			return returnArray;
		}
		
		/**
		 * Testa colisão por um retangulo
		 * @param	hitBounds
		 */
		public function setBoundsCollision(hitBounds:Rectangle):DisplayObject
		{
			for each (var itemThis:Sprite in _arrayChilds)
			{
				if (itemThis.x < hitBounds.x && itemThis.x + itemThis.width > hitBounds.x)
					return itemThis;
			}
			return null;
		}
		
		/**
		 * Testa colisao com uma layer
		 * @param	iGameLayer Camada para colidir
		 * @param	center se a colisão é no centro dos objetos
		 * @return
		 */
		public function setLayerCollision(iGameLayer:GameLayer, center:Boolean = false):DisplayObject
		{
			if (center)
				for each (var itemCenter:Sprite in iGameLayer.getLayerChilds())
				{
					for each (var itemThis:Sprite in _arrayChilds)
					{
						if (itemThis.hitTestPoint(itemCenter.x, itemCenter.y))
							return itemThis;
					}
				}
			else
				for each (var item2:Sprite in iGameLayer.getLayerChilds())
				{
					for each (var itemThis2:Sprite in _arrayChilds)
					{
						if (itemThis2.hitTestObject(item2))
							return itemThis2;
					}
				}
			return null
		}
		
		/**
		 * Colide a layer com um objeto
		 * @param	entity a entidade, pode ser nula caso seja passado a base
		 * @param	_base as coordenadas da base
		 * @return
		 */
		public function setObjectLayerCollision(entity:Sprite, _base:Point = null):DisplayObject
		{
			if (_base)
				for each (var itemThis:DisplayObject in _arrayChilds)
				{
					if (entity != itemThis)
						if (itemThis.hitTestPoint(_base.x, _base.y))
							return itemThis;
				}
			else
				for each (var itemThis2:DisplayObject in _arrayChilds)
				{
					if (entity != itemThis2)
						if (itemThis2.hitTestObject(entity))
							return itemThis2;
				}
			return null
		}
		
		/**
		 * Retorna um array com os filhos
		 * @return
		 */
		public function getLayerChilds():Array
		{
			return _arrayChilds
		}
		
		/**
		 * Atualiza o zIndex
		 * Só funciona se a layer conter apenas DefaultEntity
		 */
		public function updateChildZIndex():void
		{
			
			var maxValue:Number = Number.MAX_VALUE;
			var arrayPos:Array = new Array()
			
			for (var i:int = 0; i < _arrayChilds.length; i++)
			{
				if (_arrayChilds[i] is DefaultEntity && _arrayChilds[i].baseBounds != null)
				{
					var tempY:Number = _arrayChilds[i].baseBounds.y + _arrayChilds[i].y
					arrayPos.push({pos: tempY, object: _arrayChilds[i]});
				}
			}
			/**
			 * Ordena o array pela posição
			 */
			arrayPos.sortOn(["pos"], [Array.NUMERIC]);
			for (var j:int = 0; j < arrayPos.length; j++)
			{
				this.setChildIndex(arrayPos[j]["object"], j)
			}
		}
		
		/**
		 * Verifica se há algum tipo específico de entidade na layer
		 * @return
		 */
		public function hasEntity(type:Class):Boolean
		{
			for (var i:int = 0; i < _arrayChilds.length; i++)
			{
				if (_arrayChilds[i] is type)
					return true
			}
			return false
		}
		
		/**
		 * serve para debugar os itens desta layer
		 */
		public function debugLayer(debugging:Boolean = true):void
		{
			for each (var item:DisplayObject in _arrayChilds)
			{
				if (debugging)
					item.transform.colorTransform = new ColorTransform(0, 1, 0);
				else
					item.transform.colorTransform = new ColorTransform(1, 1, 1);
			}
		}
		
		/**
		 * Atualiza todos os filhos, se estes puderem ser atualizados
		 */
		public function update():void
		{
			if (_arrayChilds != null)
				for (var i:int = 0; i < _arrayChilds.length; i++)
				{
					if (_arrayChilds[i] is DefaultSprite)
						if (_arrayChilds[i].updateable)
							_arrayChilds[i].update();
				}
		
		}
		
		public function getLayerChildsByType(types:Array):Array
		{
			var tempArray:Array = new Array
			
			for each (var item:*in _arrayChilds)
			{
				for each (var itemCompare:Class in types)
				{
					if (item is itemCompare)
						tempArray.push(item)
				}
				
			}
			return tempArray
		}
		
		public function setBaseBoundsCollisionWith(collideObject:DefaultEntity, specificEntity:Array = null):DefaultEntity
		{
			var tempDef:DefaultEntity;
			for each (var itemThis:Sprite in _arrayChilds)
			{
				
				if (itemThis is DefaultEntity && itemThis != collideObject)
				{
					var pass:Boolean = false;
					for (var i:int = 0; i < specificEntity.length; i++)
					{
						if (itemThis is specificEntity[i])
							pass = true
					}
					if (itemThis == collideObject)
						pass = false
					if (pass)
					{
						tempDef = itemThis as DefaultEntity;
						//var b1_x:int = tempDef.x - tempDef.baseBounds.x// - tempDef.velocity.x
						//var b1_y:int = tempDef.y - tempDef.baseBounds.y// - tempDef.velocity.y
						//var b2_x:int = collideObject.x + collideObject.baseBounds.x//- tempDef.velocity.x
						//var b2_y:int = collideObject.y - collideObject.baseBounds.y//- tempDef.velocity.y
						
						var b1_x:int = tempDef.x + tempDef.baseBounds.x + tempDef.velocity.x
						var b1_y:int = tempDef.y + tempDef.baseBounds.y + tempDef.velocity.y
						var b2_x:int = collideObject.x + collideObject.baseBounds.x + tempDef.velocity.x
						var b2_y:int = collideObject.y + collideObject.baseBounds.y + tempDef.velocity.y
						
						var b1_w:int = tempDef.baseBounds.width
						var b1_h:int = tempDef.baseBounds.height
						var b2_w:int = collideObject.baseBounds.width
						var b2_h:int = collideObject.baseBounds.height
						
						if ((b1_x > b2_x + b2_w - 1) || // is b1 on the right side of b2?
							(b1_y > b2_y + b2_h - 1) || // is b1 under b2?
							(b2_x > b1_x + b1_w - 1) || // is b2 on the right side of b1?
							(b2_y > b1_y + b1_h - 1)) // is b2 under b1?
						{
						}
						else
							return tempDef;
							//if (tempDef.x + tempDef.baseBounds.x - tempDef.baseBounds.width - tempDef.velocity.x < collideObject.x + collideObject.baseBounds.x + collideObject.baseBounds.width - collideObject.velocity.x && tempDef.x + tempDef.baseBounds.x + tempDef.baseBounds.width - tempDef.velocity.x > collideObject.x + collideObject.baseBounds.x - collideObject.baseBounds.width - collideObject.velocity.x && tempDef.y + tempDef.baseBounds.y - tempDef.baseBounds.height - tempDef.velocity.y < collideObject.y + collideObject.baseBounds.y + collideObject.baseBounds.height - collideObject.velocity.y && 
							//tempDef.y + tempDef.baseBounds.y + tempDef.velocity.y < collideObject.y + collideObject.baseBounds.y + collideObject.baseBounds.height + collideObject.velocity.y && 
							//tempDef.y + tempDef.baseBounds.y + tempDef.baseBounds.height - tempDef.velocity.y > collideObject.y + collideObject.baseBounds.y - collideObject.baseBounds.height - collideObject.velocity.y)
							//return tempDef;
					}
				}
			}
			return null;
		}
		
		/**
		 * Organiza o array pela entidade mais próxima
		 * @param	entityArray
		 */
		public function sortByProximity(entityCompare:DefaultSprite, entityArray:Array):Array
		{
			var newArray:Array = [];
			var tempDistance:int = 0;
			var tempLenght:int = 0;
			for each (var item:DefaultSprite in entityArray)
			{
				tempDistance = entityCompare.getDistance(item)
				tempLenght = newArray.length;
				for (var i:int = 0; i < tempLenght; i++)
				{
					if (tempDistance < entityCompare.getDistance(newArray[i]))
					{
						newArray.splice(i, 0, item);
					}
				}
				if (newArray.length <= 0)
					newArray.push(item);
			}
			return newArray
			//entityArray.sort(proximiSort);
		}
		
		/**
		 * Seta um nome pra camada
		 * @param	name
		 */
		public function set layerName(name:String):void
		{
			this._layerName = name;
		}
		
		/**
		 * Retorna o nome da camada
		 */
		public function get layerName():String
		{
			return _layerName;
		}
		
		public function get world():GameManager
		{
			return _world;
		}
		
		public function set world(value:GameManager):void
		{
			_world = value;
		}
		
		public function get layerManager():LayerManager
		{
			return _layerManager;
		}
		
		public function set layerManager(value:LayerManager):void
		{
			_layerManager = value;
		}
	
	}

}