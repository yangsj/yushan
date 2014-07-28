package app.modules.fight.panel.matching
{
	import app.modules.fight.service.FightOnlineService;
	
	import victoryang.components.Tips;
	import victoryang.events.PanelEvent;
	import victoryang.framework.BaseMediator;
	
	
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-10-17
	 */
	public class FightMatchingMediator extends BaseMediator
	{
		[Inject]
		public var onlineService:FightOnlineService;
		
		public function FightMatchingMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			
			// 退出
			addViewListener( PanelEvent.CLOSE, closeQuitHandler, PanelEvent );
			
			onlineService.matching();
			
			Tips.showCenter( "自动匹配等级相差不超过3级的玩家" );
		}
		
		private function closeQuitHandler( event:PanelEvent ):void
		{
			onlineService.quit();
		}
	}
}