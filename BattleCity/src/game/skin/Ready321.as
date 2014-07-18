package game.skin
{
	import flash.display.Sprite;
	
	import game.uitl.apps;
	import game.uitl.calls;
	import game.uitl.playFrameAnimate;
	import game.uitl.removeFromParent;
	
	/**
	 * 
	 * @author victor
	 * 			2014-6-30
	 */
	public class Ready321 extends Sprite
	{
		private var uiRes:UI_V_GameReady321;
		
		public function Ready321( callBackFun:Function = null )
		{
			uiRes = new UI_V_GameReady321();
			addChild( uiRes );
			
			apps.mouseChildren = false;
			playFrameAnimate( uiRes, function ():void
			{
				removeFromParent( uiRes );
				apps.mouseChildren = true;
				calls( callBackFun );
			});
		}
	}
}