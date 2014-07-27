package victor.framework.socket {

	import flash.utils.ByteArray;
	
	import org.apache.thrift.FFUtil;

	/**
	 * @author victor
	 */
	public class PacketParse {
		private static var _seq : int = 1;
		// 保留验证
		private static var _checkKey : uint;

		/*
		 * 
		请求:
		+---------------------------------------+
		|                header                 |
		+---------+-----------------------------+
		| length  | type    | body              | 
		+---------+---------+-------------------+
		|short_int| uint32_t| body of length    |
		+---------+---------+-------------------+

		response message format:
		+------------------------------+-------------------+
		|           header             | length            |
		+---------+---------+------------------------------+
		| length  | type    | code     | body              | 
		+---------+---------+------------------------------+
		| uint32_t| uint32_t| uint32_t | body of length    |
		+---------+---------+------------------------------+
		 */
		/**
		 * 发请求压包
		 * @param req 请求对象
		 */
		public static function synthesize(req : SocketReq) : ByteArray
		{
			
			var api : uint = req.cmd;
			var msg : * = req.obj;
			
			var mData : ByteArray = new ByteArray();
			
			// 请求数据
			var msgData : ByteArray = new ByteArray();
			FFUtil.EncodeMsg( msg, msgData );
			// body length
			mData.writeInt( msgData.length );
			// cmd
			mData.writeShort( api );
			// 保留
			mData.writeShort( 0 );
			// 写入数据体
			msgData.position = 0;
			
			mData.writeBytes(msgData, 0, msgData.length);
			msgData.position = 0;
			
			return mData;
		}

		/**
		 * 反向序列化
		 * @param buffer server端推回的数据流
		 * @param cla server对应的解包类
		 */
		public static function analyze(buffer : ByteArray) : SocketResp {
			// 解析数据
			buffer.position = 0;
			// 读取长度
			var length : int = buffer.readInt();
			// 读取cmd
			var cmd : uint = buffer.readShort();
			// 保留字节
			var code : uint = buffer.readShort();
			
			var res : SocketResp = SocketResp.creat();
			res.api = cmd;
			
			var data : ByteArray = new ByteArray();
			var pos : uint = buffer.position;
			var len : uint = buffer.length - pos;
			data.writeBytes(buffer, pos, len);
			data.position = 0;
			res.data = data;
			buffer.position = 0;
			return res;
		}

		public static function getModule(api : uint) : uint {
			var m : int = api;
			m = m >> 10;
			return m;
		}

		public static function getAction(api : uint) : uint {
			var value : int = api;
			// 后10位
			value = value & 0x3ff;
			return value;
		}

		/**
		 * 获取api
		 */
		public static function getApi(m : uint, action : uint) : uint {
            var module:uint = m << 10;
			var api : uint = module + action;
			return api;
		}

		public static function printApi(api : uint) : String {
			return PacketParse.getModule(api) + "-" + PacketParse.getAction(api);
		}

		public static function getSeq() : uint {
			return _seq++;
		}

		public static function setSeq(value : int) : void {
			_seq = value;
		}

		/**
		 * 设置校验
		 */
		public static function setCheckKey(checkKey : uint) : void {
			_checkKey = checkKey;
		}
	}
}
