package app.modules.task.model
{
	import org.robotlegs.mvcs.Actor;


	/**
	 * ……
	 * @author 	victor
	 * 			2013-9-6
	 */
	public class TaskModel extends Actor
	{
		/**
		 * 是否获得任务列表数据
		 */
		public var hasTaskList:Boolean = false;

		private var _taskList:Vector.<TaskVo>;
		private var _cacheCompleteTask:Vector.<TaskVo>;

		public function TaskModel()
		{
			super();
		}

		/**
		 * 更新任务数据
		 * @param taskVo
		 */
		public function updateTask( taskVo:TaskVo ):void
		{
			var index:int = hasTaskList ? getIndexById( taskVo.id ) : -1;
			// 若任务列表查到改任务
			if ( index != -1 )
			{
				// 当前任务已经不是进行中，则先删除
				if ( taskVo.isEd || taskVo.isHide )
				{
					taskList.splice( index, 1 );
				}
			}
			// 任务为完成状态，更新到列表最前
			if ( taskVo.isEd )
			{
				taskList.unshift( taskVo );
			}
			else if ( taskVo.isIng )
			{
				if ( index == -1 )
				{
					taskList.push( taskVo );
				}
				else
				{
					taskList[ index ] = taskVo;
				}
			}
		}

		/**
		 * 获取任务
		 * @param id
		 */
		public function getTaskVoById( id:int ):TaskVo
		{
			var index:int = getIndexById( id );
			if ( index != -1 )
			{
				return taskList[ index ];
			}
			return new TaskVo();
		}

		/**
		 * 通过任务id获取任务排序号。若没有当前指定任务，则返回-1。
		 * @param id
		 */
		public function getIndexById( id:int ):int
		{
			var taskVo:TaskVo;
			for ( var key:String in taskList )
			{
				taskVo = taskList[ key ];
				if ( taskVo && taskVo.id == id )
				{
					return int( key );
				}
			}
			return -1;
		}
		
		public function get isHasNew():Boolean
		{
			var taskVo:TaskVo;
			for ( var key:String in taskList )
			{
				taskVo = taskList[ key ];
				if ( taskVo && taskVo.isEd ) {
					return true;
				}
			}
			return false;
		}

		/**
		 * 任务列表
		 */
		public function get taskList():Vector.<TaskVo>
		{
			return _taskList ||= new Vector.<TaskVo>();
		}

		/**
		 * 缓存完成的任务
		 */
		public function get cacheCompleteTask():Vector.<TaskVo>
		{
			return _cacheCompleteTask ||= new Vector.<TaskVo>();
		}

		public function set cacheCompleteTask( value:Vector.<TaskVo> ):void
		{
			_cacheCompleteTask = value;
		}


	}
}
