package app.startup
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import app.GameConfig;
	import app.events.GameEvent;
	import app.modules.login.service.LoginService;
	import app.sound.SoundManager;
	
	import victoryang.components.Tips;
	import victoryang.deubg.Debug;
	import victoryang.framework.BaseCommand;
	import victoryang.managers.LoaderManager;
	
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-9-9
	 */
	public class InitDataCommand extends BaseCommand
	{
		[Inject]
		public var loginService:LoginService;
		
		public function InitDataCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			var url:String = GameConfig.deployPath + "application.xml?t=" + new Date().time;
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, completeHandler );
			loader.addEventListener(IOErrorEvent.IO_ERROR, errorHandler );
			loader.load( new URLRequest( url ));
		}
		
		protected function completeHandler(event:Event):void
		{
			var loader:URLLoader = event.target as URLLoader;
			removeEvent( loader );
			
			LoaderManager.instance.setApplicationConfig( new XML(loader.data));
			
			if ( GameConfig.canImmediateLogin )
			{
				// 播放主界面背景音乐
				SoundManager.playMainSceneSoundBg();
				
				// 开始登录
				loginService.login( GameConfig.immediateLoginVo );
			}
			else
			{
				// 资源初始化完成
				dispatch( new GameEvent( GameEvent.DATA_INIT_COMPLETE ));
			}
			dispatch( new GameEvent( GameEvent.SET_PLAYER_MENU ));
		}
		
		protected function errorHandler(event:IOErrorEvent):void
		{
			removeEvent( event.target as URLLoader );
			Debug.error( event.text );
			Tips.showCenter( "application.xml load error" );
		}
		
		private function removeEvent( loader:URLLoader ):void
		{
			if ( loader )
			{
				loader.removeEventListener(Event.COMPLETE, completeHandler );
				loader.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler );
			}
		}
		
	}
}