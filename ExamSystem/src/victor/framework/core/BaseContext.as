package victor.framework.core
{
	import flash.display.DisplayObjectContainer;
	
	import org.robotlegs.mvcs.Context;
	
	import victor.framework.manager.TickManager;
	import victor.utils.apps;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-8-5
	 */
	public class BaseContext extends Context
	{
		public function BaseContext(contextView:DisplayObjectContainer=null, autoStartup:Boolean=true)
		{
			super(contextView, autoStartup);
		}
		
		override public function startup():void
		{
			initManager();
			addStartupCommand()
			
			super.startup();
		}
		
		protected function initManager() : void
		{
			// 初始化视图结构管理器
			ViewStruct.initialize( contextView );
			
			// 计时器管理器
			TickManager.instance.init( apps.frameRate );
		}
		
		protected function addStartupCommand() : void
		{
			
		}
	}
}