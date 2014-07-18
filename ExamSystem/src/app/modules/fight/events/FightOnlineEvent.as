package app.modules.fight.events
{
	import victor.framework.events.BaseEvent;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-10-21
	 */
	public class FightOnlineEvent extends BaseEvent
	{
		public function FightOnlineEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, data, bubbles, cancelable);
		}
		
		/**
		 * 对战结束
		 */
		public static const BATTLE_END:String = "battle_end";
		
		/**
		 * 删除对手屏幕泡泡
		 */
		public static const DEL_DEST_BUBLLE:String = "del_dest_bublle";
		
		/**
		 * 和对手再来一局
		 */
		public static const AGAIN_BATTLE:String = "again_battle";
		
		/**
		 * 对手更新下一个单词
		 */
		public static const DEST_UPDATE_NEXT:String = "dest_update_next";
		
		/**
		 * 邀请玩家对战
		 */
		public static const INVITE_PLAYER_BATTLE:String = "invite_player_battle";
		
		//////////// notify++++++++++++++++++++++++++++++++++++++
		
		/**
		 * 在线对战搜索玩家列表数据拉取成功
		 */
		public static const SEARCH_LIST_NOTIFY:String = "search_list_notify";
		
	}
}