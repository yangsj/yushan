package app.modules.fight.command
{
	import app.core.Alert;
	import app.modules.fight.model.FightInviteVo;
	import app.modules.fight.model.FightModel;
	import app.modules.fight.service.FightOnlineService;
	import app.modules.model.CommonModel;
	
	import net.victoryang.events.PanelEvent;
	import net.victoryang.framework.BaseCommand;
	
	
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-12-28
	 */
	public class FightInviteCommand extends BaseCommand
	{
		/*============================================================================*/
		/* private variables                                                          */
		/*============================================================================*/
		[Inject]
		public var event:PanelEvent;
		[Inject]
		public var commondModel:CommonModel;
		[Inject]
		public var fightModel:FightModel;
		[Inject]
		public var fightOnlineService:FightOnlineService;
		
		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/
		public function FightInviteCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			if ( event.type == PanelEvent.LOAD_START )
			{
				commondModel.isLoading = true;
			}
			else if ( event.type == PanelEvent.LOAD_END )
			{
				commondModel.isLoading = false;
				checkInvite();
			}
		}
		
		private function checkInvite():void
		{
			if ( fightModel.cacheInviteList.length > 0) {
				var vo:FightInviteVo = fightModel.cacheInviteList.pop();
				Alert.show( "[" + vo.name + "]邀请你加入对战，是否接受？", callBack, "接受", "拒绝");
				function callBack( type:int ):void
				{
					fightOnlineService.agreeOperateInvite( vo.uid, type==Alert.YES );
				}
			}
		}
		
		
	}
}