package app.modules.task.view
{
	import app.modules.task.event.TaskEvent;
	import app.modules.task.model.TaskVo;
	import app.modules.task.service.TaskService;
	
	import net.victoryang.framework.BaseMediator;
	
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-11-22
	 */
	public class TaskCompletedMediator extends BaseMediator
	{
		[Inject]
		public var taskService:TaskService;
		
		public function TaskCompletedMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			super.onRemove();
			
			dispatch( new TaskEvent( TaskEvent.TASK_CHECK_COMPLETED ));
			
			addViewListener( TaskEvent.TAKE_REWARD, takeRewardHandler, TaskEvent );
		}
		
		private function takeRewardHandler( event:TaskEvent ):void
		{
			var taskVo:TaskVo = event.data as TaskVo;
			taskService.takeReward( taskVo.id );
		}
		
	}
}