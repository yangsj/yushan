package app.modules.main.view
{
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import app.core.Tips;
	import app.data.GameData;
	import app.managers.ExternalManager;
	import app.modules.ViewName;
	import app.modules.fight.model.FightModel;
	import app.modules.friend.event.FriendEvent;
	import app.modules.main.FunctionBtnConfig;
	import app.modules.main.event.MainUIEvent;
	import app.modules.task.event.TaskEvent;
	import app.modules.task.service.TaskService;
	
	import victor.framework.core.BaseMediator;
	import victor.framework.debug.Debug;
	import victor.framework.events.PanelEvent;
	import victor.framework.events.ViewEvent;
	import victor.framework.manager.TickManager;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-10
	 */
	public class MainUIMediator extends BaseMediator
	{
		[Inject]
		public var view:MainUIView;
		[Inject]
		public var fightModel:FightModel;
		[Inject]
		public var taskService:TaskService;
		
		public function MainUIMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			
			// 经验条进度更新
			addContextListener( MainUIEvent.UPDATE_EXP, updateExpHandler, MainUIEvent );
			// 经验条进度更新
			addContextListener( MainUIEvent.UPDATE_MONEY, updateMoneyHandler, MainUIEvent );
			// 经验条进度更新
			addContextListener( MainUIEvent.UPDATE_PROPERTY, updatePropertyHandler, MainUIEvent );
			// 有可领取任务
			addContextListener( TaskEvent.HAS_NEW_TASK, hasNewTaskHandler, TaskEvent );
			
			initData();
			
			taskService.pullTaskList();

			// 检查是否有完成的任务
			TickManager.doTimeout( function abc():void
			{
				// 检查登陆是否有完成任务消息
				dispatch( new TaskEvent( TaskEvent.TASK_CHECK_COMPLETED ));
				// 检查登陆是否有加好友消息
				dispatch( new FriendEvent( FriendEvent.CHECK_ADD ));
				// 检查好友邀请对战
				dispatch( new PanelEvent( PanelEvent.LOAD_END ));
			}, 1000 );
			
			if ( Debug.isDebug ) {
				view.stage.addEventListener(KeyboardEvent.KEY_UP, keyboardHandler );
			}
		}
		
		private function hasNewTaskHandler( event:TaskEvent ):void
		{
			if (　event.data ) 
			{
				view.displayTaskMark();
			}
			else 
			{
				view.hideTaskMark();
			}
		}
		
		protected function keyboardHandler(event:KeyboardEvent):void
		{
			if ( !fightModel.isFighting )
			{
				Debug.debug(event.ctrlKey, event.shiftKey , Keyboard.A == event.keyCode)
				if ( event.ctrlKey && event.shiftKey && Keyboard.A == event.keyCode ) {
					ExternalManager.shareWeibo();
				}
				
				if ( event.keyCode == Keyboard.D ) {
					dispatch( new ViewEvent( ViewEvent.SHOW, ViewName.Test ));
				}
			}
		}
		
		private function initData():void
		{
			updateExpHandler();
		}
		
		private function updateExpHandler( event:MainUIEvent = null ):void
		{
			view.updateLevelExp( GameData.instance.selfVo.level, GameData.instance.selfVo.exp );
		}
		
		private function updatePropertyHandler( event:MainUIEvent = null ):void
		{
			updateExpHandler( null );
		}
		
		private function updateMoneyHandler( event:MainUIEvent = null ):void
		{
			updateExpHandler( null );
		}
		
		override protected function showViewHandler( event:ViewEvent ):void
		{
			var viewName:String = event.viewName;
			Debug.debug( "open Function name:" + viewName );
			switch ( viewName )
			{
				case FunctionBtnConfig.FIGHT:
					if ( GameData.instance.selfVo.level < 10 ){
						Tips.showMouse( "等级达到10级开启在线对战功能！！！" );
						return ;
					}
					view.displayFightMenu();
					break;
				case FunctionBtnConfig.EXIT:
					Tips.showMouse( "功能开发中敬请期待！" );
					break;
				default :
					openView( viewName );
			}
		}
		
	}
}