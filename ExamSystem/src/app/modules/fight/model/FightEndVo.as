package app.modules.fight.model
{
	import app.modules.model.vo.ItemVo;
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-9-28
	 */
	public class FightEndVo
	{
		public function FightEndVo()
		{
		}
		
		/*
		1:bool win = false//!是否过关
		2:i32 inc_star = 0//获得的星星
		3:i32 inc_exp  = 0//获得的经验
		4:i32 cur_level = 0//!当前的等级
		5:map<i32, i32> inc_items//!增加的道具
		6:i16 right_num = 0 //!此次闯关答对的单词的数量
		7:list<string> wrong_words//!此次闯关答错的单词
		*/
		/**
		 * 是否通关
		 */
		public var isWin:Boolean;
		/**
		 * 关卡星级评分
		 */
		public var starNum:int;
		/**
		 * 获得的经验
		 */
		public var addExp:int;
		/**
		 * 获得的钻石
		 */
		public var addMoney:int;
		/**
		 * 当前的等级
		 */
		public var currentLevel:int;
		/**
		 * 答对的单词数量
		 */
		public var rightNum:int;
		/**
		 * 答错的单词列表
		 */
		public var wrongList:Array;
		/**
		 * 获得的道具列表
		 */
		public var items:Vector.<ItemVo> = new Vector.<ItemVo>();
		
		
	}
}