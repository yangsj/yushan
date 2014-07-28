package app.modules.fight.panel.friend
{
	import app.modules.fight.events.FightOnlineEvent;
	import app.modules.fight.service.FightOnlineService;
	import app.modules.friend.event.FriendEvent;
	import app.modules.friend.model.FriendModel;
	import app.modules.friend.model.FriendVo;
	import app.modules.friend.service.FriendService;
	
	import victoryang.framework.BaseMediator;
	
	
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-10-17
	 */
	public class FightFriendMediator extends BaseMediator
	{
		[Inject]
		public var view:FightFriendPanel;
		[Inject]
		public var friendService:FriendService;
		[Inject]
		public var friendModel:FriendModel;
		[Inject]
		public var fightOnlineService:FightOnlineService;
		
		public function FightFriendMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			
			addContextListener( FriendEvent.UPDATE_LIST, updateListHandler, FriendEvent );
			
			addViewListener( FightOnlineEvent.INVITE_PLAYER_BATTLE, invitePlayerToBattleHandler, FightOnlineEvent );
			
			friendService.pullFriendListReq();
		}
		
		protected function updateListHandler( event:FriendEvent ):void
		{
			view.setDataList( friendModel.onLineList );
		} 
		
		private function invitePlayerToBattleHandler( event:FightOnlineEvent ):void
		{
			var friendVo:FriendVo = event.data as FriendVo;
			fightOnlineService.matching( friendVo.uid );
		}
		
	}
}