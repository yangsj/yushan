package app.events
{
	import victor.framework.events.BaseEvent;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-8-27
	 */
	public class GameEvent extends BaseEvent
	{
		public function GameEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, data, bubbles, cancelable);
		}
		
///************* Login	events	
		/**
		 * 参数解析完成
		 */
		public static const ANALYTIC_WEB_PARAMS_COMMPLETE:String = "analytic_web_params_commplete";
		
		/**
		 * 资源application管理数据初始化完成
		 */
		public static const DATA_INIT_COMPLETE:String = "data_init_complete";
		
		/**
		 * 第一阶段资源加载完成
		 */
		public static const FIRST_LOAD_COMPLETE:String = "first_load_complete";
		
		/**
		 * 登陆成功的
		 */
		public static const LOGIN_SUCCESSED:String = "login_successed";
		
		/**
		 * 主资源加载完成
		 */
		public static const MAIN_LOAD_COMPLETE:String = "main_load_complete";
		
		/**
		 * 登陆时获取到玩家数据
		 */
		public static const ACQUIRE_PLAYER_DATA:String = "acquire_player_data";
		
		/**
		 * 登陆是获取到地图数据
		 */
		public static const ACQUIRE_MAP_DATA:String = "acquire_map_data";
		
		/**
		 * 登陆时获取到好友列表数据
		 */
		public static const ACQUIRE_FRIEND_DATA:String = "acquire_friend_data";
		
		/**
		 * 登陆时获取到任务数据
		 */
		public static const ACQUIRE_TASK_DATA:String = "acquire_task_data";
		
		/**
		 * 设置player的菜单选项
		 */
		public static const SET_PLAYER_MENU:String = "set_player_menu";
		
///******************* in game
		
		/**
		 * 背包物品有更新
		 */
		public static const UPDATE_PACK_ITEMS:String = "update_pack_items";
		
		/**
		 * 升级
		 */
		public static const LEVEL_UP:String = "level_up";
		
	}
}