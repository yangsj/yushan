package victor.utils
{
	import flash.text.TextField;

	/**
	 * 字符串处理
	 * @author yangsj
	 */
	public class StringUitl
	{
		public function StringUitl()
		{
		}

		/**
		 * 相对于字符串匹配指定的 pattern 并返
		 * 回一个新字符串，其中的第一个 pattern 匹配
		 * 项被替换为 repl 所指定的内容。pattern 参数
		 * 可以是字符串或正则表达式。repl 参数可以是字符
		 * 串或函数；如果是函数，将插入由该函数返回的字符串
		 * 以替换匹配项。未修改原始字符串。 
		 * @param pattern 要匹配的模式，可以为任何类型的对象，但通常是字符串或正则表达式。如果指定的 pattern 参数是除字符串或正则表达式以外的任何其他对象，将对该参数应用 toString() 方法，并使用生成的字符串作为 pattern 来执行 replace() 方法。
		 * @param repl 通常是以插入的字符串替换匹配内容。但也可以指定一个函数作为此参数。如果指定一个函数，将插入由该函数返回的字符串来替换匹配内容。
		 * @return
		 *
		 */
		public static function replace( str:String, pattern:* = null, repl:* = null ):String
		{
			return str.replace( pattern, repl );;
		}

		/**
		 * 获取14个字节字符串
		 * @param str
		 * @param bytesNum
		 * @return
		 */
		public static function getChar( str:String, bytesNum:int = 14 ):String
		{
			// [ \u4e00-\u9fa5]
			var tempStr:String = str;
			var len:int = str.length;
			var code:int;
			var num:int;
			for ( var i:int = 0; i < len; i++ )
			{
				code = str.charCodeAt( i );
				if ( code > 0x4e00 && code < 0x9fa5 )
				{
					num += 2; // 中文2个字节
				}
				else
				{
					num++;
				}
				if ( num == bytesNum )
				{
					tempStr = str.substring( 0, i + 1 );
					break;
				}
				else if ( num > bytesNum )
				{
					tempStr = str.substring( 0, i );
					break;
				}
			}
			return tempStr;
		}

		/**
		 * 是否为空
		 * @param guid
		 * @return
		 */
		public static function isEmpty( guid:String ):Boolean
		{
			return guid == null || guid == "" || guid == "0" || guid == "null";
		}

		/**
		 * 格式化数据
		 * @param isPercentage
		 * @param value
		 * @return
		 */
		public static function formatPercentageValue( isPercentage:Boolean, value:int ):String
		{
			var str:String = "";
			if ( isPercentage )
			{
				str = value / 100 + "%";
			}
			else
			{
				str = value + "";
			}
			return str;
		}

		/**
		 * 转换成Text
		 */
		public static function getText( value:String ):String
		{
			var tf:TextField = new TextField();
			tf.htmlText = value;
			return tf.text;
		}

		/**
		 * 转换成Html
		 */
		public static function getHtml( value:String ):String
		{
			var xml:XML = <xml/>;
			xml.appendChild( value );
			var str:String = xml.toXMLString();
			return str.substring( 5, str.indexOf( "</xml>" ));
		}

		/**
		 * 格式化输入文本
		 */
		public static function formatInput( str:String ):String
		{
			return str.replace( /</g, "《" ).replace( />/g, "》" );
		}

		/**
		 * 验证邮箱是否格式正确
		 * @param str
		 * @return
		 */
		public static function validateEmail( str:String ):Boolean
		{
			var pattern:RegExp = /(\w|[_.\-])+@((\w|-)+\.)+\w{2,4}+/;
			var result:Object = pattern.exec( str );
			if ( result == null )
			{
				return false;
			}
			return true;
		}

		/**
		 * 验证电话号码是否正确
		 * @param str
		 * @return
		 */
		public static function validatePhoneNumber( str:String ):Boolean
		{
			var pattern:RegExp = /^\d{11}$/;
			var result:Object = pattern.exec( str );
			if ( result == null )
			{
				return false;
			}
			return true;
		}
	}
}
