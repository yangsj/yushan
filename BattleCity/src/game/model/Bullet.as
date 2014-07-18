package game.model
{
	import game.constant.ConstType;
	import game.interfaces.IBullet;
	
	/**
	 * 
	 * @author victor
	 * 			2014-6-30
	 */
	public class Bullet extends Model implements IBullet
	{
		private var _isPlayer:Boolean;
		
		public function Bullet( isPlayer:Boolean, bulletType:int = 1, direction:int = 0 )
		{
			uiRes = new UI_V_GameBulletSkin();
			addChild( uiRes );
			super( bulletType, direction );
			
			_isPlayer = isPlayer;
			speed = 10;
		}
		
		override public function updatePos():void
		{
			if ( _isDispose == false )
			{
				switch( direction )
				{
					case ConstType.UP:
						y -= speed;
						break;
					case ConstType.RIGHT:
						x += speed;
						break;
					case ConstType.DOWN:
						y += speed;
						break;
					case ConstType.LEFT:
						x -= speed;
						break;
					default:
						break;
				}
				
				var tw:Number = ConstType.WIDTH;
				var th:Number = ConstType.HEIGHT;
				if ( x < -tw || y < -th || th * ConstType.COL < y || ConstType.ROW * tw < x )
				{
					_isDispose = true;
				}
			}
		}
		
		public function isRemoveByModelType( model:int ):Boolean
		{
			return !( ( isPlayer && model == ConstType.PLAYER ) || ( !isPlayer && model == ConstType.ENEMY ));
		}
		
		override public function get attackHp():int
		{
			return type == ConstType.BULLET_2 ? 2 : 1;
		}
		
		override public function injured( hp:int, isForce:Boolean = false ):void { }
		
		public function get isPlayer():Boolean
		{
			return _isPlayer;
		}
		
		override public function set type(value:int):void
		{
			super.type = value;
			if ( uiRes ) uiRes.gotoAndStop( type );
		}
		
		override public function get modelType():int
		{
			return ConstType.BULLET;
		}
		
	}
}