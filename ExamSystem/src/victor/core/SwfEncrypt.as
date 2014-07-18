package victor.core
{
	import flash.utils.*;

	public class SwfEncrypt extends Object
	{
		public static var KEY:String = "";
		private static const TYPE_ENCODE:int = 0;
		private static const TYPE_DECODE:int = 1;
		private static var _instance:SwfEncrypt;

		public function SwfEncrypt()
		{
		}

		/**
		 * 编码
		 * @param swfByte
		 * @return 
		 */
		public function encode( swfByte:ByteArray ):ByteArray
		{
			return this.dealCode( swfByte, TYPE_ENCODE );
		}

		/**
		 * 解码
		 * @param swfByte
		 * @return 
		 */
		public function decode( swfByte:ByteArray ):ByteArray
		{
			return this.dealCode( swfByte, TYPE_DECODE );
		}

		private function dealCode( swfByte:ByteArray, codeType:int ):ByteArray
		{
			var _loc_7:ByteArray = null;
			var _loc_3:ByteArray = new ByteArray();
			var _loc_4:int = 0;
			var _loc_5:int = 0;
			var _loc_6:int = 0;
			while ( _loc_6 < swfByte.length )
			{

				if ( _loc_4 >= KEY.length )
				{
					_loc_4 = 0;
					_loc_5++;
					if ( _loc_5 >= 50 )
					{
						_loc_7 = new ByteArray();
						_loc_3.writeBytes( swfByte, 50 * KEY.length, swfByte.length - 50 * KEY.length );
						break;
					}
				}
				if ( codeType == TYPE_ENCODE )
				{
					_loc_3.writeByte( swfByte[ _loc_6 ] + KEY.charCodeAt( _loc_4 ));
				}
				else if ( codeType == TYPE_DECODE )
				{
					_loc_3.writeByte( swfByte[ _loc_6 ] - KEY.charCodeAt( _loc_4 ));
				}
				_loc_6++;
				_loc_4++;
			}
			_loc_3.position = 0;
			return _loc_3;
		}

		public static function get instance():SwfEncrypt
		{
			return _instance ||= new SwfEncrypt();
		}

	}
}
