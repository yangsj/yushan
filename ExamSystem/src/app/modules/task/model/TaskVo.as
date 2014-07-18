package app.modules.task.model
{
	import app.modules.model.vo.ItemVo;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-23
	 */
	public class TaskVo
	{
		/**
		 * 0默认状态
		 */
		public static const DEFAULT:int = 0;
		/**
		 * 1正在进行中
		 */
		public static const STATUS_ING:int = 1;
		/**
		 * 2已完成
		 */
		public static const STATUS_ED:int = 2;
		/**
		 * 3已领取奖励
		 */
		public static const STATUS_HIDE:int = 3; 
		
		
		public function TaskVo()
		{
		}
		
		/**
		 * 任务id
		 */
		public var id:int;
		/**
		 * 任务类型
		 */
		public var type:int;
		/**
		 * 任务描述
		 */
		public var describe:String;
		/**
		 * 任务状态(0默认状态|1正在进行中|2已完成|3已领取奖励)
		 * @see app.modules.task.model.TaskVo.DEFAULT
		 * @see app.modules.task.model.TaskVo.STATUS_ING
		 * @see app.modules.task.model.TaskVo.STATUS_ED
		 * @see app.modules.task.model.TaskVo.STATUS_HIDE
		 */
		public var status:int;
		/**
		 * 奖励经验值
		 */
		public var rewardExp:int;
		/**
		 * 奖励的货币
		 */
		public var rewardMoney:int;
		/**
		 * 奖励道具列表
		 */
		public var propList:Vector.<ItemVo>;
		
		/**
		 * 是否已经领取
		 */
		public function get isHide():Boolean
		{
			return status == STATUS_HIDE || !describe;
		}
		
		/**
		 * 任务是否完成
		 */
		public function get isEd():Boolean
		{
			return status == STATUS_ED;
		}
		
		/**
		 * 是否正在进行
		 */
		public function get isIng():Boolean
		{
			return status == STATUS_ING;
		}
		
		/**
		 * 完整的任务描述（包含进度）
		 */
		public function get fullDescribe():String
		{
			describe ||= "完整的任务描述";
			return describe + ( isEd ? "（已完成）" : ( isHide ? "（已领取）" : "" ) );
		}
		
	}
}