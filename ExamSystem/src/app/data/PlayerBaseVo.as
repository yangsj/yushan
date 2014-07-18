package app.data
{
	import app.GameConfig;
	
	import org.robotlegs.mvcs.Actor;
	
	import victor.utils.MathUtil;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-18
	 */
	public class PlayerBaseVo extends Actor
	{
		public function PlayerBaseVo()
		{
			super();
		}
		
		///////////////////////////////////////////////////////
		
		private var _name:String = "凌云";
		private var _realName:String;
		private var _uid:int;
		private var _exp:int;
		private var _level:int = 1;
		private var _money:int;
		private var _rightWordsNum:int;
		private var _wrongWordsNum:int;
		private var _phone:String;
		private var _email:String;
		private var _address:String;
		private var _school:String;
		private var _grade:String;
		private var _qq:String;
		private var _gender:int;
		
		////////////////////////////////////////////////////////
		
		/**
		 * 玩家名称
		 */
		public function get name():String
		{
			return _name;
		}
		
		/**
		 * @private
		 */
		public function set name(value:String):void
		{
			_name = value;
		}
		
		/**
		 * 真实名字
		 */
		public function get realName():String
		{
			return _realName;
		}
		
		/**
		 * @private
		 */
		public function set realName(value:String):void
		{
			_realName = value;
		}
		
		/**
		 * 玩家uid
		 */
		public function get uid():int
		{
			return _uid;
		}
		
		/**
		 * @private
		 */
		public function set uid(value:int):void
		{
			_uid = value;
		}
		
		/**
		 * 玩家当前经验
		 */
		public function get exp():int
		{
			return _exp;
		}
		
		/**
		 * @private
		 */
		public function set exp(value:int):void
		{
			_exp = value;
		}
		
		/**
		 * 玩家等级
		 */
		public function get level():int
		{
			return _level;
		}
		
		/**
		 * @private
		 */
		public function set level(value:int):void
		{
			_level = MathUtil.range( value, 1, GameConfig.MAX_LEVEL );
		}

		/**
		 * 货币
		 */
		public function get money():int
		{
			return _money;
		}

		/**
		 * @private
		 */
		public function set money(value:int):void
		{
			_money = value;
		}

		/**
		 * 答对的单词数量
		 */
		public function get rightWordsNum():int
		{
			return _rightWordsNum;
		}

		/**
		 * @private
		 */
		public function set rightWordsNum(value:int):void
		{
			_rightWordsNum = value;
		}

		/**
		 * 答错的单词数量
		 */
		public function get wrongWordsNum():int
		{
			return _wrongWordsNum;
		}

		/**
		 * @private
		 */
		public function set wrongWordsNum(value:int):void
		{
			_wrongWordsNum = value;
		}

		/**
		 * 电话号码
		 */
		public function get phone():String
		{
			return _phone;
		}

		/**
		 * @private
		 */
		public function set phone(value:String):void
		{
			_phone = value;
		}

		/**
		 * 邮箱地址
		 */
		public function get email():String
		{
			return _email;
		}

		/**
		 * @private
		 */
		public function set email(value:String):void
		{
			_email = value;
		}

		/**
		 * 地址
		 */
		public function get address():String
		{
			return _address;
		}

		/**
		 * @private
		 */
		public function set address(value:String):void
		{
			_address = value;
		}

		/**
		 * 学校
		 */
		public function get school():String
		{
			return _school;
		}

		/**
		 * @private
		 */
		public function set school(value:String):void
		{
			_school = value;
		}

		/**
		 * 年级
		 */
		public function get grade():String
		{
			return _grade;
		}

		/**
		 * @private
		 */
		public function set grade(value:String):void
		{
			_grade = value;
		}

		/**
		 * qq号码
		 */
		public function get qq():String
		{
			return _qq;
		}

		/**
		 * @private
		 */
		public function set qq(value:String):void
		{
			_qq = value;
		}

		/**
		 * 性别
		 */
		public function get gender():int
		{
			return _gender;
		}

		/**
		 * @private
		 */
		public function set gender(value:int):void
		{
			_gender = value;
		}


	}
}