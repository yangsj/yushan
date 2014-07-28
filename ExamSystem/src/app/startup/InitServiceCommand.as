package app.startup
{
	import app.GameConfig;
	import app.core.Alert;
	import app.managers.ExternalManager;
	import app.modules.LoadingEffect;
	
	import victoryang.deubg.Debug;
	import victoryang.framework.BaseCommand;
	
	import victor.framework.events.ServiceEvent;
	import victor.framework.socket.ISocketManager;
	import victor.framework.socket.MessageSocket;
	import victor.framework.socket.SocketEvent;
	
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-8-28
	 */
	public class InitServiceCommand extends BaseCommand
	{
		public function InitServiceCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			var socket : MessageSocket = new  MessageSocket( Debug.isDebug );
			injector.mapValue(ISocketManager, socket);
			socket.addEventListener(SocketEvent.CLOSE, onSocketClose);
			socket.addEventListener(SocketEvent.CONNECTED, onSocketConnected );
			socket.addEventListener(SocketEvent.IO_ERROR, onIoError );
			socket.addEventListener(SocketEvent.CALL_START, onStartCall );
			socket.addEventListener(SocketEvent.CALL_END, onEndCall );
			
			socket.connect( GameConfig.serverHost, GameConfig.serverPort );
		}
		
		private function onStartCall( event:SocketEvent ):void
		{
			LoadingEffect.show();
		}
		
		private function onEndCall( event:SocketEvent ):void
		{
			LoadingEffect.hide();
		}
		
		private function onSocketConnected( event:SocketEvent ):void
		{
			dispatch( new ServiceEvent( ServiceEvent.CONNECTED ));
		}
		
		private function failed():void
		{
			dispatch( new ServiceEvent( ServiceEvent.FAILED ));
			alert( "连接失败！" );
		}
		
		/**
		 * 连接关闭
		 */
		private function onSocketClose(event : SocketEvent) : void 
		{
			dispatch( new ServiceEvent( ServiceEvent.CLOSED ));
			alert( "连接关闭！" );
		}
		
		private function onIoError( event:SocketEvent ):void
		{
			alert("连接错误！");
		}
		
		private function alert( msg:String ):void
		{
			LoadingEffect.hide();
			Alert.show( msg, callBack, "刷  新", "" );
			function callBack( type:int ):void
			{
				ExternalManager.reload();
			}
		}
		
		
	}
}