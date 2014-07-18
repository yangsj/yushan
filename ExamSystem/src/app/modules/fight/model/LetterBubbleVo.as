package app.modules.fight.model
{
	import app.modules.model.vo.ItemType;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-28
	 */
	public class LetterBubbleVo
	{

		/**
		 * 字母出现的顺序( 0开始
		 */
		public var index:int;
		/**
		 * 字母id
		 */
		public var id:int;
		/**
		 * 字母
		 */
		public var letter:String;
		/**
		 * 道具类型
		 * @see app.modules.model.vo.ItemType
		 */
		public var itemType:int;
		
		/**
		 * 是否是字母泡泡
		 */
		public function get isLetter():Boolean
		{
			return itemType == ItemType.DEFAULT;
		}
		
		/**
		 * 小写字母
		 */
		public function get lowerCase():String
		{
			return letter.toLocaleLowerCase();
		}
		
		/**
		 * 大写字母
		 */
		public function get upperCase():String
		{
			return letter.toLocaleUpperCase();
		}
		
		public function get displayCase():String
		{
			return lowerCase;
			return _isUpperCase ? upperCase : lowerCase;
		}
		
		private var _isUpperCase:Boolean = false;
		public function set isUpperCase(value:Boolean):void
		{
			_isUpperCase = value;
		}
		
	}
}