package app.modules.fight.panel.ready
{
	import app.modules.fight.events.FightOnlineEvent;
	import app.modules.fight.model.FightReadyModel;
	import app.modules.fight.service.FightOnlineService;
	
	import victoryang.deubg.Debug;
	import victoryang.events.PanelEvent;
	import victoryang.framework.BaseMediator;
	
	
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-10-17
	 */
	public class FightReadyMediator extends BaseMediator
	{
		[Inject]
		public var readyModel:FightReadyModel;
		[Inject]
		public var view:FightReadyPanel;
		[Inject]
		public var onlineService:FightOnlineService;
		
		public function FightReadyMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			
			// 准备
			addViewListener( FightReadyEvent.READY, readyHandler , FightReadyEvent );
			// 退出
			addViewListener( PanelEvent.CLOSE, closeQuitHandler, PanelEvent );
			
			// 更新
			addContextListener( FightReadyEvent.UPDATE, updateHandler, FightReadyEvent );
			// 对方退出
			addContextListener( FightOnlineEvent.BATTLE_END, quitBattleHandler, FightOnlineEvent );
			
			view.setData( readyModel.selfVo, readyModel.destVo );
		}
		
		private function closeQuitHandler( event:PanelEvent ):void
		{
			onlineService.quit();
		}
		
		private function quitBattleHandler( event:FightOnlineEvent ):void
		{
			view.hide();
		}
		
		private function updateHandler( event:FightReadyEvent ):void
		{
			view.refreshStatus( true );
		}
		
		private function readyHandler( event:FightReadyEvent ):void
		{
			Debug.debug( "ready");
			onlineService.ready();
		}
		
	}
}