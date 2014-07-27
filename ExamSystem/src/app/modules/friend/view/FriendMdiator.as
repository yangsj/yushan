package app.modules.friend.view
{
	import app.modules.chat.model.ChatModel;
	import app.modules.fight.service.FightOnlineService;
	import app.modules.friend.event.FriendEvent;
	import app.modules.friend.model.FriendModel;
	import app.modules.friend.model.FriendVo;
	import app.modules.friend.service.FriendService;
	
	import net.victoryang.components.Tips;
	import net.victoryang.framework.BaseMediator;
	
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-9-6
	 */
	public class FriendMdiator extends BaseMediator
	{
		[Inject]
		public var view:FriendView;
		[Inject]
		public var friendModel:FriendModel;
		[Inject]
		public var friendService:FriendService;
		[Inject]
		public var chatModel:ChatModel;
		[Inject]
		public var fightOnlineService:FightOnlineService;
		
		public function FriendMdiator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			
			addContextListener( FriendEvent.UPDATE_LIST, updateListHandler, FriendEvent );
			
			addViewListener( FriendEvent.CHAT, chatHandler, FriendEvent );
			addViewListener( FriendEvent.BATTLE, battleHandler, FriendEvent );
			addViewListener( FriendEvent.DELETE, deleteHandler, FriendEvent );
			
			setFriendList();
			friendService.pullFriendListReq();
		}
		
		protected function setFriendList():void
		{
			view.setData( friendModel.friendList );
		}
		
		private function deleteHandler( event:FriendEvent ):void
		{
			// 删除好友
			var friendVo:FriendVo = event.data as FriendVo;
			friendService.delFriend( friendVo.uid );
		}
		
		private function battleHandler( event:FriendEvent ):void
		{
//			Tips.showCenter( "好友在线对战, 功能开发中！" );
			var friendVo:FriendVo = event.data as FriendVo;
			fightOnlineService.matching( friendVo.uid );
		}
		
		private function chatHandler( event:FriendEvent ):void
		{
			Tips.showCenter( "好友私聊" );
			chatModel.privateChatFriendVo = event.data as FriendVo;
		}
		
		protected function updateListHandler( event:FriendEvent ):void
		{
			setFriendList();
		}
		
	}
}