package app.modules.panel.test
{
	import app.modules.ViewName;
	
	import victoryang.deubg.Debug;
	import victoryang.framework.BaseCommand;
	
	
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-9-7
	 */
	public class TestInitCommand extends BaseCommand
	{
		public function TestInitCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			if ( Debug.isDebug ) {
				// 测试面板
				addView( ViewName.Test, TestView, TestMediator );
			}
			
		}
		
	}
}