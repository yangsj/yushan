package app.startup
{
	import app.managers.FontManager;
	
	import net.victoryang.framework.BaseCommand;
	
	
	/**
	 * ……
	 * @author 	victor 
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