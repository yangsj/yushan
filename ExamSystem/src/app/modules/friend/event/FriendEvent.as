package app.modules.friend.event
{
	import victor.framework.events.BaseEvent;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-6
	 */
	public class FriendEvent extends BaseEvent
	{
		public function FriendEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, data, bubbles, cancelable);
		}
		
		/**
		 * 更新列表
		 */
		public static const UPDATE_LIST:String = "update_list";
		
		/**
		 * 添加好友
		 */
		public static const ADD_FRIEND:String = "add_friend";
		
		/**
		 * 聊天
		 */
		public static const CHAT:String = "chat";
		
		/**
		 * 对战
		 */
		public static const BATTLE:String = "battle";
		
		/**
		 * 删除
		 */
		public static const DELETE:String = "delete";
		
		/**
		 * 检查是否有加好友消息
		 */
		public static const CHECK_ADD:String = "check_add";
		
		
	}
}