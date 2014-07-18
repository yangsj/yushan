package game.skin
{
	import com.greensock.TweenLite;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import game.uitl.apps;
	import game.uitl.removeFromParent;
	
	/**
	 * 
	 * @author victor
	 * 			2014-6-30
	 */
	public class PassAllRound extends Sprite
	{
		private var uiRes:UI_V_GamePassAllRound;
		private var callBackFun:Function;
		
		public function PassAllRound( history:int, current:int, callBackFun:Function = null )
		{
			uiRes = new UI_V_GamePassAllRound();
			uiRes.x = 154.3;
			uiRes.y = 173.6;
			addChild( uiRes );
			
			uiRes.txtHistory.text = history.toString();
			uiRes.txtCurrent.text = current.toString();
			
			this.callBackFun = callBackFun;
			
			apps.mouseChildren = false;
			
			TweenLite.delayedCall( 5, onComplete );
			
			uiRes.addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler, false, 0, true );
		}
		
		protected function removedFromStageHandler( event:Event ):void
		{
			destroy();
		}
		
		public function destroy():void
		{
			if ( uiRes )
			{
				uiRes.removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler );
				removeFromParent( uiRes );
			}
			apps.mouseChildren = true;
			TweenLite.killDelayedCallsTo( onComplete );
			callBackFun = null;
		}
		
		private function onComplete():void
		{
			if ( callBackFun != null )
			{
				callBackFun();
				callBackFun = null;
			}
			destroy();
		}
	}
}