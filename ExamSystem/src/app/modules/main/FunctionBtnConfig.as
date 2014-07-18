package app.modules.main
{
	import app.modules.ViewName;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-10
	 */
	public class FunctionBtnConfig
	{
		public function FunctionBtnConfig()
		{
		}
		
		public static const functionBtnsList:Array = [ FRIEND, TASK, PERSONAL, RANK, PRACTICE, FIGHT, EXIT ];
		
		/**
		 * 好友
		 */
		public static const FRIEND:String = ViewName.Friend;
		
		/**
		 * 任务
		 */
		public static const TASK:String = ViewName.Task;
		
		/**
		 * 个人信息
		 */
		public static const PERSONAL:String = ViewName.Personal;
		
		/**
		 * 排行
		 */
		public static const RANK:String = ViewName.Rank;
		
		/**
		 * 练习
		 */
		public static const PRACTICE:String = ViewName.FightPractice;
		
		/**
		 * 对战
		 */
		public static const FIGHT:String = "btnFight";
		
		/**
		 * 退出
		 */
		public static const EXIT:String = "btnExit";
		
	}
}