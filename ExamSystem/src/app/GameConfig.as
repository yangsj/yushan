package app
{
	import app.modules.login.login.vo.LoginVo;
	
	import net.victoryang.func.apps;
	import net.victoryang.managers.LoaderManager;
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-8-27
	 */
	public class GameConfig
	{
		/**
		 * 密码是否使用md5加密
		 */
		public static var IS_MD5:Boolean = true;
		
		/**
		 * 最大等级
		 */
		public static const MAX_LEVEL:int = 60;
		
		/**
		 * 主机地址
		 */
		public static var serverHost:String = "112.124.57.159";
		/**
		 * 主机端口
		 */
		public static var serverPort:int = 10242;
		
		/**
		 * 用户id
		 */
		public static var uid:String;
		
		/**
		 * 登陆key
		 */
		public static var key:String;
		
		public static const stageWidth:Number = 960;
		public static const stageHeight:Number = 560;
		
		
		public function GameConfig()
		{
		}
		
/////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////          game url        ////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
		
		private static var _deployPath:String = "";
		
		/**
		 * 部署地址
		 */
		public static function get deployPath():String
		{
			if ( _deployPath == "" )
			{
				_deployPath = apps.loaderInfo.url;
				_deployPath = _deployPath.replace(/\\/g, "/");
				_deployPath = _deployPath.substring(0, _deployPath.lastIndexOf("/") + 1);
				
				LoaderManager.deployPath = _deployPath;
			}
			return _deployPath;
		}
		
		public static function set deployPath( value:String ):void
		{
			if ( value )
			{
				_deployPath = value.replace(/\\/g, "/") + "/";
				LoaderManager.deployPath = deployPath;
			}
		}
		
		/////////// static vars
		
		/**
		 * 是否可以直接登陆[ 若是页面已给玩家的uid和key则直接登录  ]
		 */
		public static function get canImmediateLogin():Boolean
		{
			return Boolean( uid ) && Boolean( key );
		}

		public static function get VERSION():String
		{
			return LoaderManager.VERSION;
		}
		
		public static function get immediateLoginVo():LoginVo
		{
			var loginVo:LoginVo = new LoginVo();
			loginVo.accountName = GameConfig.uid;
			loginVo.password = GameConfig.key;
			return loginVo;
		}

		
	}
}