package app.modules.login.register.vo
{
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-6
	 */
	public class RegisterVo
	{
		public function RegisterVo()
		{
		}
		/*
		帐号
		昵称
		密码
		
		学校名称
		年级
		联系方式
		qq
		邮箱
		*/
		
////// required
		/**
		 * 玩家姓名
		 */
		public var realName:String;
		/**
		 * 地址
		 */
		public var address:String;
		/**
		 * 昵称
		 */
		public var name:String;
		/**
		 * 密码
		 */
		public var password:String;
		/**
		 * 密码确认
		 */
		public var passwordConfirm:String;
		/**
		 * 性别
		 */
		public var gender:int = 0;

		
//////// Optional
		/**
		 * 学校名称
		 */
		public var school:String;
		/**
		 * 年级
		 */
		public var grade:String;
		/**
		 * 联系方式
		 */
		public var phone:String;
		/**
		 * QQ号码
		 */
		public var QQ:String;
		/**
		 * 电子邮箱
		 */
		public var email:String;
		/**
		 * 年龄
		 */
		public var age:int = 0;
		
	}
}