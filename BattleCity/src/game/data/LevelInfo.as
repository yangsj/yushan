package game.data
{
	
	/**
	 * 
	 * @author victor
	 * 			2014-7-2
	 */
	public class LevelInfo
	{
		
		public static const LEVEL_1:LevelVo = new LevelVo( 1, [1,1,1,2,2], [1,2,3] );
		public static const LEVEL_2:LevelVo = new LevelVo( 2, [1,1,1,2,2], [1,2,3] );
		public static const LEVEL_3:LevelVo = new LevelVo( 3, [1,1,1,2,2], [1,2,3] );
		public static const LEVEL_4:LevelVo = new LevelVo( 4, [1,1,1,1,2,2,3], [1,2,3,4] );
		public static const LEVEL_5:LevelVo = new LevelVo( 5, [1,1,1,1,2,2,3], [1,2,3,4] );
		public static const LEVEL_6:LevelVo = new LevelVo( 6, [1,1,1,1,2,2,3], [1,2,3,4] );
		public static const LEVEL_7:LevelVo = new LevelVo( 7, [1,1,1,1,2,2,3,4], [1,2,3,4,5] );
		public static const LEVEL_8:LevelVo = new LevelVo( 8, [1,1,1,1,2,2,3,4], [1,2,3,4,5] );
		public static const LEVEL_9:LevelVo = new LevelVo( 9, [1,1,1,1,2,2,3,4], [1,2,3,4,5] );
		public static const LEVEL_10:LevelVo = new LevelVo( 10, [2,3,3,2,2,2,3,4,4], [1,2,3,4,5] );
		public static const LEVEL_11:LevelVo = new LevelVo( 11, [2,3,3,2,2,2,3,4,4], [1,2,3,4,5] );
		public static const LEVEL_12:LevelVo = new LevelVo( 12, [2,3,3,2,2,2,3,4,4], [1,2,3,4,5] );
		public static const LEVEL_13:LevelVo = new LevelVo( 13, [2,3,3,2,2,2,3,4,4,4], [1,2,3,4,5] );
		public static const LEVEL_14:LevelVo = new LevelVo( 14, [2,3,3,2,2,2,3,4,4,4], [1,2,3,4,5] );
		public static const LEVEL_15:LevelVo = new LevelVo( 15, [2,3,3,2,2,2,3,4,4,4], [1,2,3,4,5] );
		public static const LEVEL_16:LevelVo = new LevelVo( 16, [2,3,3,2,2,2,3,4,4,4], [1,2,3,4,5] );
		public static const LEVEL_17:LevelVo = new LevelVo( 17, [2,3,3,2,2,2,3,4,4,4], [1,2,3,4,5] );
		public static const LEVEL_18:LevelVo = new LevelVo( 18, [2,3,3,2,2,2,3,4,4,4], [1,2,3,4,5] );
		public static const LEVEL_19:LevelVo = new LevelVo( 19, [2,3,3,2,2,2,3,4,4,4], [1,2,3,4,5] );
		public static const LEVEL_20:LevelVo = new LevelVo( 20, [2,3,3,2,2,2,3,4,4,4], [1,2,3,4,5] );
		public static const LEVEL_21:LevelVo = new LevelVo( 21, [2,3,3,2,2,2,3,4,4,4], [1,2,3,4,5] );
		public static const LEVEL_22:LevelVo = new LevelVo( 22, [2,3,3,2,2,2,3,4,4,4], [1,2,3,4,5] );
		public static const LEVEL_23:LevelVo = new LevelVo( 23, [2,3,3,2,2,2,3,4,4,4], [1,2,3,4,5] );
		public static const LEVEL_24:LevelVo = new LevelVo( 24, [2,3,3,2,2,2,3,4,4,4], [1,2,3,4,5] );
		public static const LEVEL_25:LevelVo = new LevelVo( 25, [2,3,3,2,2,2,3,4,4,4], [1,2,3,4,5] );
		public static const LEVEL_26:LevelVo = new LevelVo( 26, [2,3,3,2,2,2,3,4,4,4], [1,2,3,4,5] );
		public static const LEVEL_27:LevelVo = new LevelVo( 27, [2,3,3,2,2,2,3,4,4,4], [1,2,3,4,5] );
		
		public static function getLevelInfoByLevel( level:int ):LevelVo
		{
			var vo:LevelVo = LevelInfo["LEVEL_" + level];
			if ( vo ) return vo.clone();
			return new LevelVo();
		}
		
		
	}
}