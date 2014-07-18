package app.modules.panel.rank.events
{
	import victor.framework.events.BaseEvent;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-28
	 */
	public class RankEvent extends BaseEvent
	{
		public function RankEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, data, bubbles, cancelable);
		}
		
		/**
		 * 拉取数据成功
		 */
		public static const COMPLETE_NOTITY:String = "complete_notity";
		
		/**
		 * tab标签切换
		 */
		public static const CHANGE_TAB:String = "change_tab";
		
	}
}