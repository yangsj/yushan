package app.modules.model.vo
{
	import ff.item_type_e;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-27
	 */
	public class ItemType
	{
		/**
		 * 默认值，非道具
		 */
		public static const DEFAULT:int = item_type_e.ITEM_NONE;
		/**
		 * 提示1
		 */
		public static const HINT:int = item_type_e.ITEM_TIPS;
		
		/**
		 * 扫帚2
		 */
		public static const BROOM:int = item_type_e.ITEM_BROOM;
		
		/**
		 * 跳过3
		 */
		public static const SKIP:int = item_type_e.ITEM_NEXT;
		
		/**
		 * 加时间4
		 */
		public static const EXTRA_TIME:int = item_type_e.ITEM_TIME;
		
		/**
		 * 炸弹
		 */
		public static const BOMB:int = item_type_e.ITEM_BOMB;
		
	}
}