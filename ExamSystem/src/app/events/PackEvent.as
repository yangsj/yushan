package app.events
{
	import victor.framework.events.BaseEvent;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-27
	 */
	public class PackEvent extends BaseEvent
	{
		public function PackEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, data, bubbles, cancelable);
		}
		
		/**
		 * 使用物品
		 */
		public static const USE_ITEM:String = "use_item";
		/**
		 * 物品使用成功
		 */
		public static const USE_SUCCESS:String = "use_success";
		/**
		 * 更新列表
		 */
		public static const UPDATE_ITEMS:String = "update_items";
		/**
		 * 对战中对手使用道具成功
		 */
		public static const DEST_USE_SUCCESS:String = "dest_use_success";
		
	}
}