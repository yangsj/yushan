package game.skin
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import game.uitl.removeFromParent;
	
	/**
	 * 
	 * @author victor
	 * 			2014-6-30
	 */
	public class StartPanel extends Sprite
	{
		private var uiRes:UI_V_GameStartpanel;
		private var callOnStartFun:Function;
		
		public function StartPanel( startFun:Function )
		{
			this.callOnStartFun = startFun;
			
			uiRes = new UI_V_GameStartpanel();
			addChild( uiRes );
			uiRes.addEventListener( MouseEvent.CLICK, clickHandler );
		}
		
		protected function clickHandler(event:MouseEvent):void
		{
			if ( event.target == uiRes.btnStart )
			{
				if ( callOnStartFun != null ) 
				{
					callOnStartFun();
				}
			}
		}
		
		public function setup(data:*):void { }
		
		public function show():void
		{
			this.visible = true;
		}
		
		public function hide():void
		{
			this.visible = false;
		}
		
		public function destroy():void
		{
			if ( uiRes )
			{
				uiRes.removeEventListener( MouseEvent.CLICK, clickHandler );
				removeFromParent( uiRes );
				uiRes = null;
				callOnStartFun = null;
			}
		}
	}
}