package app.modules.fight.events
{
	import net.victoryang.events.BaseEvent;
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-9-27
	 */
	public class FightAloneEvent extends BaseEvent
	{
		public function FightAloneEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, data, bubbles, cancelable);
		}
		
		
		/**
		 * 选择字母
		 */
		public static const SELECTED_LETTER:String = "selected_letter";
		
		/**
		 * 移除字母
		 */
		public static const REMOVED_LETTER:String = "removed_letter";
		
		/**
		 * 更新显示单词信息
		 */
		public static const UPDATE_WORD:String = "update_word";
		
		/**
		 * 显示增加金币动画
		 */
		public static const ADD_MONEY_EFFECT:String = "add_money_effect";
		
		/**
		 * 退出练习模式
		 */
		public static const EXIT_PRACTICE:String = "exit_practice";
		
		/**
		 * 显示答案中
		 */
		public static const SHOW_ANSWER_ING:String = "show_answer_ing";
		
		/**
		 * 自己清楚所有干扰
		 */
		public static const CLEAR_DISTURB_SELF:String = "clear_disturb_self";
		
		/**
		 * 对手清楚所有干扰
		 */
		public static const CLEAR_DISTURB_DEST:String = "clear_disturb_dest";
		
		/**
		 * 使用跳过道具后自动输入到格子
		 */
		public static const USE_SKIP_INPUT_AUTO:String = "use_skip_input_auto";
		
		//////////////// notify
		
		/**
		 * 关卡开始通知
		 */
		public static const NOTIFY_START_ROUND:String = "notify_start_round";
		/**
		 * 关卡结束通知
		 */
		public static const NOTIFY_END_ROUND:String = "notify_end_round";
		/**
		 * 下一个单词通知
		 */
		public static const NOTIFY_NEXT_WORD:String = "notify_next_word";
		
	}
}