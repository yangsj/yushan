package app.startup
{
	import app.managers.ExternalManager;
	import app.modules.serivce.CommonService;
	
	import victoryang.core.SystemInfo;
	import victoryang.framework.BaseCommand;
	
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2014-1-4
	 */
	public class JsCallbackCommand extends BaseCommand
	{
		/*============================================================================*/
		/* private variables                                                          */
		/*============================================================================*/
		
		[Inject]
		public var commonService:CommonService;
		
		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/
		public function JsCallbackCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			if ( SystemInfo.isPc )
			{
				ExternalManager.addCallback( "shareWeiboSuccessCallFlash", shareWeiboSuccessCallFlash );
			}
		}
		
		private function shareWeiboSuccessCallFlash():void
		{
			commonService.shareWeiboSuccessSendToServer();
		}
		
		/*============================================================================*/
		/* private functions                                                          */
		/*============================================================================*/
		
		
		
		/*============================================================================*/
		/* protected functions                                                        */
		/*============================================================================*/
		
		
		
		/*============================================================================*/
		/* events handlers                                                            */
		/*============================================================================*/
		
		
		
		/*============================================================================*/
		/* override functions                                                         */
		/*============================================================================*/
		
		
		
		/*============================================================================*/
		/* public functions                                                           */
		/*============================================================================*/
		
		
		
		/*============================================================================*/
		/* public variables                                                           */
		/*============================================================================*/
		
		
		
	}
}