package app.managers
{
	import flash.external.ExternalInterface;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-10-18
	 */
	public class ExternalManager
	{
		public function ExternalManager()
		{
		}
		
		public static function addCallback( funName:String, fun:Function ):void
		{
			if ( ExternalInterface.available )
			{
				ExternalInterface.addCallback( funName, fun );
			}
		}
		
		public static function reload():void
		{
			callJs( "reload" );
		}
		
		public static function shareWeibo():void
		{
			callJs( "share_weibo", "分享到微博拿奖励!!!成功分享后宝石 +500" );
		}
		
		/**
		 * 跳转到平台注册页面
		 */
		public static function gotoHtmlRegister():void
		{
			var urlHtml:String = "http://www.sspclub.com.cn/Register_registration.action";
			navigateToURL(new URLRequest( urlHtml ), "_blank");
		}
		
		public static function callJs(...arg):void
		{
			if ( ExternalInterface.available )
			{
				ExternalInterface.call.apply( null, arg );
			}
		}
		
	}
}