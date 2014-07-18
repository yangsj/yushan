package victor.framework.socket
{

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	import flash.utils.getTimer;
	
	import victor.framework.debug.Debug;

	/**
	 * @author fireyang
	 */
	public class SocketBase extends EventDispatcher
	{
		protected var _sock:Socket;
		// 主机
		private var _host:String;
		// 端口
		private var _port:int;
		private var _connectSucceed:Boolean;
		private var _reTry:Boolean;
		// 包长度
		private var _pack_len:uint;
		// 是否允许
		private var _notAllowList:Object;
		protected var _isDebug:Boolean;

		public function SocketBase( isDebug:Boolean = false )
		{
			_isDebug = isDebug;
			_sock = new Socket();
			_sock.endian = Endian.BIG_ENDIAN;
			_notAllowList = {};
			// this._onConnect = new Function();
		}

		public function connect( host:String, port:int ):void
		{
			_host = host;
			_port = port;
			Debug.debug( "开始连接服务器:", host, port );
			close();
			addListener();
			_sock.connect( _host, _port );
		}

		/**
		 * 添加事件监听
		 */
		private function addListener():void
		{
			_sock.addEventListener( Event.CONNECT, this.onConnectHandler );
			_sock.addEventListener( IOErrorEvent.IO_ERROR, this.onIoErrorHandler );
			_sock.addEventListener( SecurityErrorEvent.SECURITY_ERROR, this.onSecurityErrorHandler );
			_sock.addEventListener( ProgressEvent.SOCKET_DATA, this.onSocketDataHandler );
			_sock.addEventListener( Event.CLOSE, this.onCloseHandler );
		}

		/**
		 * 安全错误
		 */
		private function onSecurityErrorHandler( event:SecurityErrorEvent ):void
		{
			if ( _reTry == false )
			{
				reContent();
			}
			else
			{
				dispatchEvent( new SocketEvent( SocketEvent.ERROR_SECURITY ));
				Debug.error( "安全沙箱冲突!", "安全沙箱冲突: 不能从" + this._host + ":" + this._port + "加载数据。" );
			}
		}

		/**
		 * 获得数据推送
		 */
		private function onSocketDataHandler( event:ProgressEvent ):void
		{
			// 有足够的数据，才读取数据
			Debug.debug( "_sock.bytesAvailable:" + _sock.bytesAvailable );
			while ( _sock.connected && _sock.bytesAvailable >= _pack_len )
			{
				// 读取头长度
				if ( _pack_len == 0 )
				{
					// 数据包长度(2字节)
					_pack_len = _sock.bytesAvailable;
				}
				// 是否有数据包
				if ( _pack_len == 0 )
				{
					return;
				}
				// 是否满足数据包的长度
				if ( _sock.bytesAvailable < _pack_len )
				{
					return;
				}
				// 读取包
				var buffer:ByteArray = new ByteArray();
				_sock.readBytes( buffer, 0, _sock.bytesAvailable );

				// 读取剩余数据
				_pack_len = 0;
				// 解析包数据
				parseSocketData( buffer );

				onSocketDataHandler( null );
			}
		}

		/**
		 * 解析包数据
		 */
		protected function parseSocketData( buffer:ByteArray ):void
		{
		}

		/**
		 * 关闭连接
		 */
		protected function onCloseHandler( event:Event ):void
		{
			Debug.error( getTimer() + "|连接关闭！", "连接地址：" + this._host + ":" + this._port );
			if ( _sock.bytesAvailable > 0 )
			{
				var str:String = _sock.readUTFBytes( _sock.bytesAvailable );
				Debug.error( "连接关闭打印:", str );
			}
			dispatchEvent( new SocketEvent( SocketEvent.CLOSE ));
		}

		/**
		 * 连接成功
		 */
		private function onConnectHandler( event:Event ):void
		{
			_connectSucceed = true;
			Debug.debug( "连接成功!", "连接地址：" + this._host + ":" + this._port );
			dispatchEvent( new SocketEvent( SocketEvent.CONNECTED ));
		}

		/**
		 * 错误事件
		 */
		private function onIoErrorHandler( event:IOErrorEvent ):void
		{
			if ( _reTry == false )
			{
				reContent();
			}
			else
			{
				Debug.error( "连接失败!", "不能连接" + this._host + ":" + this._port );
				dispatchEvent( new SocketEvent( SocketEvent.IO_ERROR ));
			}
		}

		/**
		 * 重连
		 */
		private function reContent():void
		{
			if ( _connectSucceed == true )
			{
				dispatchEvent( new SocketEvent( SocketEvent.RECONNECT ));
				return;
			}
			_sock.close();
			removeListener();
			_reTry = true;
			_sock = new Socket();
			addListener();
			_sock.connect( _host, _port );
		}

		/**
		 * 移除事件
		 */
		private function removeListener():void
		{
			_sock.removeEventListener( Event.CONNECT, this.onConnectHandler );
			_sock.removeEventListener( IOErrorEvent.IO_ERROR, this.onIoErrorHandler );
			_sock.removeEventListener( SecurityErrorEvent.SECURITY_ERROR, this.onSecurityErrorHandler );
			_sock.removeEventListener( ProgressEvent.SOCKET_DATA, this.onSocketDataHandler );
			_sock.removeEventListener( Event.CLOSE, this.onCloseHandler );
		}

		/**
		 * 关闭
		 */
		public function close():void
		{
			if ( _sock && _sock.connected )
			{
				_sock.close();
				removeListener();
			}
		}

		/**
		 * 添加不允许时间
		 */
		protected function addNotAllow( api:uint ):void
		{
			_notAllowList[ api ] = getTimer();
		}

		/**
		 * 移除不允许
		 */
		protected function removeNotAllow( api:uint ):void
		{
			delete _notAllowList[ api ];
		}

		/**
		 * 是否被允许
		 */
		protected function hasNotAllow( api:uint ):Boolean
		{
			var time:int = this._notAllowList[ api ] || 0;
			if ( time == 0 || getTimer() - time > 900 )
			{
				return false;
			}
			else
			{
				// TODO:  处理请求间隔短
				Debug.debug( "接口请求间隔太短:", PacketParse.getModule( api ) + "-" + PacketParse.getAction( api ));
			}
			return true;
		}
	}
}
