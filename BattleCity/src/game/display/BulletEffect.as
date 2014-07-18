package game.display
{
	import flash.display.Sprite;
	
	import game.constant.ConstType;
	import game.uitl.playFrameAnimate;
	import game.uitl.removeFromParent;
	
	/**
	 * 
	 * @author victor
	 * 			2014-7-3
	 */
	public class BulletEffect extends Sprite
	{
		private var uiRes:Sprite;
		
		public function BulletEffect( type:int = 1 )
		{
			if ( type == ConstType.BULLET_1 )
				uiRes = new UI_V_GameBulletEffect_1();
			else uiRes = new UI_V_GameBulletEffect_2();
			addChild( uiRes );
			
			playFrameAnimate( uiRes["mc"], onComplete );
		}
		
		public function setPos( sx:Number, sy:Number ):void
		{
			x = sx;
			y = sy;
		}
		
		private function onComplete():void
		{
			removeFromParent( this );
		}
	}
}