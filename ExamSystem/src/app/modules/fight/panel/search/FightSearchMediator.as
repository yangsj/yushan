package app.modules.fight.panel.search
{
	import app.modules.fight.events.FightOnlineEvent;
	import app.modules.fight.service.FightOnlineService;
	import app.modules.friend.model.FriendModel;
	import app.modules.friend.model.FriendVo;
	
	import net.victoryang.framework.BaseMediator;
	
	
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-10-17
	 */
	public class FightSearchMediator extends BaseMediator
	{
		[Inject]
		public var view:FightSearchPanel;
		[Inject]
		public var fightOnlineService:FightOnlineService;
		[Inject]
		public var friendModel:FriendModel;
		
		public function FightSearchMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			
			addViewListener( FightOnlineEvent.INVITE_PLAYER_BATTLE, invitePlayerToBattleHandler, FightOnlineEvent );
			
			// 成功拉取数据通知
			addContextListener( FightOnlineEvent.SEARCH_LIST_NOTIFY, searchUserListNotify, FightOnlineEvent );
			
			// 开始拉取数据列表
			fightOnlineService.pullSearchPlayerList();
			
		}
		
		private function searchUserListNotify( event:FightOnlineEvent ):void
		{
			view.setData( friendModel.searchUserList );
		}
		
		private function invitePlayerToBattleHandler( event:FightOnlineEvent ):void
		{
			var friendVo:FriendVo = event.data as FriendVo;
			fightOnlineService.matching( friendVo.uid );
		}
		
//		private function get getListData():Vector.<FriendVo>
//		{
//			var vec:Vector.<FriendVo> = new Vector.<FriendVo>();
//			for ( var i:int = 0; i < 50; i++ )
//			{
//				var startIndex:int = int( Math.random() * 20);
//				var vo:FriendVo = new FriendVo();
//				vo.name = i + "abcdefghijklmnopqrstuvwxyz".substr(startIndex, 6);
//				vo.status = int( Math.random() * 3)+1;
//				vec.push( vo );
//			}
//			return vec;
//		}
	}
}