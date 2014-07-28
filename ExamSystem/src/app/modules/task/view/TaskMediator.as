package app.modules.task.view
{
	import app.modules.ViewName;
	import app.modules.task.event.TaskEvent;
	import app.modules.task.model.TaskModel;
	import app.modules.task.service.TaskService;
	
	import victoryang.framework.BaseMediator;
	
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-9-6
	 */
	public class TaskMediator extends BaseMediator
	{
		[Inject]
		public var view:TaskView;
		[Inject]
		public var taskService:TaskService;
		[Inject]
		public var taskModel:TaskModel;
		
		public function TaskMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			addContextListener( TaskEvent.UPDATE_LIST, taskListNotify, TaskEvent );
			
			addViewListener( TaskEvent.OPEN_REWARD, openRewardHandler, TaskEvent );
			
			taskService.pullTaskList();
		}
		
		private function openRewardHandler( event:TaskEvent ):void
		{
			openView( ViewName.TaskCompleted, event.data );
		}
		
		private function taskListNotify( event:TaskEvent ):void
		{
			view.setDataList( taskModel.taskList );
		}		
		
	}
}