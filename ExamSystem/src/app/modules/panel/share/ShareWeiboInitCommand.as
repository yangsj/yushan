package app.modules.panel.share
{
	import app.modules.ViewName;
	
	import victoryang.framework.BaseCommand;
	
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-11-13
	 */
	public class ShareWeiboInitCommand extends BaseCommand
	{
		/*============================================================================*/
		/* private variables                                                          */
		/*============================================================================*/
		
		
		
		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/
		public function ShareWeiboInitCommand()
		{
			super();
		}
		
		/*============================================================================*/
		/* override functions                                                         */
		/*============================================================================*/
		
		
		override public function execute():void
		{
			
			addView( ViewName.ShareWeiboPanel, ShareWeiboPanel, ShareWeiboMediator );
			
		}
		
		
	}
}