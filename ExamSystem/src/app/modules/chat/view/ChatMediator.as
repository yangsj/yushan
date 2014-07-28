package app.modules.chat.view
{
	import flash.events.MouseEvent;
	
	import app.data.GameData;
	import app.modules.chat.ChatChannelType;
	import app.modules.chat.event.ChatEvent;
	import app.modules.chat.model.ChatModel;
	import app.modules.chat.model.ChatVo;
	import app.modules.chat.service.ChatService;
	
	import victoryang.framework.BaseMediator;
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-9-6
	 */
	public class ChatMediator extends BaseMediator
	{
		[Inject]
		public var view:ChatView;
		[Inject]
		public var chatModel:ChatModel;
		[Inject]
		public var chatService:ChatService;
		
		public function ChatMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			
			/////////// 全局
			
			// 展开聊天日志
			addContextListener( ChatEvent.EXPAND_CHAT, expandLogHandler, ChatEvent );
			// 折叠聊天日志
			addContextListener( ChatEvent.FOLD_CHAT, foldLogHandler, ChatEvent );
			// 显示窗口
			addContextListener( ChatEvent.SHOW_CHAT, showViewChatHandler, ChatEvent );
			// 隐藏窗口
			addContextListener( ChatEvent.HIDE_CHAT, hideViewChatHandler, ChatEvent );
			// 显示信息
			addContextListener( ChatEvent.UPDATE_MSG, updateMsgHandler, ChatEvent );
			// 与好友私聊
			addContextListener( ChatEvent.CHAT_TO_FRIEND, chatToFriendHandler, ChatEvent );
			
			/////////// 本地
			
			// 聊天频道改变
			addViewListener( ChatEvent.CHANGE_CHANNEL, changeChannelHandler, ChatEvent );
			//
			addViewListener( ChatEvent.PUSH_MSG, pushMsgHandler, ChatEvent );
			//
			addViewListener( ChatEvent.LOCK_CHAT, lockChatHandler, ChatEvent );
			
			// 选中世界频道
			view.selectedWorld();
			
			chatModel.sendLocal( "你的用户id为" + GameData.instance.selfVo.uid );
			chatModel.sendLocal( "和好友私聊，请先选择一个好友", ChatChannelType.PRIVATE );
		}
		
		// 展开聊天日志
		private function expandLogHandler( event:ChatEvent ):void
		{
			view.isExpand = false;
			view.setExpandHide();
		}
		
		// 折叠聊天日志
		private function foldLogHandler( event:ChatEvent ):void
		{
			view.isExpand = true;
			view.setExpandHide();
		}
		
		private function chatToFriendHandler( event:ChatEvent ):void
		{
			view.dispatchEvent( new MouseEvent( MouseEvent.CLICK ));
			view.selectedPrivate();
		}
		
		private function lockChatHandler( event:ChatEvent ):void
		{
			chatModel.isLocked = Boolean(event.data);
		}
		
		private function pushMsgHandler( event:ChatEvent ):void
		{
			var chatVo:ChatVo = event.data as ChatVo;
			chatService.sendRequestMsg( chatVo );
		}
		
		private function changeChannelHandler( event:ChatEvent ):void
		{
			var currentChannel:int = int( event.data );
			chatModel.currentChannel = currentChannel;
			view.setChannelStatus( chatModel.isPrivateChatChannel, chatModel.privateChatFriendVo);
			
			var vecList:Vector.<ChatVo> = chatModel.getCurrentChannelList();
			view.setChannelData( vecList );
		}
		
		private function updateMsgHandler( event:ChatEvent ):void
		{
			view.addMsg( event.data as ChatVo );
		}
		
		private function showViewChatHandler( event:ChatEvent ):void
		{
			view.visible = true;
		}
		
		private function hideViewChatHandler( event:ChatEvent ):void
		{
			view.visible = false;
		}
		
	}
}