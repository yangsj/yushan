package app.modules.fight.view.spell
{
	import net.victoryang.events.BaseEvent;
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-9-28
	 */
	public class SpellEvent extends BaseEvent
	{
		public function SpellEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, data, bubbles, cancelable);
		}
		
		/**
		 * 输入完成
		 */
		public static const INPUT_OVER:String = "input_over";
		
		/**
		 * 一个单词输入完成
		 */
		public static const ONE_WORD_OVER:String = "one_word_over";
		
		/**
		 * 显示答案
		 */
		public static const SHOW_ANSWER:String = "show_answer";
		
		/**
		 * 点击显示答案
		 */
		public static const CLICK_SHOW:String = "click_show";
		
	}
}