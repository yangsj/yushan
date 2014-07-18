package app.modules.task.event
{
	import victor.framework.events.BaseEvent;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-6
	 */
	public class TaskEvent extends BaseEvent
	{
		public function TaskEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, data, bubbles, cancelable);
		}
		
		/**
		 * 更新列表
		 */
		public static const UPDATE_LIST:String = "update_list";
		
		/**
		 * 检查是否还有已完成的任务缓存着，还未显示
		 */
		public static const TASK_CHECK_COMPLETED:String = "task_check_completed";
		
		/**
		 * 領取任務奖励
		 */
		public static const TAKE_REWARD:String = "take_reward";
		
		/**
		 * 打开任务奖励面板
		 */
		public static const OPEN_REWARD:String = "open_reward";
		
		/**
		 * 是否有可领取任务
		 */
		public static const HAS_NEW_TASK:String = "has_new_task";
		
	}
}