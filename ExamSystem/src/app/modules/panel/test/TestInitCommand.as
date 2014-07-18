package app.modules.panel.test
{
	import app.modules.ViewName;
	
	import victor.framework.core.BaseCommand;
	import victor.framework.debug.Debug;
	
	
	/**
	 * ……
	 * @author 	yangsj 
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