package victor.framework.debug
{

	import com.junkbyte.console.Cc;
	
	import flash.display.Stage;
	import flash.external.ExternalInterface;
	import flash.system.Capabilities;
	
	/**
	 * @author
	 */
	public class Debug
	{
		/**
		 * 打印警告数据
		 * @param args
		 */
		public static function warn( ... args ):void
		{
			if ( isDebug )
			{
				var msg:String = JSON.stringify( args );
				Cc.warn( msg );
				browserLog( "[warn]" + msg );
			}
		}

		/**
		 * 打印错误信息
		 * @param args
		 */
		public static function error( ... args ):void
		{
			if ( isDebug )
			{
				var msg:String = JSON.stringify( args );
				Cc.error( msg );
				browserLog( "[error]" + msg );
			}
		}

		/**
		 * 打印调试数据
		 * @param args
		 */
		public static function debug( ... args ):void
		{
			if ( isDebug )
			{
				var msg:String = JSON.stringify( args );
				Cc.debug( msg );
				browserLog( "[debug]" + msg );
			}
		}

		/**
		 * 打印请求服务器数据
		 * @param args
		 */
		public static function printServer( ... args ):void
		{
			if ( isDebug )
			{
				var msg:String = JSON.stringify( args );
				Cc.ch( "server", msg, 2 );
				browserLog( "[server]" + msg );
			}
		}
		
		/**
		 * 打印到浏览器控制台
		 * @param args
		 */
		public static function browserLog(...  args ):void
		{
			var msg:String = JSON.stringify( args );
			trace( msg );
			try
			{
				if ( ExternalInterface.available ){
					ExternalInterface.call("console.log", msg );
				}
			}
			catch(e:Error)
			{
				trace( "console.log:" + e.message );
			}
		}
		
		/**
		 * 初始化舞台
		 */
		public static function initStage( stage:Stage, pass:String = " " ):void
		{
			if ( isDebug )
			{
				Cc.config.style.backgroundAlpha = 0.7;
				Cc.startOnStage( stage, pass );
				Cc.commandLine = true;
				Cc.fpsMonitor = true;
				Cc.memoryMonitor = true;
				Cc.config.commandLineAllowed = true;
				Cc.config.alwaysOnTop = true;
				Cc.visible = false;
				Cc.width = stage.stageWidth - 50;
			}
		}
		
		/////////////////////
		
		private static var _isDebug:Boolean;
		/**
		 * 是否是调试状态
		 */
		public static function get isDebug():Boolean
		{
			if ( _isDebug == false )
			{
				if ( Capabilities.playerType == "StandAlone" )
					return true;
			}
			return _isDebug;
		}
		
		public static function set isDebug( value:Boolean ):void
		{
			_isDebug = value;
		}
	}
}
