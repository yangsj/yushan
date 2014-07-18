package app.startup
{
	import app.managers.FontManager;
	
	import victor.framework.core.BaseCommand;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-10-16
	 */
	public class InitFontCommand extends BaseCommand
	{
		public function InitFontCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			FontManager.init();
		}
		
	}
}