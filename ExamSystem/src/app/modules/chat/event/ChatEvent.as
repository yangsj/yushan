package app.modules.chat.event
{
	import victoryang.events.BaseEvent;
	
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-9-6
	 */
	public class ChatEvent extends BaseEvent
	{
		public function ChatEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, data, bubbles, cancelable);
		}
		
		
		/**
		 * 显示聊天窗口
		 */
		public static const SHOW_CHAT:String = "show_chat";
		/**
		 * 隐藏聊天窗口
		 */
		public static const HIDE_CHAT:String = "hide_chat";
		/**
		 * 展开聊天日志
		 */
		public static const EXPAND_CHAT:String = "expand_chat";
		/**
		 * 折叠聊天日志
		 */
		public static const FOLD_CHAT:String = "fold_chat";
		/**
		 * 发送消息到聊天窗口
		 */
		public static const SEND_MSG:String = "send_msg";
		/**
		 * 将消息发到服务器
		 */
		public static const PUSH_MSG:String = "push_msg";
		/**
		 * 聊天窗口更新
		 */
		public static const UPDATE_MSG:String = "update_msg";
		/**
		 * 更改频道
		 */
		public static const CHANGE_CHANNEL:String = "change_channel";
		/**
		 * 输入表情
		 */
		public static const INPUT_EMOTION:String = "input_emotion";
		/**
		 * 锁定聊天窗口信息
		 */
		public static const LOCK_CHAT:String = "lock_chat";
		/**
		 * 跟好友私聊
		 */
		public static const CHAT_TO_FRIEND:String = "chat_to_friend";
		
	}
}