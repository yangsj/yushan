package app.modules.model.vo
{
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-24
	 */
	public class ItemVo
	{
		public function ItemVo()
		{
		}
		
		public function clone():ItemVo
		{
			var item:ItemVo = new ItemVo();
			item.num = num;
			item.type = type;
			item.isDisplayRound = true;
			return item;
		}
		
		/**
		 * 在关卡中显示
		 */
		public var isDisplayRound:Boolean = false;
		
		/**
		 * 
		 */
		public var type:int;
		
		/**
		 * 数量
		 */
		public function get num():int
		{
			return _num;
		}
		
		private var _num:int;
		public function set num(value:int):void
		{
			_num = Math.max( 0, value );
		}
		
		/**
		 * 使用间隔时间( 秒 )
		 */
		public function get intervalTime():int
		{
			return 10;
		}
		/**
		 * 需要消耗的金币值（无可用道具时使用）
		 */
		public function get contMoney():int
		{
			return MONEY[ type ];
		}
		
		/**
		 * 皮肤名称
		 */
		public function get skinId():String
		{
			return "ui_Skin_Round_PropItem_" + type;
		}
		
		/**
		 * 道具名称
		 */
		public function get name():String
		{
			return NAMES[type];
		}

		/**
		 * 道具描述
		 */
		public function get desc():String
		{
			var des:String = DESC[type];
			if ( isDisplayRound ) {
				des += hotKey;
			}
			return des;
		}
		
		public function get hotKey():String
		{
			return "【快捷键：数字键" + type + "】";
		}
		
		private static var _MONEY:Array;
		private static function get MONEY():Array
		{
			if ( _MONEY == null )
			{
				_MONEY = new Array(10);
				_MONEY[ItemType.HINT] 		= 500;//提示
				_MONEY[ItemType.EXTRA_TIME] = 500;//加时
				_MONEY[ItemType.SKIP] 		= 1000;//跳过
				_MONEY[ItemType.BROOM] 		= 600; //扫帚
				_MONEY[ItemType.BOMB] 		= 500; //炸弹
			}
			return _MONEY;
		}
		
		private static var _DESC:Array;
		private static function get DESC():Array
		{
			if ( _DESC == null )
			{
				_DESC = new Array(10);
				_DESC[ItemType.HINT] 		= "提示：提示下一个正确的单词字母";
				_DESC[ItemType.BOMB] 		= "炸弹：炸弹";
				_DESC[ItemType.EXTRA_TIME]	= "加时：增加当前关卡的游戏总时间";
				_DESC[ItemType.SKIP] 		= "跳过：直接跳过当前词语，出现下一个词语";
				_DESC[ItemType.BROOM] 		= "扫帚：清除屏幕上一切负面的干扰";
			}
			return _DESC;
		}
		
		private static var _NAMES:Array;
		private static function get NAMES():Array
		{
			if ( _NAMES == null )
			{
				_NAMES = new Array(10);
				_NAMES[ItemType.HINT] 		= "提示";
				_NAMES[ItemType.BOMB] 		= "炸弹";
				_NAMES[ItemType.EXTRA_TIME] = "加时";
				_NAMES[ItemType.SKIP] 		= "跳过";
				_NAMES[ItemType.BROOM] 		= "扫帚";
			}
			return _NAMES;
		}
	}
}