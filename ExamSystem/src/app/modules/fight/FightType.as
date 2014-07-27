package app.modules.fight
{
	
	/**
	 * @author 	victor 
	 * 			2013-9-11
	 */
	public class FightType
	{
		public function FightType()
		{
		}
		
		/**
		 * 简单（难度）（闯关）
		 */
		public static const MODE_EASY:uint = 1;
		/**
		 * 进阶（难度）（闯关）
		 */
		public static const MODE_MIDDLE:uint = 2;
		/**
		 * 达人（难度）（闯关）
		 */
		public static const MODE_ADVANCED:uint = 3;
		
		/**
		 * 练习
		 */
		public static const MODE_PRACTICE:int = 4;
		
		/**
		 * 对战
		 */
		public static const MODE_BATTLE:int = 5;
		
		/**
		 * 错误练习
		 */
		public static const MODE_ERROR:int = 6;
		
		
		
		/**
		 * 字母最长长度
		 */
		public static const MAX_LENGTH:int = 20;
		
		/**
		 * 使用到过道具时，一次输入每个字母的间隔时间(毫秒)
		 */
		public static const SKIP_TIME_PER_LETTER:int = 300;
		
	}
}