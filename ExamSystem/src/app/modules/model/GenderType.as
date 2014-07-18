package app.modules.model
{
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-10-19
	 */
	public class GenderType
	{
		public function GenderType()
		{
		}
		
		/**
		 * 男性
		 */
		public static const MALE:int = 0;
		/**
		 * 女性
		 */
		public static const FEMALE:int = 1;
		
		/**
		 * 根据性别获取对应的颜色
		 * @param gender
		 * @return 
		 */
		public static function getColor( gender:int ):uint
		{
			return [0x006699, 0x996699][gender];
		}
		
	}
}