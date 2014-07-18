package app.modules.login.command
{
	import app.events.GameEvent;
	import victor.framework.events.LoadEvent;
	import victor.framework.manager.LoaderManager;
	import app.modules.ViewName;
	import app.sound.SoundManager;
	
	import victor.framework.core.BaseCommand;
	import victor.framework.debug.Debug;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-9
	 */
	public class FirstLoadCommand extends BaseCommand
	{
		public function FirstLoadCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			openView( ViewName.Preloader, 1 );
			LoaderManager.instance.startFirstLoad( loaderCompleteCallBack, loaderProgressCallBack );
		}
		
		private function loaderCompleteCallBack():void
		{
			Debug.debug( "登陆资源加载完毕！！！" );
			dispatch( new GameEvent( GameEvent.FIRST_LOAD_COMPLETE ));
			
			closeView( ViewName.Preloader );
			
			// 播放主界面背景音乐
			SoundManager.playMainSceneSoundBg();
		}
		
		private function loaderProgressCallBack( perent:Number ):void
		{
			dispatch( new LoadEvent( LoadEvent.LOAD_PROGRESS, perent ));
		}
		
	}
}