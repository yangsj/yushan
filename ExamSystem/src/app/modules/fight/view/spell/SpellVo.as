package app.modules.fight.view.spell
{
	import app.modules.fight.model.LetterBubbleVo;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-27
	 */
	public class SpellVo
	{
		public function SpellVo()
		{
		}
		
		/**
		 * 中文释义
		 */
		public var chinese:String = "中文";
		
		/**
		 * 显示的字母数据
		 */
		public var items:Vector.<LetterBubbleVo>;
		
		/**
		 * 字符长度
		 */
		public function get charsLength():int
		{
			return items.length;
		}
		
		public var english:String = "english";
		
	}
}