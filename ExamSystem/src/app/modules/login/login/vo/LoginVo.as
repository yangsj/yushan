package app.modules.login.login.vo
{
	import app.managers.SharedObjectManager;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-6
	 */
	public class LoginVo
	{
		public function LoginVo()
		{
		}
		
		private var _accountName:String = "";
		private var _password:String = "";
		
		/**
		 * 帐号
		 */
		public function get accountName():String
		{
			if ( isRememberName )
				return ( SharedObjectManager.getData( "accountName" ) as String ) || "";
			return _accountName;
		}

		/**
		 * @private
		 */
		public function set accountName(value:String):void
		{
			if ( isRememberName )
				SharedObjectManager.setData( "accountName", value );
			else _accountName = value;
		}

		/**
		 * 密码
		 */
		public function get password():String
		{
			if ( isRememberPwd && isRememberName )
				return ( SharedObjectManager.getData( "password" ) as String ) || "";
			return _password;
		}

		/**
		 * @private
		 */
		public function set password(value:String):void
		{
			if ( isRememberPwd && isRememberName )
				SharedObjectManager.setData( "password", value );
			else _password = value;
		}

		/**
		 * 是否記住帳號
		 */
		public function get isRememberName():Boolean
		{
			return SharedObjectManager.getData( "isRememberName" );
		}
		
		/**
		 * @private
		 */
		public function set isRememberName(value:Boolean):void
		{
			SharedObjectManager.setData( "isRememberName", value );
		}
		
		/**
		 * 是否記住密碼
		 */
		public function get isRememberPwd():Boolean
		{
			return SharedObjectManager.getData( "isRememberPwd" );
		}
		
		/**
		 * @private
		 */
		public function set isRememberPwd(value:Boolean):void
		{
			SharedObjectManager.setData( "isRememberPwd", value );
		}
		
		/**
		 * 自動登陸
		 */
		public function get isAutoLogin():Boolean
		{
			return accountName && password;
		}
		
	}
}