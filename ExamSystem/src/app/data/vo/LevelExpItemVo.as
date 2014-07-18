package app.data.vo
{
	import app.GameConfig;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-24
	 */
	public class LevelExpItemVo
	{
		/**
		 * 等级
		 */
		public var level:int;
		/**
		 * 到达当前等级初始值
		 */
		public var curExp:int;
		/**
		 * 到达下等级初始值
		 */
		public var nextExp:int;
		
		public function LevelExpItemVo( level:int, curExp:int, nextExp:int )
		{
			this.level = level;
			this.curExp = curExp;
			this.nextExp = nextExp;
		}
		
		/**
		 * 是否是最大等级
		 */
		public function get isMax():Boolean
		{
			return level >= GameConfig.MAX_LEVEL;
		}
		
		public function toString():String
		{
			return "level:" + level + ", curExp:" + curExp + ", nextExp:" + nextExp;
		}
		
	}
}