package game.model
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import game.constant.ConstType;
	import game.interfaces.IPropItem;
	
	/**
	 * 
	 * @author victor
	 * 			2014-7-2
	 */
	public class PropItem extends Model implements IPropItem
	{
		public function PropItem(type:int=1, direction:int=0)
		{
			super(type, direction);
		}
		
		override protected function initParams():void
		{
			uiRes = new UI_V_GamePorpItemIcon();
			addChild( uiRes );
			
			uiRes.width = ConstType.WIDTH;
			uiRes.height = ConstType.HEIGHT;
			
			trace( "创建道具id=========================" + type );
			
			speed = 0;
			totalHp = 0;
		}
		
		override public function updatePos():void {}
		
		override public function get modelType():int
		{
			return ConstType.PROP;
		}
		
		override public function set type(value:int):void
		{
			_type = value;
			if ( uiRes ) uiRes.gotoAndStop( value );
		}
		
		override public function get hitTarget():DisplayObject
		{
			if ( _hitTarget == null )
			{
				var sp:Sprite = new Sprite();
				sp.graphics.beginFill( 0, 0 );
				sp.graphics.drawCircle( 0, 0, ConstType.WIDTH * 0.1 );
				sp.graphics.endFill();
				_hitTarget = sp;
			}
			return _hitTarget;
		}
		
	}
}