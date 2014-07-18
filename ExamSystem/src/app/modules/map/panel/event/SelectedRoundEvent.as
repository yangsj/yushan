package app.modules.map.panel.event
{
	import victor.framework.events.BaseEvent;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-26
	 */
	public class SelectedRoundEvent extends BaseEvent
	{
		public function SelectedRoundEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, data, bubbles, cancelable);
		}
		
		
		/**
		 * 获取到地图章节的详细数据
		 */
		public static const CHAPTER_DETAIL:String = "chapter_detail";
		
		/**
		 * 选择进入关卡
		 */
		public static const SELECTED_ROUND:String = "selected_round";
		
	}
}