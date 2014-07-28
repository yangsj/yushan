package app.startup
{
	import app.GameConfig;
	import app.events.GameEvent;
	
	import victoryang.deubg.Debug;
	import victoryang.framework.BaseCommand;
	
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-8-27
	 */
	public class FlashVarsCommand extends BaseCommand
	{
		public function FlashVarsCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			var parameters:Object = contextView.stage.loaderInfo.parameters;
			
			// 主机地址  (必须指定)【string】
			if ( parameters.hasOwnProperty( "ip" ))
				GameConfig.serverHost = parameters["ip"];
			else GameConfig.serverHost = "112.124.57.159";
			
			// 主机端口号(必须指定)【int】
			if ( parameters.hasOwnProperty( "port" ))
				GameConfig.serverPort = parameters["port"];
			else GameConfig.serverPort = 10242;
			
			// 玩家登录帐号(必须指定，若不指定则会跳转Flash注册页)【string】
			if ( parameters.hasOwnProperty( "uid" ))
				GameConfig.uid = parameters[ "uid" ];
			else GameConfig.uid = "";
			
			// 玩家帐号密码(必须指定，若不指定则会跳转Flash注册页)【string】
			if ( parameters.hasOwnProperty( "key" ))
				GameConfig.key = parameters[ "key" ];
			else GameConfig.key = "";
			
			
			// 环境部署地址(可选指定，默认读取主程序目录加载资源)【string】
			if ( parameters.hasOwnProperty( "deployPath" ))
				GameConfig.deployPath = parameters.deployPath;
			
			// 是否是调试状态（默认非调试，预留可以方便维护中查看数据）【Boolean】
			if ( parameters.hasOwnProperty( "debug" ))
				Debug.isDebug = parameters.debug;
			
			
			setDebug();
			
			dispatch( new GameEvent( GameEvent.ANALYTIC_WEB_PARAMS_COMMPLETE ));
		}
		
		private function setDebug():void
		{
			if ( Debug.isDebug )
			{
				// 初始化调试工具
				Debug.initStage( contextView.stage );
			}
		}
		
	}
}