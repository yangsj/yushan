package game.model
{
	import game.constant.ConstType;
	import game.interfaces.IWall;
	import game.uitl.removeFromParent;
	
	/**
	 * 
	 * @author victor
	 * 			2014-6-30
	 */
	public class Wall extends Model implements IWall
	{
		
		public function Wall( type:int = 1 )
		{
			super( type );
		}
		
		override protected function initParams():void
		{
			uiRes = new UI_V_GameWallMaterial();
			addChild( uiRes );
			
			uiRes.width = ConstType.WIDTH;
			uiRes.height = ConstType.HEIGHT;
			
			totalHp = 1;
		}
		
		override public function dispose():void
		{
			removeFromParent( this );
			super.dispose();
		}
		
		override public function injured( hp:int, isForce:Boolean = false ):void
		{
			if ( type == 1 || isForce )
			{
				super.injured( hp );
			}
		}
		
		override public function updatePos():void {}

		override public function set type(value:int):void
		{
			_type = value;
			if ( uiRes ) uiRes.gotoAndStop( type );
		}

		override public function get isEdge():Boolean
		{
			return false;
		}

		override public function get modelType():int
		{
			return ConstType.WALL;
		}
		
		///////////////////////////////////////////////////
		
		public static function create( type:int, sx:Number, sy:Number ):Wall
		{
			var wall:Wall = new Wall( type );
			wall.setPos( sx, sy );
			return wall;
		}

	}
}