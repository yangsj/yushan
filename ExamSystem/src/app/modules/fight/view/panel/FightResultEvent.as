package app.modules.fight.view.panel
{
	import victoryang.events.BaseEvent;
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-9-28
	 */
	public class FightResultEvent extends BaseEvent
	{
		public function FightResultEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, data, bubbles, cancelable);
		}
		
		public static const PRACTICE:String = "Practice";
		public static const NEXT:String = "next";
		public static const AGAIN:String = "again";
		public static const CLOSE:String = "close";
		
	}
}