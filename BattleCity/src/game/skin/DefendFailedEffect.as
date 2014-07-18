package game.skin
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import game.uitl.calls;
	import game.uitl.playFrameAnimate;
	import game.uitl.removeFromParent;
	
	/**
	 * 
	 * @author victor
	 * 			2014-7-2
	 */
	public class DefendFailedEffect extends Sprite
	{
		private var callBackFunc:Function;
		
		private var uiRes:MovieClip;
		
		public function DefendFailedEffect( callBack:Function )
		{
			callBackFunc = callBack;
			
			uiRes = new UI_V_GameDefendFailedEffect();
			uiRes.x = 348.75;
			uiRes.y = 195.75;
			addChild( uiRes );
			
			playFrameAnimate( uiRes, onComplete );
		}
		
		private function onComplete():void
		{
			removeFromParent( this );
			calls( callBackFunc );
			callBackFunc = null;
		}
	}
}