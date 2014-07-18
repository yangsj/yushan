package game.data
{
	
	/**
	 * 
	 * @author victor
	 * 			2014-7-2
	 */
	public class LevelVo
	{
		public var level:int = 1;
		/**
		 * 敌人列表 type
		 */
		public var enemyList:Array;
		/**
		 * 将会出现的道具id
		 */
		public var propList:Array;
		
		public function LevelVo(level:int = 1, 
									  eList:Array = null, 
									  pList:Array = null )
		{
			this.level = level;
			this.enemyList = eList;
			this.propList = pList;
		}
		
		public function get curMapArray():Array
		{
			return MapInfo.getInfoByLevel( level );
		}
		
		
		public function clone():LevelVo
		{
			return new LevelVo( 	level, 
										enemyList.slice(), 
										propList.slice() 
									);
		}
		
	}
}