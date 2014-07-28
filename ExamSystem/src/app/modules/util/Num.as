package app.modules.util
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.utils.Dictionary;
	
	import victoryang.managers.LoaderManager;
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-12-24
	 */
	public class Num
	{
		private static var dictNumSkin:Dictionary;
		private static const colon:String = "Colon";
		
		public function Num()
		{
		}
		
		public static function getTimeSprite( time:String ):Sprite
		{
			var sprite:Sprite = new Sprite();
			
			var ary:Array = time.split(":");
			for ( var i:int = 0; i < ary.length; i++ )
			{
				var shape:Shape = getShape( ary[i] );
				shape.x = sprite.width;
				sprite.addChild( shape );
				
				if ( i < ary.length - 1 ) {
					var colonBitmap:Bitmap = new Bitmap( dictNumSkin[colon], "auto", true );
					colonBitmap.x = sprite.width;
					sprite.addChild( colonBitmap );
				}
			}
			
			return sprite;
		}
		
		public static function getShape( num:* ):Shape
		{
			createNumCache();
			
			// 将数字分解
			var str:String = num is String ? num : num.toString();
			var numArr:Array = str.split( "" );
			var len:int = numArr.length;
			var shape:Shape = new Shape();
			var xPos:Number = 0;
			var matrix:Matrix = new Matrix();
			for ( var i:int = 0; i < len; i++ )
			{
				var db:BitmapData = dictNumSkin[ numArr[ i ]];
				shape.graphics.beginBitmapFill( db, matrix );
				shape.graphics.drawRect( xPos, 0, db.width, db.height );
				shape.graphics.endFill();
				var move:int = db.width;
				matrix.translate( move, 0 );
				xPos += move;
			}
			return shape;
		}
		
		/**
		 * 创建缓存数字
		 */
		private static function createNumCache():void
		{
			if ( !dictNumSkin )
			{
				var prefix:String = "ui_Skin_Num";
				dictNumSkin = new Dictionary();
				for ( var i:int = 0; i < 10; i++ ) {
					dictNumSkin[i] = LoaderManager.getObj( prefix + i );
				}
				dictNumSkin[colon] = LoaderManager.getObj( prefix + "_" + colon );
			}
		}
		
	}
}