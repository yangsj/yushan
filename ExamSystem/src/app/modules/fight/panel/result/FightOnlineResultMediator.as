package app.modules.fight.panel.result
{
	import app.data.GameData;
	import app.modules.ViewName;
	import app.modules.fight.events.FightOnlineEvent;
	import app.modules.fight.model.FightModel;
	import app.modules.fight.model.FightReadyModel;
	import app.modules.fight.service.FightOnlineService;
	
	import victoryang.events.PanelEvent;
	import victoryang.framework.BaseMediator;
	
	
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-10-17
	 */
	public class FightOnlineResultMediator extends BaseMediator
	{
		[Inject]
		public var view:FightOnlineResultPanel;
		[Inject]
		public var fightModel:FightModel;
		[Inject]
		public var readyModel:FightReadyModel;
		[Inject]
		public var onlineService:FightOnlineService;
		
		public function FightOnlineResultMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			
			// 退出
			addViewListener( PanelEvent.CLOSE, closeQuitHandler, PanelEvent );
			// 再来一次
			addViewListener( FightOnlineEvent.AGAIN_BATTLE, againBattleHandler, FightOnlineEvent );
			
			var iswin:Boolean = fightModel.battleResult;
			var winPlayer:String = iswin ? GameData.instance.selfVo.name : readyModel.destVo.name;
			var losePlayer:String = !iswin ? GameData.instance.selfVo.name : readyModel.destVo.name;
			view.setPlayer( winPlayer, losePlayer );
			view.setData( iswin ? fightModel.battleEndSelfVo : fightModel.battleEndDestVo, !iswin ? fightModel.battleEndSelfVo : fightModel.battleEndDestVo );
			
		}
		
		private function againBattleHandler( event:FightOnlineEvent ):void
		{
			// 再来一次
			onlineService.againBattle( readyModel.destVo.uid );
		}
		
		private function closeQuitHandler( event:PanelEvent ):void
		{
			closeView( ViewName.FightOnline );
		}
		
	}
}