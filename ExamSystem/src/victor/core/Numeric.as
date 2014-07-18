package victor.core
{
	import flash.display.Shape;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * 位图数字构造类
	 * @author yangsj
	 */
	public class Numeric
	{
		private var _numCache:Array;
		private var _maxHeight:int;

		public function Numeric( mc:MovieClip, hasBoard:Boolean = true )
		{
			_numCache = [];
			cacheNumber( mc, hasBoard );
		}

		/**
		 * 缓存数字
		 */
		private function cacheNumber( mc:MovieClip, hasBoard:Boolean ):void
		{
			var len:int = mc.totalFrames;
			var rect:Rectangle;
			var maxHeight:int = 0;
			for ( var i:int = 0; i < len; i++ )
			{
				mc.gotoAndStop( i + 1 );
				rect = mc.getRect( mc );
				if ( hasBoard )
				{
					rect.x += 1;
					rect.y += 1;
					rect.width = int( rect.width ) - 2;
					rect.height = int( rect.height ) - 2;
				}
				var matrix:Matrix = new Matrix();
				matrix.translate( -rect.x, -rect.y );
				var bd:BitmapData = new BitmapData( rect.width, rect.height, true, 0x0 );
				if ( maxHeight < rect.height )
				{
					maxHeight = rect.height;
				}
				bd.draw( mc, matrix );
				_numCache.push( bd );
			}
			_maxHeight = maxHeight;
		}

		public function getBitmap( i:int ):Bitmap
		{
			return new Bitmap( _numCache[ i ]);
		}

		public function destroy():void
		{
			_numCache = null;
		}

		public function creatNumber( num:int, gap:int = 0 ):Shape
		{
			// 将数字分解
			var str:String = num.toString();
			var numArr:Array = str.split( "" );
			var len:int = numArr.length;
			var shape:Shape = new Shape();
			var xPos:Number = 0;
			var matrix:Matrix = new Matrix();
			for ( var i:int = 0; i < len; i++ )
			{
				var db:BitmapData = _numCache[ numArr[ i ]];
				shape.graphics.beginBitmapFill( db, matrix );
				shape.graphics.drawRect( xPos, 0, db.width, db.height );
				shape.graphics.endFill();
				var move:int = db.width + gap;
				matrix.translate( move, 0 );
				xPos += move;
			}
			return shape;
		}

		public function creatBitmap( num:int, gap:int ):Bitmap
		{
			// 将数字分解
			var shape:Shape = creatNumber( num, gap );
			var db:BitmapData = new BitmapData( shape.width, shape.height, true, 0 );
			db.draw( shape );
			var bitmap:Bitmap = new Bitmap( db );
			return bitmap;
		}

		/**
		 * 获取数值
		 * @param	mc		字符元件
		 * @param	num		数值
		 * @param	type	类型（文字类型）
		 * @param	h		高度
		 * @return
		 */
		static public function getNum( mc:MovieClip, num:int = 0, height:Number = 20 ):Bitmap
		{
			var _showBitmap:Bitmap = new Bitmap();
			var _numMc:MovieClip = mc;
			// 将数字分解
			var str:String = num.toString();
			var numArr:Array = str.split( "" );
			var len:int = numArr.length;
			
			_numMc.height = height;
			_numMc.scaleX = _numMc.scaleY;
			
			var width:int = height * len * 2;
			var bitmapData:BitmapData = new BitmapData( width, _numMc.height, true, 0x00000000 );
			var matrix:Matrix = new Matrix();
			matrix.translate( 2, 2 );
			matrix.scale( _numMc.scaleX, _numMc.scaleY );
			for ( var i:int = 0; i < len; i++ )
			{
				_numMc.gotoAndStop( int( numArr[ i ]));
				bitmapData.draw( _numMc, matrix );
				matrix.translate( _numMc.width, 0 );
			}
			_numMc = null;
			var rect:Rectangle = bitmapData.getColorBoundsRect( 0xff000000, 0, false );
			_showBitmap.bitmapData = new BitmapData( rect.width, rect.height, true, 0x00000000 );
			_showBitmap.bitmapData.copyPixels( bitmapData, rect, new Point());
			_showBitmap.smoothing = true;
			return _showBitmap;
		}
	}
}
