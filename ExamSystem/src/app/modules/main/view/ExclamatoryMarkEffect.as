package app.modules.main.view
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	
	import victoryang.core.Clip;
	import victoryang.managers.LoaderManager;
	
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2014-1-8
	 */
	public class ExclamatoryMarkEffect extends Sprite
	{
		/*============================================================================*/
		/* private variables                                                          */
		/*============================================================================*/
		
		private var clip:Clip;
		
		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/
		public function ExclamatoryMarkEffect()
		{
			
			this.x = 528;
			this.y = 450;
			this.mouseChildren = false;
			this.mouseEnabled = false; 
			
			var xml:XML = LoaderManager.getXml( "exclamatory_xml" );
			var png:Bitmap = LoaderManager.getBitmap( "exclamatory_png" );
			var vec:Vector.<BitmapData> = new Vector.<BitmapData>();
			if ( xml && png )
			{
				var xmllist:XMLList = xml.children();
				var bitmapdata:BitmapData;
				for each ( var xl:XML in xmllist )
				{
					bitmapdata = new BitmapData(Number( xl.@width ), Number( xl.@height ), true, 0 );
					bitmapdata.draw( png, new Matrix(1,0,0,1,-Number(xl.@x), -Number(xl.@y)));
					vec.push( bitmapdata );
				}
				
				var scale:Number = 50 / bitmapdata.height;
				this.scaleX = this.scaleY = scale;
			}
			clip = new Clip();
			clip.setBitmapDataList( vec, 12 );
			addChild( clip );
		}
		
		public function start():void
		{
			if ( clip ) clip.play();
		}
		
		public function stop():void
		{
			if ( clip ) clip.stop();
		}
		
		
		private const pngXml:XML = 
			<TextureAtlas imagePath="exclamatory.png">
				<!-- Created with Adobe Flash Professional version 13.0.1.808 -->
				<!-- http://www.adobe.com/products/flash.html -->
				<SubTexture name="1" x="0" y="0" width="141" height="290" pivotX="0" pivotY="0"/>
				<SubTexture name="2" x="705" y="0" width="141" height="290" pivotX="0" pivotY="0"/>
				<SubTexture name="3" x="846" y="0" width="141" height="290" pivotX="0" pivotY="0"/>
				<SubTexture name="4" x="0" y="290" width="141" height="290" pivotX="0" pivotY="0"/>
				<SubTexture name="5" x="141" y="290" width="141" height="290" pivotX="0" pivotY="0"/>
				<SubTexture name="6" x="282" y="290" width="141" height="290" pivotX="0" pivotY="0"/>
				<SubTexture name="7" x="423" y="290" width="141" height="290" pivotX="0" pivotY="0"/>
				<SubTexture name="8" x="564" y="290" width="141" height="290" pivotX="0" pivotY="0"/>
				<SubTexture name="9" x="705" y="290" width="141" height="290" pivotX="0" pivotY="0"/>
				<SubTexture name="10" x="141" y="0" width="141" height="290" pivotX="0" pivotY="0"/>
				<SubTexture name="11" x="282" y="0" width="141" height="290" pivotX="0" pivotY="0"/>
				<SubTexture name="12" x="423" y="0" width="141" height="290" pivotX="0" pivotY="0"/>
				<SubTexture name="13" x="564" y="0" width="141" height="290" pivotX="0" pivotY="0"/>
			</TextureAtlas>
		
		
	}
}