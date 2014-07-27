package app.modules.panel.rank.model
{
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-11-25
	 */
	public class RankVo
	{
		public function RankVo()
		{
		}
		
		/**
		 * 类型：0=周|1=月|2=综合|3=财富|4=丰收
		 */
		public var type:int;
		
		/**
		 * 排名
		 */
		public var rank:int;
		/**
		 * 昵称
		 */
		public var name:String;
		/**
		 * 等级
		 */
		public var level:int;
		/**
		 * 有效期
		 */
		public var validity:String;
		/**
		 * 荣誉
		 */
		public var honor:String;
		/**
		 * 用户id
		 */
		public var uid:int = 0;
		
		/**
		 * 是否是自己
		 */
		public var isSelf:Boolean = false;
		
	}
}