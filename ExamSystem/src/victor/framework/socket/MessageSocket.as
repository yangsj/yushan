package victor.framework.socket
{

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	import victoryang.deubg.Debug;
	
	import org.apache.thrift.FFUtil;
	
	/**
	 * @author victor
	 */
	public class MessageSocket extends SocketBase implements ISocketManager
	{
		private static const EVENT_PRE:String = "evt_";
		private var _eventList:Object;
		private var _event:EventDispatcher;
		// 通知回调
		private var _notifyCallbackList:Object;
		// 忽略
		private var _ignoreList:Object;
		// 不处理
		private var _wired:Dictionary;
//		private var _onceCallList : Dictionary;
		private var _beatTime:int;
		//! 负责处理粘包的缓存
		private var _buffPacket:ByteArray;

		// private var _notAllowList : Array;
		public function MessageSocket( isDebug:Boolean = false )
		{
			this._eventList = {};
			_notifyCallbackList = {};
			_ignoreList = {};
			_wired = new Dictionary();
			_event = new EventDispatcher();
			_buffPacket = new ByteArray();
			super( isDebug );
		}

		public function keepAlive( api:int ):Boolean
		{
			return _wired[ api ];
		}

		public function addWired( api:int ):void
		{
			_wired[ api ] = true;
		}

		/**
		 * 注册固定数据回调事件
		 * @param api 调用的api号码
		 * @param callback 回调
		 * @param isIgnore 是否忽略解析
		 */
		public function registerDataCallback( api:uint, callback:Function, respProc:Class = null, isIgnore:Boolean = false ):void
		{
			if ( _notifyCallbackList[ api ])
			{
				throw new Error( "指定的协议重复注册回调方法!:" + api );
			}
			_notifyCallbackList[ api ] = [ callback, respProc ];
			if ( isIgnore )
			{
				_ignoreList[ api ] = isIgnore;
			}
		}

		/**
		 * 解析事件回调
		 */
		override protected function parseSocketData( bufferNew:ByteArray ):void
		{
			bufferNew.position = 0;
			if (_buffPacket.length == 0)
			{
				_buffPacket.position = 0;
			}
			else
			{
				_buffPacket.position = _buffPacket.length;
			}
			_buffPacket.writeBytes(bufferNew, 0, bufferNew.length);
			_buffPacket.position = 0;
			
			var packetOk:Boolean = true;
			
			//!如果足够一个包，那么处理
			while (true)
			{
				if (_buffPacket.length < 4)//!不能读取包头
				{
					return;
				}
				// 读取长度
				var length : int = _buffPacket.readInt();
				var total_len : int = length + 8;
				if (_buffPacket.length < total_len)//!算上包头
				{
					_buffPacket.position = 0;
					return;
				}
				_buffPacket.position = 0;
				var buffer:ByteArray = new ByteArray();//!收到一个新包
				buffer.writeBytes(_buffPacket, 0, total_len);
				buffer.position = 0;
				
				if (_buffPacket.length > total_len)
				{
					_buffPacket.position = 0;
					var tmpBuff:ByteArray = new ByteArray();
					tmpBuff.writeBytes(_buffPacket, total_len, buffer.length - total_len);
					_buffPacket = tmpBuff;
					_buffPacket.position = 0;
				}
				else//!正好是一个包，处理完毕清空
				{
					_buffPacket = new ByteArray();
				}
				
				var respObj:SocketResp = PacketParse.analyze( buffer );
				var callback:Function;
				var list:Array;
				var respPorc:Class;
				var api:uint = respObj.api;

				list = _notifyCallbackList[ api ];

				if ( list )
				{

					callback = list[ 0 ];
					respPorc = list[ 1 ];

					var data:ByteArray = respObj.data;
					var msg:* = new respPorc();
					FFUtil.DecodeMsg( msg, data );
					respObj.data = msg;

					if ( _isDebug )
						Debug.printServer( getTimer() + "|服务器返回数据(" + api + "):", respObj.data.toString());
				}
				else
				{
					if ( _isDebug )
						Debug.printServer( getTimer() + "|没有数据解包:" + api + "\n\t------" );
				}
				// 检查是否有函数回调
				dispatch( api );
				// 响应
				if ( callback )
				{
					if ( callback.length > 0 )
						callback( respObj );
					else
						callback();
				}

				// 销毁返回对象
				SocketResp.disposeResp( respObj );
				
				// 結束請求
				dispatchEvent(new SocketEvent( SocketEvent.CALL_END ));
			}
		}

		/**
		 * 回调事件
		 */
		protected function dispatch( api:uint ):void
		{
			if ( _eventList[ api ] is Function )
			{
				_event.dispatchEvent( new Event( EVENT_PRE + api ));
			}
		}

		/**
		 * 请求
		 * @param req 请求对象
		 * @param callback 回调成功，无参数，（数据更新另处理）
		 */
		public function call( req:SocketReq, callback:Function = null, noTimeLimit:Boolean = true ):void
		{
			if ( this._sock.connected == false )
			{
				dispatchEvent( new SocketEvent( SocketEvent.CALL_ERROR ));
				return;
			}
			if ( hasNotAllow( req.cmd ))
			{
				return;
			}
			// 是否时间允许
			if ( noTimeLimit == false )
			{
				addNotAllow( req.cmd );
			}
			var api:uint = req.cmd;
			if ( callback is Function )
			{
				pendBase( api, getHandler( api, callback ));
			}
			netCall( req );
		}

		/**
		 * 单次请求
		 */
		public function onceCall( req:SocketReq, callback:Function, respCla:Class ):void
		{
			if ( this._sock.connected == false )
			{
				dispatchEvent( new SocketEvent( SocketEvent.CALL_ERROR ));
				return;
			}
			_notifyCallbackList[ req.cmd ] = [ callback, respCla ];
			netCall( req );
		}

		/**
		 * 添加回调
		 */
		private function pendBase( api:uint, handler:Function ):void
		{
			if ( _eventList[ api ] is Function )
			{
				cancelPendBase( api );
			}
			_eventList[ api ] = handler;
			_event.addEventListener( EVENT_PRE + api, handler );
		}

		/**
		 * 请求
		 */
		private function netCall( req:SocketReq ):void
		{
			//開始請求
			dispatchEvent( new SocketEvent( SocketEvent.CALL_START ));
			
			// 序列化
			Debug.printServer( getTimer() + "|发送数据内容(" + req.cmd + "):", req.obj.toString());
			var byteArray:ByteArray = PacketParse.synthesize( req );

			SocketReq.disposeReq( req );

			this._sock.writeBytes( byteArray, 0, byteArray.length );
			this._sock.flush();
			_beatTime = getTimer();
		}

		/**
		 * 获得api
		 */
		private function getHandler( api:uint, callback:Function ):Function
		{
			// 回调函数
			function handler( event:Event ):void
			{
				if ( !keepAlive( api ))
				{
					cancelPendBase( api );
				}
				callback();
			}
			return handler;
		}

		/**
		 * 退出
		 */
		private function cancelPendBase( api:uint ):void
		{
			var fun:Function = _eventList[ api ] as Function;
			if ( fun != null )
			{
				var evtStr:String = EVENT_PRE + api;
				_event.removeEventListener( evtStr, fun );
			}
		}

		public function get beatTime():int
		{
			return _beatTime;
		}
	}
}
