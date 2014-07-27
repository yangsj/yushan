package app.modules.panel.share
{
	import net.victoryang.events.BaseEvent;
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-11-13
	 */
	public class ShareWeiboEvent extends BaseEvent
	{
		/*============================================================================*/
		/* private variables                                                          */
		/*============================================================================*/
		
		
		
		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/
		public function ShareWeiboEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, data, bubbles, cancelable);
		}
		
		/**
		 * 分享
		 */
		public static const SHARE_WEIBO:String = "share_weibo";
		
	}
}