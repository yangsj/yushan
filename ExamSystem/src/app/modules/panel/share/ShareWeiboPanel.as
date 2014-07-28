package app.modules.panel.share
{
	import flash.display.InteractiveObject;
	import flash.events.MouseEvent;
	
	import victoryang.framework.BasePanel;
	
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-11-13
	 */
	public class ShareWeiboPanel extends BasePanel
	{
		/*============================================================================*/
		/* private variables                                                          */
		/*============================================================================*/
		
		public var btnShare:InteractiveObject;
		
		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/
		public function ShareWeiboPanel()
		{
			super();
		}
		
		/*============================================================================*/
		/* private functions                                                          */
		/*============================================================================*/
		
		
		
		/*============================================================================*/
		/* events handlers                                                            */
		/*============================================================================*/
		
		protected function onClickBtnShareHandler(event:MouseEvent):void
		{
			dispatchEvent( new ShareWeiboEvent( ShareWeiboEvent.SHARE_WEIBO ));
		}
		
		/*============================================================================*/
		/* override functions                                                         */
		/*============================================================================*/
		
		override protected function onceInit():void
		{
			super.onceInit();
			btnShare.addEventListener(MouseEvent.CLICK, onClickBtnShareHandler );
		}
		
		override protected function get resNames():Array
		{
			return ["ui_share_weibo"];
		}
		
		override protected function get skinName():String
		{
			return "ui_Skin_ShareWeiboPanel";
		}
		
		/*============================================================================*/
		/* public functions                                                           */
		/*============================================================================*/
		
		
		
		/*============================================================================*/
		/* public variables                                                           */
		/*============================================================================*/
		
		
		
	}
}