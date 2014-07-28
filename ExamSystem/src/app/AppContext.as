package app
{
	import flash.display.DisplayObjectContainer;
	
	import app.events.GameEvent;
	import app.modules.login.command.FirstLoadCommand;
	import app.modules.login.command.MainLoadCommand;
	import app.startup.BackgroundSoundActivateCommand;
	import app.startup.EnterGameCommand;
	import app.startup.FlashVarsCommand;
	import app.startup.InitCommand;
	import app.startup.InitDataCommand;
	import app.startup.InitFontCommand;
	import app.startup.InitServiceCommand;
	import app.startup.JsCallbackCommand;
	import app.startup.SetPlayerMenuCommand;
	import app.startup.ShowLoginCommand;
	
	import victoryang.framework.BaseEntry;
	
	import org.robotlegs.base.ContextEvent;
	
	import victor.framework.events.ServiceEvent;
	
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-8-27
	 */
	public class AppContext extends BaseEntry
	{
		public function AppContext(contextView:DisplayObjectContainer=null, autoStartup:Boolean=true)
		{
			super(contextView, autoStartup);
		}
		
		override protected function initManager():void
		{
			super.initManager();
			
		}
		
		override protected function addStartupCommand() : void
		{
			// 解析传flash的参数值
			commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, FlashVarsCommand, ContextEvent, true);
			
			// 应用程序背景音乐控制
			commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, BackgroundSoundActivateCommand, ContextEvent, true);
			
			// 应用程序背景音乐控制
			commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, JsCallbackCommand, ContextEvent, true);
			
			// 初始化网络
			commandMap.mapEvent(GameEvent.ANALYTIC_WEB_PARAMS_COMMPLETE, InitServiceCommand, GameEvent, true);
			
			// 初始化command | 功能模块
			commandMap.mapEvent(GameEvent.ANALYTIC_WEB_PARAMS_COMMPLETE, InitCommand, GameEvent, true);
			
			// 初始化application资源数据
			commandMap.mapEvent(ServiceEvent.CONNECTED, InitDataCommand, ServiceEvent, true);
			
			// 设置flash player 菜单
			commandMap.mapEvent(GameEvent.SET_PLAYER_MENU, SetPlayerMenuCommand, GameEvent, true );
			
			// 开始第一阶段资源加载
			commandMap.mapEvent(GameEvent.DATA_INIT_COMPLETE, FirstLoadCommand, GameEvent, true );
			
			// 进入登陆/注册界面
			commandMap.mapEvent(GameEvent.FIRST_LOAD_COMPLETE, ShowLoginCommand, GameEvent, true );
			
			// 登陆成功后加载进入游戏主资源
			commandMap.mapEvent(GameEvent.LOGIN_SUCCESSED, MainLoadCommand, GameEvent, true );
			
			//********** 以下几个条件检查是否进入游戏
			
			// 初始化字体
			commandMap.mapEvent(GameEvent.MAIN_LOAD_COMPLETE, InitFontCommand, GameEvent, true);
			
			// 资源加载完成进入游戏场景检查
			commandMap.mapEvent(GameEvent.MAIN_LOAD_COMPLETE, EnterGameCommand, GameEvent, true);
			
			// 地图数据获取到进入游戏检查
			commandMap.mapEvent(GameEvent.ACQUIRE_MAP_DATA, EnterGameCommand, GameEvent, true);
			
			// 获取到好友列表数据进入游戏检查
			commandMap.mapEvent(GameEvent.ACQUIRE_FRIEND_DATA, EnterGameCommand, GameEvent, true);
			
			// 获取到任务数据进入游戏检查
			commandMap.mapEvent(GameEvent.ACQUIRE_TASK_DATA, EnterGameCommand, GameEvent, true);
			
			//*********** 登陆数据拉取及加载进度检查
			
			
		}
		
	}
}