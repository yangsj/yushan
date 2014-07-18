package game.skin
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import game.uitl.apps;
	import game.uitl.calls;
	import game.uitl.playFrameAnimate;
	
	/**
	 * 
	 * @author victor
	 * 			2014-6-30
	 */
	public class PassRound extends Sprite
	{
		private var uiRes:MovieClip;
		
		public function PassRound( desc:String, callBackFunc:Function = null )
		{
			uiRes = new UI_V_GamePassCurrentRound();
			addChild( uiRes );
			
			if ( !desc ) desc = " ";
			uiRes.mc.txtScore.text = desc;
			
			apps.mouseChildren = false;
			playFrameAnimate( uiRes, function ():void
			{
				apps.mouseChildren = true;
				calls( callBackFunc );
			});
		}
	}
}