package app.modules.panel.personal.view
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.FileReference;
	import flash.text.TextField;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import app.base.BasePanel;
	import app.core.Tips;
	import app.modules.panel.personal.model.ErrorListVo;
	
	import victor.core.scroll.GameScrollPanel;
	import victor.utils.removeAllChildren;
	import victor.utils.removedFromParent;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-11-30
	 */
	public class ErrorListView extends BasePanel
	{
		/**
		 * listContainer
		 */
		public var listContainer:MovieClip;
		/**
		 * btnExport
		 */
		public var btnExport:SimpleButton;
		
		private var txtStr:TextField;
		private var fileReference:FileReference;
		private var gameScroll:GameScrollPanel;
		private var listStr:String = "";
		private var englishBitmap:Bitmap;
		private var chineseBitmap:Bitmap;
		private var listWidth:Number = 100;
		private var itemBgCon:Sprite;
		private var vecItemBg:Dictionary = new Dictionary();
		
		public function ErrorListView()
		{
			super();
		}
		
		public function setArrayList( englishList:Array, chineseList:Array ):void
		{
			if ( englishList )
			{
				var english:String = "";
				var chinese:String = "";
				var i:int = 0;
				createScroll();
				txtStr.text = "";
				listStr = "";
				removeAllChildren( itemBgCon );
				listContainer.addChild( itemBgCon );
				for each ( var val:String in englishList )
				{
					if ( listStr == "" ) {
						listStr = val + "," + chineseList[i];
						english = val;
						chinese = chineseList[i];
					}
					else {
						listStr += "\t\n" + val + ",";
						english += "\n" + val;
						chinese += "\n" + chineseList[i];
					}
					itemBgCon.addChild( getItemBg( i ) );
					i++;
				}
				var bitx:Number = txtStr.x;
				var bity:Number = txtStr.y;
				var tarw:Number = 0;
				
				removedFromParent( englishBitmap );
				englishBitmap = getTextBitmap( english );
				englishBitmap.x = bitx;
				englishBitmap.y = bity;
				listContainer.addChild( englishBitmap );
				tarw = bitx + englishBitmap.width;
				
				removedFromParent( chineseBitmap );
				chineseBitmap = getTextBitmap( chinese );
				chineseBitmap.x = tarw + ( (listWidth - tarw) - chineseBitmap.width ) * 0.5;
				chineseBitmap.y = bity;
				listContainer.addChild( chineseBitmap );
				
				gameScroll.updateMainHeight( listContainer.height );
				gameScroll.setPos( 0 );
			}
		}
		
		private function getItemBg( index:int ):Sprite
		{
			var sprite:Sprite = vecItemBg[index] as Sprite;
			if ( sprite == null )
			{
				sprite = getObj( "ui_Skin_ErrorListItemBg" ) as Sprite;
				vecItemBg[index] = sprite;
			}
			sprite.height = 40;
			sprite.y = 38 * index;
			sprite.visible = ( index % 2 == 1 );
			return sprite;
		}
		
		private function getTextBitmap( msg:String ):Bitmap
		{
			txtStr.text = msg;
			txtStr.width = txtStr.textWidth + 30;
			txtStr.height = txtStr.textHeight + 20;
			
			var bitmap:Bitmap = new Bitmap( new BitmapData( txtStr.width, txtStr.height, true, 0), "auto", true );
			bitmap.bitmapData.draw( txtStr );
			return bitmap;
		}
		
		public function setVo( list:Vector.<ErrorListVo> ):void
		{
//			if ( list )
//			{
//				createScroll();
//				
//				listStr = "";
//				for ( var i:int = 0; i < 20; i++ )
//				{
//					var val:String = "第" + i + "行:";
//					if ( listStr == "" ) {
//						listStr = val + ",中文";
//						txtStr.appendText( val );
//					}
//					else {
//						listStr += "\n\r" + val;
//						txtStr.appendText( "\n" + val );
//					}
//				}
//				txtStr.height = txtStr.textHeight + 15;
//				
//				gameScroll.updateMainHeight( listContainer.height );
//				gameScroll.setPos( 0 );
//			}
		}
		
		private function createScroll():void
		{
			if ( gameScroll == null )
			{
				gameScroll = new GameScrollPanel();
				gameScroll.setTargetAndHeight( listContainer, listContainer.height, listWidth );
				
				removeAllChildren( listContainer );
				listContainer.addChild( txtStr );
				txtStr.height = txtStr.textHeight;
				
				gameScroll.updateMainHeight( listContainer.height );
				gameScroll.setPos( 0 );
			}
		}
		
		override protected function onceInit():void
		{
			super.onceInit();
			
			txtStr = listContainer.getChildByName( "txtStr" ) as TextField;
			txtStr ||= new TextField();
			txtStr.mouseEnabled = false;
			txtStr.text = "";
			txtStr.visible = false;
			txtStr.wordWrap = false;
			
			listWidth = listContainer.width;
			
			itemBgCon = new Sprite();
			listContainer.addChild( itemBgCon );
			
			btnExport.visible = false;
			btnExport.addEventListener(MouseEvent.CLICK, btnExportClickHandler );
		}
		
		protected function btnExportClickHandler(event:MouseEvent):void
		{
			if ( listStr ) {
				
				var byte:ByteArray = new ByteArray();
				byte.writeUTFBytes( listStr );
				
				fileReference = new FileReference();
				fileReference.addEventListener(Event.COMPLETE, saveCompleteHandler );
				fileReference.addEventListener(Event.SELECT, selectedDirHandler );
				fileReference.save( byte, "error_list.txt" );//txt|doc|csv|rtf
			} else {
				Tips.showMouse( "没有需要保存的内容！" );
			}
		}
		
		protected function selectedDirHandler(event:Event):void
		{
		}
		
		protected function saveCompleteHandler(event:Event):void
		{
			Tips.showCenter( "保存成功！" );
		}
		
		override protected function get skinName():String
		{
			return "ui_Skin_ErrorWordsListPanel";
		}
		
		override protected function get resNames():Array
		{
			return [ "ui_Personal" ];
		}
		
	}
}