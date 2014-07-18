package victor.framework.events
{
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-10-21
	 */
	public class PanelEvent extends BaseEvent
	{
		public function PanelEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, data, bubbles, cancelable);
		}
		
		/**
		 * 关闭
		 */
		public static const CLOSE:String = "close";
		
		/**
		 * 打开
		 */
		public static const OPENED:String = "open";
		
		/**
		 * 加载完成
		 */
		public static const COMPLETE:String = "complete";
		
		public static const LOAD_START:String = "load_start";
		public static const LOAD_END:String = "load_end";
		
	}
}