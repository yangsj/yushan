package app.modules.panel.personal.events
{
	import victoryang.events.BaseEvent;
	
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-9-12
	 */
	public class PersonalEvent extends BaseEvent
	{
		public function PersonalEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, data, bubbles, cancelable);
		}
		
		/**
		 * 修改个人信息
		 */
		public static const CHANGE_INFO:String = "CHANGE_INFO";
		
		/**
		 * 修改个人信息成功
		 */
		public static const CHANGE_INFO_SUCCESS:String = "change_info_success";
		
		/**
		 * 成功获取到列表数据
		 */
		public static const ERROR_LIST_SUCCESSED:String = "ERROR_LIST_SUCCESSED";
		
		/**
		 * 开始发请求数据
		 */
		public static const TO_SEND_ERRO_LIST_REQ:String = "TO_SEND_ERRO_LIST_REQ";
	}
}