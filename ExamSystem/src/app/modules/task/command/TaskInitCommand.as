package app.modules.task.command
{
	import app.modules.ViewName;
	import app.modules.task.event.TaskEvent;
	import app.modules.task.model.TaskModel;
	import app.modules.task.service.TaskService;
	import app.modules.task.view.TaskCompletedMediator;
	import app.modules.task.view.TaskCompletedPanel;
	import app.modules.task.view.TaskMediator;
	import app.modules.task.view.TaskView;
	
	import net.victoryang.framework.BaseCommand;
	
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-9-6
	 */
	public class TaskInitCommand extends BaseCommand
	{
		public function TaskInitCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			addView( ViewName.Task, TaskView, TaskMediator );
			addView( ViewName.TaskCompleted, TaskCompletedPanel, TaskCompletedMediator );
			
			injectActor( TaskModel );
			injectActor( TaskService );
			
			commandMap.mapEvent( TaskEvent.TASK_CHECK_COMPLETED, TaskCheckCompleteCommand, TaskEvent );
			
		}
		
	}
}