package app.modules.fight.panel.ready
{
	import victoryang.events.BaseEvent;
	
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-10-19
	 */
	public class FightReadyEvent extends BaseEvent
	{
		public function FightReadyEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, data, bubbles, cancelable);
		}
		
		public static const READY:String = "ready";
		
		public static const UPDATE:String = "update";
		
	}
}