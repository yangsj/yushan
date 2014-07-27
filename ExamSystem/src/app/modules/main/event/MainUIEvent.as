package app.modules.main.event
{
	import net.victoryang.events.BaseEvent;
	
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-9-24
	 */
	public class MainUIEvent extends BaseEvent
	{
		public function MainUIEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, data, bubbles, cancelable);
		}
		
		/**
		 * 更新经验值
		 */
		public static const UPDATE_EXP:String = "update_exp";
		
		/**
		 * 更新金币值
		 */
		public static const UPDATE_MONEY:String = "update_money";
		
		/**
		 * 更新属性
		 */
		public static const UPDATE_PROPERTY:String = "update_property";
		
	}
}