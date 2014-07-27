package app.modules.login.register.event
{
	import net.victoryang.events.BaseEvent;
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-9-7
	 */
	public class RegisterEvent extends BaseEvent
	{
		public function RegisterEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, data, bubbles, cancelable);
		}
		
		public static const LOGIN:String = "login";
		public static const REGISTER:String = "register";
		
	}
}