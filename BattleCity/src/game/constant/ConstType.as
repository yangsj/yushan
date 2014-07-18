package game.constant
{
	
	/**
	 * 常量定义
	 * @author victor
	 * 			2014-6-30
	 */
	public class ConstType
	{
		public static const MONSTER_MAX_NUM:int	= 10;
		
		public static const WIDTH:Number 	= 38;
		public static const HEIGHT:Number 	= 38;
		
		public static const ROW:int 	= 20;
		public static const COL:int 	= 13;
		public static const MAX_ROW:int	= ROW - 1;
		public static const MAX_COL:int = COL - 1;
		public static const MAX_DIST_X:int	= WIDTH * MAX_ROW;
		public static const MAX_DIST_Y:int	= HEIGHT* MAX_COL;
		
		public static const UP:int 		= 0;
		public static const RIGHT:int 	= 1;
		public static const DOWN:int 	= 2;
		public static const LEFT:int 	= 3;
		
		public static const SHOOT:int	= 4;
		
		// 子弹类型
		public static const BULLET_1:int = 1;
		public static const BULLET_2:int = 2;
		
		// 
		public static const HOST:int 	= 0;
		public static const PLAYER:int 	= 1;
		public static const ENEMY:int 	= 2;
		public static const BULLET:int 	= 3;
		public static const WALL:int	= 4;
		public static const PROP:int	= 5;
		
		///////////// 怪物类型
		public static const MONSTER_TYPE_1:int = 1;
		public static const MONSTER_TYPE_2:int = 2;
		public static const MONSTER_TYPE_3:int = 3;
		public static const MONSTER_TYPE_4:int = 4;
		
		///////////// 道具类型
		public static const PROP_ITEM_1:int = 1; // 变钢墙
		public static const PROP_ITEM_2:int = 2; // 停止enemy动作
		public static const PROP_ITEM_3:int = 3; // 导弹
		public static const PROP_ITEM_4:int = 4; // 炸弹
		public static const PROP_ITEM_5:int = 5; // 无敌
		
		public static const PROP_ITEM_TIME_1:int = 0;
		public static const PROP_ITEM_TIME_2:int = 7;
		public static const PROP_ITEM_TIME_3:int = 15;
		public static const PROP_ITEM_TIME_4:int = 0;
		public static const PROP_ITEM_TIME_5:int = 10;
		
		public static const PASS_ROUND_REWARD_SCORE:int = 1000;
		
		public static function getRandomDirection( lastDirection:int ):int
		{
			var rand:int = int( Math.random() * 4 );
			while ( rand == lastDirection )
			{
				rand = int( Math.random() * 4 );
			}
			return rand;
		}
		
	}
}