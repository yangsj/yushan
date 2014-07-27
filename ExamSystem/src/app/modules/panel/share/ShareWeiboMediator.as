package app.modules.panel.share
{
	import app.managers.ExternalManager;
	
	import net.victoryang.framework.BaseMediator;
	
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-11-13
	 */
	public class ShareWeiboMediator extends BaseMediator
	{
		/*============================================================================*/
		/* private variables                                                          */
		/*============================================================================*/
		
		[Inject]
		public var view:ShareWeiboPanel;
		
		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/
		public function ShareWeiboMediator()
		{
			super();
		}
		
		/*============================================================================*/
		/* events handlers                                                            */
		/*============================================================================*/
		
		private function shareWeiboHandler( event:ShareWeiboEvent ):void
		{
			view.hide();
			ExternalManager.shareWeibo();
		}	
		
		/*============================================================================*/
		/* override functions                                                         */
		/*============================================================================*/
		
		override public function onRegister():void
		{
			super.onRegister();
			
			addViewListener( ShareWeiboEvent.SHARE_WEIBO, shareWeiboHandler, ShareWeiboEvent );
		}	
		
	}
}