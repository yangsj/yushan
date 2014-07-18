package app.core
{
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import app.managers.FontManager;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-10-16
	 */
	public class Text
	{
		public function Text()
		{
		}
		
		/**
		 * 创建TextFormat
		 * @param size
		 * @param color
		 * @param align
		 * @return 
		 */
		public static function getFormat( font:String = "", size:int = 50, color:uint = 0, align:String = "center" ):TextFormat
		{
			var tf:TextFormat = new TextFormat();
			if ( font ) tf.font = font;
			tf.color = color;
			tf.size = size;
			tf.align = align;
			return tf;
		}
		
		/**
		 * 创建文本框
		 * @param size
		 * @param color
		 * @param x
		 * @param y
		 * @param w
		 * @param h
		 * @param aglin
		 * @return TextField对象实例，绑定嵌入字体显示，仅用可选和鼠标事件
		 */
		public static function getText( size:int, color:uint, font:String, x:Number = 0, y:Number = 0, w:Number = 100, h:Number = 22, aglin:String = "center" ):TextField
		{
			var text:TextField = new TextField();
			text.defaultTextFormat = getFormat( font, size, color, aglin );
			text.selectable = false;
			text.mouseEnabled = false;
			text.x = x;
			text.y = y;
			text.width = w;
			text.height = h;
			text.cacheAsBitmap = true;
			return text;
		}
		
		/**
		 * 克隆文本框
		 * @param originalText 被克隆的文本框对象
		 * @return 克隆后的文本框
		 */
		public static function cloneText( originalText:TextField ):TextField
		{
			var tf:TextFormat = originalText.defaultTextFormat;
			var tt:TextField = getText( int(tf.size), uint(tf.color), tf.font, originalText.x, originalText.y, originalText.width, originalText.height, tf.align );
			if ( originalText.parent ) {
				originalText.parent.addChild( tt );
				originalText.parent.removeChild( originalText );
			}
			tt.filters = originalText.filters;
			tt.cacheAsBitmap = true;
			tt.alpha = originalText.alpha;
			tt.multiline = originalText.multiline;
			tt.background = originalText.background;
			tt.backgroundColor = originalText.backgroundColor;
			tt.border = originalText.border;
			tt.borderColor = originalText.borderColor;
			tt.displayAsPassword = originalText.displayAsPassword;
			tt.wordWrap = originalText.wordWrap;
			tt.visible = originalText.visible;
			return tt;
		}
		
	}
}