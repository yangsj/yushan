package game.model
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import game.constant.ConstType;
	import game.interfaces.IElement;
	import game.interfaces.IModel;
	import game.uitl.removeFromParent;
	
	/**
	 * 
	 * @author victor
	 * 			2014-7-1
	 */
	public class Model extends Sprite implements IModel
	{
		protected var uiRes:MovieClip;
		
		protected var _totalHp:int = 0;
		
		protected var _type:int;
		protected var _direction:int;
		protected var _speed:Number = 2;
		protected var _isDispose:Boolean;
		protected var _isDeath:Boolean;
		
		protected var _faultTolerant:int = 1;
		protected var _hitTarget:DisplayObject;
		
		public function Model( type:int = 1, direction:int = 0 )
		{
			initParams();
			this.type = type;
			this.direction = direction;
			addChild( hitTarget );
		}
		
		protected function initParams():void
		{
		}
		
		protected function refreshPos():void
		{
			switch( direction )
			{
				case ConstType.UP:
					y -= speed;
//					x = row * ConstType.WIDTH;
					
					y = Math.max( y, 0 );
					y = Math.min( y, ConstType.MAX_DIST_Y);
					break;
				case ConstType.DOWN:
					y += speed;
//					x = row * ConstType.WIDTH;
					
					y = Math.max( y, 0 );
					y = Math.min( y, ConstType.MAX_DIST_Y);
					break;
				case ConstType.RIGHT:
					x += speed;
//					y = col * ConstType.HEIGHT;
					
					x = Math.max( x, 0 );
					x = Math.min( x, ConstType.MAX_DIST_X );
					break;
				case ConstType.LEFT:
					x -= speed;
//					y = col * ConstType.HEIGHT;
					
					x = Math.max( x, 0 );
					x = Math.min( x, ConstType.MAX_DIST_X );
					break;
				default:
					break;
			}
			
			var ex:Number = row * ConstType.WIDTH;
			var ey:Number = col * ConstType.HEIGHT;
			if ( isUp || isDown )
			{
				if ( x < ex )
				{
					x += speed;
					if ( x > ex )
						x = ex;
				}
				else 
				{
					x -= speed;
					if ( x < ex )
						x = ex;
				}
			}
			else
			{
				if ( y < ey )
				{
					y += speed;
					if ( y > ey )
						y = ey;
				}
				else 
				{
					y -= speed;
					if ( y < ey )
						y = ey;
				}
			}
			
			
//			x = Math.max( x, 0 );
//			x = Math.min( x, ConstType.MAX_DIST_X );
//			
//			y = Math.max( y, 0 );
//			y = Math.min( y, ConstType.MAX_DIST_Y);
		}
		
		/////////////////
		
		protected function get isLeft():Boolean
		{
			return direction == ConstType.LEFT;
		}
		
		protected function get isRight():Boolean
		{
			return direction == ConstType.RIGHT;
		}
		
		protected function get isUp():Boolean
		{
			return direction == ConstType.UP;
		}
		
		protected function get isDown():Boolean
		{
			return direction == ConstType.DOWN;
		}
		
		protected function get totalHp():int
		{
			return _totalHp;
		}
		
		protected function set totalHp(value:int):void
		{
			_totalHp = value;
		}
		
		////////////////////////
		
		public function dispose():void
		{
			removeFromParent( this );
			removeFromParent( uiRes );
			_isDispose = true;
		}
		
		public function injured( hp:int, isForce:Boolean = false ):void
		{
			trace( "被攻击伤害 " + hp );
			totalHp -= hp;
			if ( totalHp <= 0 )
			{
				_isDispose = true;
				_isDeath = true;
			}
		}
		
		public function setPos(sx:Number, sy:Number):void
		{
			x = sx;
			y = sy;
		}
		
		public function updatePos():void
		{
			refreshPos();
		}
		
		public function isRange( element:IElement ):Boolean
		{
			if ( element && this != element )
			{
				var lx:Number = x - ConstType.WIDTH;
				var rx:Number = x + ConstType.WIDTH;
				var uy:Number = y - ConstType.HEIGHT;
				var dy:Number = y + ConstType.HEIGHT;
				if ( isUp || isDown)
				{
					var boo1:Boolean = element.x > lx && element.x < rx;
					var boo2:Boolean = isUp ? element.y <= y && element.y >= uy : element.y >= y && element.y <= dy;
					return boo1 && boo2;
				}
				else if ( isLeft || isRight )
				{
					var boo3:Boolean = element.y > uy && element.y < dy;
					var boo4:Boolean = isLeft ? element.x <= x && element.x >= lx : element.x >= x && element.x <= rx;
					return boo3 && boo4;
				}
			}
			return false;
		}
		
		///////////////
		
		public function get hitTarget():DisplayObject
		{
			if ( _hitTarget == null )
			{
				var sp:Sprite = new Sprite();
				sp.graphics.beginFill( 0, 0 );
				sp.graphics.drawCircle( 0, 0, ConstType.WIDTH * 0.5 );
				sp.graphics.endFill();
				_hitTarget = sp;
			}
			return _hitTarget;
		}
		
		public function get attackHp():int
		{
			return 0;
		}
		
		public function get col():int
		{
			var temp:int = Math.round( y / ConstType.HEIGHT );
			temp = Math.max( temp, 0 );
			temp = Math.min( temp, ConstType.COL - 1 );
			return temp;
		}
		
		public function get row():int
		{
			var temp:int = Math.round( x / ConstType.WIDTH );
			temp = Math.max( temp, 0 );
			temp = Math.min( temp, ConstType.ROW - 1 );
			return temp;
		}
		
		public function get isEdge():Boolean
		{
			if ( ( x <= 0 && isLeft ) || 
				 ( y <= 0 && isUp ) || 
				 ( ConstType.MAX_DIST_X <= x && isRight ) || 
				 ( ConstType.MAX_DIST_Y <= y && isDown ) )
			{
				return true;
			}
			return false;
		}
		
		public function get nextCol():int 
		{
			switch( direction )
			{
				case ConstType.UP:
//					return Math.max( col - 1, 0 );
					break;
				case ConstType.DOWN:
					return Math.min( col + 1, ConstType.COL );
				default:
					break;
			}
			return col;
		}
		
		public function get nextRow():int
		{
			switch( direction )
			{
				case ConstType.LEFT:
//					return Math.max( row - 1, 0 );
					break;
				case ConstType.RIGHT:
					return Math.min( row + 1, ConstType.MAX_ROW );
				default:
					break;
			}
			return row;
		}
		
		public function get type():int
		{
			return _type;
		}
		
		public function set type(value:int):void
		{
			_type = value;
		}
		
		public function get direction():int
		{
			return _direction;
		}
		
		public function set direction(value:int):void
		{
			if ( _direction != value )
			{
				_direction = value;
				x = row * ConstType.WIDTH;
				y = col * ConstType.HEIGHT;
				if ( uiRes )
				{
					uiRes.rotation = 90 * value;
				}
			}
		}
		
		public function get speed():Number
		{
			return _speed;
		}
		
		public function set speed(value:Number):void
		{
			_speed = value;
		}
		
		public function get isDispose():Boolean
		{
			return _isDispose;
		}
		
		public function set isDispose(value:Boolean):void
		{
			_isDispose = value;
		}
		
		public function get isDeath():Boolean
		{
			return _isDeath;
		}

		public function set isDeath(value:Boolean):void
		{
			_isDeath = value;
		}
		
		public function get modelType():int
		{
			return 0;
		}
		
		public function get isCanBullet():Boolean
		{
			return modelType != ConstType.BULLET && modelType != ConstType.PROP;
		}


	}
}