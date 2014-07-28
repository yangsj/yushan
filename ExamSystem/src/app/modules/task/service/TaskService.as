package app.modules.task.service
{
	import flash.utils.Dictionary;
	
	import app.modules.ViewName;
	import app.modules.fight.model.FightModel;
	import app.modules.main.model.MainModel;
	import app.modules.model.PackModel;
	import app.modules.model.vo.ItemVo;
	import app.modules.task.event.TaskEvent;
	import app.modules.task.model.TaskModel;
	import app.modules.task.model.TaskVo;
	import app.sound.SoundManager;
	import app.sound.SoundType;
	
	import ff.client_cmd_e;
	import ff.server_cmd_e;
	import ff.task_accept_award_req_t;
	import ff.task_accept_award_ret_t;
	import ff.task_completed_ret_t;
	import ff.task_info_req_t;
	import ff.task_info_t;
	import ff.task_t;
	
	import victoryang.components.Tips;
	
	import victor.framework.core.BaseService;
	import victor.framework.socket.SocketResp;
	
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-9-6
	 */
	public class TaskService extends BaseService
	{
		[Inject]
		public var taskModel:TaskModel;
		[Inject]
		public var fightModel:FightModel;
		[Inject]
		public var packModel:PackModel;
		[Inject]
		public var mainModel:MainModel;
		
		public function TaskService()
		{
			super();
		}
		
		override protected function initRegist():void
		{
			// 任务列表数据通知
			regist( server_cmd_e.TASK_INFO_RET, taskInfoListNotify, task_info_t );
			// 任务完成通知
			regist( server_cmd_e.TASK_COMPLETED_RET, taskCompleteNotify, task_completed_ret_t );
			// 任务奖励领取成功
			regist( server_cmd_e.TASK_ACCEPT_AWARD_RET, takeRewardSuccessNotify, task_accept_award_ret_t );
		}
		
		// 任务列表数据通知
		private function taskInfoListNotify( resp:SocketResp ):void
		{
			var data:task_info_t = resp.data as task_info_t;
			var list:Array = data.task_list;
			var taskVo:TaskVo;
			
			taskModel.hasTaskList = false;
			taskModel.taskList.length = 0;
			
			var hasNew:Boolean = false;
			
			for each ( var task:task_t in list )
			{
				taskVo = new TaskVo();
				taskVo.id = task.task_id;
				taskVo.type = task.task_type;
				taskVo.describe = task.desc;
				taskVo.status = task.status;
				taskVo.rewardExp = task.exp_award;
				taskVo.rewardMoney = task.coin_award;
				taskVo.propList = getRewardList( task.item_award );
				if ( taskVo.isEd && !hasNew ) hasNew = true;
				
				taskModel.updateTask( taskVo );
			}
			
			taskModel.hasTaskList = true;
			// 更新列表通知
			dispatch( new TaskEvent( TaskEvent.UPDATE_LIST ));
			
			dispatch( new TaskEvent( TaskEvent.HAS_NEW_TASK, hasNew ));
		}
		
		// 任务完成通知
		private function taskCompleteNotify( resp:SocketResp ):void
		{
			var data:task_completed_ret_t = resp.data as task_completed_ret_t;
			var taskVo:TaskVo = taskModel.getTaskVoById( data.task_id );
			taskVo.id = data.task_id;
			taskVo.status = TaskVo.STATUS_ED;
			taskVo.rewardMoney = data.coin_award;
			taskVo.rewardExp = data.exp_award;
			taskVo.describe = data.desc;
			taskVo.propList = getRewardList( data.item_award );
			// 更新当前任务状态
			taskModel.updateTask( taskVo );
			
			// 弹出奖励领取面板|已屏蔽
			taskModel.cacheCompleteTask.push( taskVo );
			if ( !fightModel.isFighting && mainModel.hasEnterGame )
				dispatch( new TaskEvent( TaskEvent.TASK_CHECK_COMPLETED ));
			
			dispatch( new TaskEvent( TaskEvent.HAS_NEW_TASK, true ));
			
		}
		
		// 任务奖励领取成功
		private function takeRewardSuccessNotify( resp:SocketResp ):void
		{
			var data:task_accept_award_ret_t = resp.data as task_accept_award_ret_t;
			var taskVo:TaskVo = taskModel.getTaskVoById( data.task_id );
			taskVo.id = data.task_id;
			taskVo.status = TaskVo.STATUS_HIDE;
			taskVo.rewardMoney = data.coin_award;
			taskVo.rewardExp = data.exp_award;
			taskVo.describe = data.desc;
			taskVo.propList = getRewardList( data.item_award, true );
			// 更新当前任务状态
			taskModel.updateTask( taskVo );
			
			Tips.showCenter( "任务奖励领取成功！" );
			
			// 播放音效
			SoundManager.playEffectMusic( SoundType.REWARD_DIAMOND );
			
			// 自动关闭奖励领取面板
			closeView( ViewName.TaskCompleted );
			
			// 重新更新列表
			pullTaskList();
		}
		
		private function getRewardList( dict:Dictionary, isUpdateToPack:Boolean = false ):Vector.<ItemVo>
		{
			var vec:Vector.<ItemVo> = new Vector.<ItemVo>();
			var itemVo:ItemVo;
			for ( var key:String in dict )
			{
				itemVo = new ItemVo();
				itemVo.type = int( key );
				itemVo.num = int(dict[ key ]);
				vec.push( itemVo );
				
				// 更新到背包中
				if ( isUpdateToPack ) {
					packModel.addNumByType( itemVo.type, itemVo.num );
				}
			}
			return vec;
		}
		
		////////////////////// publics 
		
		/**
		 * 拉取任务列表
		 */
		public function pullTaskList():void
		{
			if ( taskModel.hasTaskList ) {
				// 更新列表通知
				dispatch( new TaskEvent( TaskEvent.UPDATE_LIST ));
				dispatch( new TaskEvent( TaskEvent.HAS_NEW_TASK, taskModel.isHasNew ));
			} else {
				var req:task_info_req_t = new task_info_req_t();
				call( client_cmd_e.TASK_INFO_REQ, req );
			}
		}
		
		public function takeReward( id:int ):void
		{
			var req:task_accept_award_req_t = new task_accept_award_req_t();
			req.task_id = id;
			call( client_cmd_e.TASK_ACCEPT_AWARD_REQ, req );
		}
		
	}
}