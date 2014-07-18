package app.modules.login.register
{
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-26
	 */
	public class RegisterConfig
	{
		public function RegisterConfig()
		{
		}
		
		public static const AREA_NAME:Array = [ 
												[ "黄浦区", 1 ], 
												[ "卢湾区", 2 ], 
												[ "金山区", 3 ], 
												[ "徐汇区", 4 ], 
												[ "长宁区", 5 ], 
												[ "静安区", 6 ], 
												[ "普陀区", 7 ], 
												[ "闸北区", 8 ], 
												[ "虹口区", 9 ], 
												[ "杨浦区", 10 ], 
												[ "闵行区", 11 ], 
												[ "宝山区", 12 ], 
												[ "嘉定区", 13 ], 
												[ "浦东新区", 14 ], 
												[ "松江区", 15 ], 
												[ "青浦区", 16 ], 
												[ "南汇区", 17 ], 
												[ "奉贤区", 18 ], 
												[ "崇明县", 19 ]
											];

		public static const GRADE_NAME:Array = [
												[ "一年级", 1 ], 
												[ "二年级", 2 ], 
												[ "三年级", 3 ], 
												[ "四年级", 4 ], 
												[ "五年级", 5 ], 
												[ "六年级", 6 ], 
												[ "七年级", 7 ], 
												[ "八年级", 8 ], 
												[ "九年级", 9 ], 
												[ "高一", 10 ], 
												[ "高二", 11 ], 
												[ "高三", 12 ]
											];
		
		/**
		 * 
		 * @param areaName
		 * @return 
		 * 
		 */
		public static function getAreaIndexByName( areaName:String ):int
		{
			for each ( var ary:Array in AREA_NAME )
			{
				if ( ary[0] == areaName )
					return ary[1];
			}
			return -1;
		}
		
		public static function getGradeIndexByName( gradeName:String ):int
		{
			for each ( var ary:Array in GRADE_NAME )
			{
				if ( ary[0] == gradeName )
					return ary[1];
			}
			return -1;
		}
		
	}
}