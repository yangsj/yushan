package app.modules.task.command
{
	import app.modules.task.model.TaskModel;
	import app.modules.task.model.TaskVo;
	
	import victoryang.components.Tips;
	import victoryang.framework.BaseCommand;
	

	/**
	 * ……
	 * @author 	victor
	 * 			2013-11-24
	 */
	public class TaskCheckCompleteCommand extends BaseCommand
	{
		[Inject]
		public var taskModel:TaskModel;


		public function TaskCheckCompleteCommand()
		{
			super();
		}

		override public function execute():void
		{
			var cacheCompleteTask:Vector.<TaskVo> = taskModel.cacheCompleteTask;
			if ( cacheCompleteTask && cacheCompleteTask.length > 0 )
			{
				var taskVo:TaskVo = cacheCompleteTask.shift();
//				openView( ViewName.TaskCompleted, taskVo );
				Tips.showCenter( "你已经完成了一个新任务，可以领取任务奖励" );
			}
		}

	}
}
