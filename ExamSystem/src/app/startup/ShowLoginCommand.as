package app.startup
{
	import app.modules.ViewName;
	
	import victoryang.framework.BaseCommand;
	
	
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-9-9
	 */
	public class ShowLoginCommand extends BaseCommand
	{
		public function ShowLoginCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			openView( ViewName.Login );
		}
		
	}
}