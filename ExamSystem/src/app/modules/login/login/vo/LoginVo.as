package app.modules.login.login.vo
{
	
	import victoryang.managers.LocalStoreManager;
	
	/**
	 * ……
	 * @author 	victor 
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
				return ( LocalStoreManager.getData( "accountName" ) as String ) || "";
			return _accountName;
		}

		/**
		 * @private
		 */
		public function set accountName(value:String):void
		{
			if ( isRememberName )
				LocalStoreManager.setData( "accountName", value );
			else _accountName = value;
		}

		/**
		 * 密码
		 */
		public function get password():String
		{
			if ( isRememberPwd && isRememberName )
				return ( LocalStoreManager.getData( "password" ) as String ) || "";
			return _password;
		}

		/**
		 * @private
		 */
		public function set password(value:String):void
		{
			if ( isRememberPwd && isRememberName )
				LocalStoreManager.setData( "password", value );
			else _password = value;
		}

		/**
		 * 是否記住帳號
		 */
		public function get isRememberName():Boolean
		{
			return LocalStoreManager.getData( "isRememberName" );
		}
		
		/**
		 * @private
		 */
		public function set isRememberName(value:Boolean):void
		{
			LocalStoreManager.setData( "isRememberName", value );
		}
		
		/**
		 * 是否記住密碼
		 */
		public function get isRememberPwd():Boolean
		{
			return LocalStoreManager.getData( "isRememberPwd" );
		}
		
		/**
		 * @private
		 */
		public function set isRememberPwd(value:Boolean):void
		{
			LocalStoreManager.setData( "isRememberPwd", value );
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