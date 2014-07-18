package app.startup
{
	import flash.events.Event;
	
	import app.data.GameData;
	import app.modules.chat.command.ChatInitCommand;
	import app.modules.fight.command.FightInitCommand;
	import app.modules.friend.command.FriendInitComand;
	import app.modules.login.command.LoginInitCommand;
	import app.modules.main.command.MainUIInitCommand;
	import app.modules.main.model.MainModel;
	import app.modules.map.command.MapInitCommand;
	import app.modules.model.CommonModel;
	import app.modules.model.PackModel;
	import app.modules.panel.PanelLoading;
	import app.modules.panel.personal.command.PersonalInitCommand;
	import app.modules.panel.rank.command.RankInitCommand;
	import app.modules.panel.share.ShareWeiboInitCommand;
	import app.modules.panel.test.TestInitCommand;
	import app.modules.serivce.CommonService;
	import app.modules.serivce.PackService;
	import app.modules.task.command.TaskInitCommand;
	
	import victor.framework.core.BaseCommand;
	import victor.framework.drag.DragManager;
	import victor.framework.events.PanelEvent;
	import victor.framework.events.ViewEvent;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-8-28
	 */
	public class InitCommand extends BaseCommand
	{
		// 初始化
		private static const INIT_COMMAND:String = "init_command";
		
		private static var commands:Array = 
			[
				, MainUIInitCommand		// 主界面UI
				, MapInitCommand		// 世界地圖
				, ChatInitCommand		// 聊天系统
				, FriendInitComand		// 好友系统
				, LoginInitCommand		// 登陆游戏
				, FightInitCommand		// 对战闯关系统
				, TaskInitCommand		// 任务系统
				, PersonalInitCommand	// 个人信息
				, RankInitCommand		// 排行系统
				, ShareWeiboInitCommand // 分享到微博
				, TestInitCommand
			];
		
		public function InitCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			//************  add events ************************************************//
			// 监听打开视图
			commandMap.mapEvent( ViewEvent.SHOW, ShowViewCommand, ViewEvent );
			// 监听关闭视图
			commandMap.mapEvent( ViewEvent.HIDE, ShowViewCommand, ViewEvent );
			// 监听关闭所有
			commandMap.mapEvent( ViewEvent.CLOSE_ALL, ShowViewCommand, ViewEvent );
			
			//////////////
			
			injectActor( DragManager );
			injectActor( GameData );
			
			/////////////
			
			injectActor( MainModel );
			injectActor( CommonModel );
			injectActor( PackModel );
			
			//////////////
			
			//************  initlialize commands ************************************************//
			// 初始化 command
			var len:int = commands.length;
			var initCommandClass:Class;
			for ( var i:int = 0; i < len; i++ )
			{
				initCommandClass = commands[ i ];
				if ( initCommandClass )
					commandMap.mapEvent( INIT_COMMAND, initCommandClass, Event, true );
			}
			dispatch( new Event( INIT_COMMAND ));
			
			//////////////
			
			injectActor( CommonService );
			injectActor( PackService );
			
			////
			PanelLoading.instance.setFun( loadStartHandler, loadEnfHandler );
			
		}
		
		private function loadEnfHandler():void
		{
			dispatch( new PanelEvent( PanelEvent.LOAD_END ));
		}
		
		private function loadStartHandler():void
		{
			dispatch( new PanelEvent( PanelEvent.LOAD_START ));
		}
		
	}
}