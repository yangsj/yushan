package app.modules.panel.test
{
	import com.riaidea.text.RichTextField;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.TextEvent;
	import flash.text.TextFormat;
	
	import app.core.Alert;
	
	import net.victoryang.components.scroll.ScrollPanel;
	import net.victoryang.core.TabButtons;
	import net.victoryang.deubg.Debug;
	import net.victoryang.framework.BasePanel;
	import net.victoryang.func.calls;
	import net.victoryang.managers.LoaderManager;
	import net.victoryang.uitl.HtmlText;
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-8-28
	 */
	public class TestView extends BasePanel
	{
		private var container:Sprite;
		
		public function TestView()
		{
			
		}
		
		override protected function onceInit():void
		{
			super.onceInit();
			
			var funcNames:Array = [
				 ["滚动条测试", testScrollPanel],["富文本测试", testRichTextField] ,["ComboBox",testComboBox] ,["Alert", testAlert]
				];
			
			container = new Sprite();
			container.y = 30;
			_skin.addChild( container );
			
			var tabContainer:Sprite = new Sprite();			
			var tabControl:TabButtons = new TabButtons( tabButtonControl );
			for (var i:int = 0; i < funcNames.length; i++)
			{
				var data:Array = funcNames[ i ];
				var mc:MovieClip = LoaderManager.instance.getObj( "test_ui_SkinTabTest", domainName ) as MovieClip;
				mc.x = -170 + 85 * (i % 11);
				mc.y = -30 * int(i/11);
				mc.txtLabel.text = data[0] + "";
				tabContainer.addChild( mc );
				tabControl.addTarget( mc, {index:i, func:data[ 1 ]} );
				container.addChild( new Sprite() );
			}
			tabControl.setTargetByIndex( 0 );
			
			tabContainer.x = rectangle.x + (( rectangle.width - tabContainer.width ) >> 1);
			tabContainer.y = 30 - tabContainer.height;
			_skin.addChild( tabContainer );
		}
		
		private function tabButtonControl( target:MovieClip, tabData:Object ):void
		{
			for (var i:int = 0; i < container.numChildren;i++)
				container.getChildAt( i ).visible = false;
			
			var temp:Sprite = container.getChildAt( int( tabData.index ) ) as Sprite;
			temp.visible = true;
			if ( temp.numChildren == 0 )
			{
				calls( tabData.func, temp );
			}
		}
		
		private function testScrollPanel( con:Sprite ):void
		{
			var itemContainer:Sprite = new Sprite();
			itemContainer.x = 55;
			itemContainer.y = 35;
			con.addChild( itemContainer );
			var gameScroll:ScrollPanel = new ScrollPanel();
			gameScroll.setTargetShow(itemContainer, 0, 0, 440, 330);
			gameScroll.changeBarPos( -20, 0);
			for (var i:int = 0; i < 24; i++)
			{
				var item:TestItem = new TestItem();
				item.setIndex( i );
				itemContainer.addChild( item );
			}
			gameScroll.updateMainHeight( itemContainer.height );
			gameScroll.setPos( 0 );
		}
		
		private function testRichTextField( con:Sprite ):void
		{
			var rtf:RichTextField = new RichTextField();
			rtf.x = 10;
			rtf.y = 10;
			rtf.html = true;
			rtf.setSize( 500, 50 );
			con.addChild(rtf);
			rtf.textfield.selectable = false;
			rtf.defaultTextFormat = new TextFormat("Arial", 20, 0x000000);
			rtf.textfield.addEventListener(TextEvent.LINK, linkHandler );
//			rtf.append( HtmlText.urlEvent("this", "victor", 0xff0000)+ "  is test RichTextField",[{index:5, index:5, src:"ui_test_skin"}], true);
			var xml:XML = 	<rtf>
							  <htmlText></htmlText>
							  <sprites>
								<sprite src="ui_test_skin" index="4"/>
							  </sprites>
							</rtf>

			xml.htmlText[0] = HtmlText.urlEvent( "this", "victor,victor,king", 0xff0000) + "  is RichTextField";
			rtf.importXML( xml );
			function linkHandler(event:TextEvent):void
			{
				Debug.printServer( event.text );
			}
		}
		
		private function testComboBox( con:Sprite ):void
		{
//			var comboData:ComboData = new ComboData();
//			for (var i:int = 0; i < 10; i++)
//			{
//				var vo:ComboItemVo = new ComboItemVo();
//				vo.label = "label_" + i;
//				comboData.addItem( vo );
//			}
//			
//			var comboBox:ComboBox = new ComboBox( comboData );
//			con.addChild( comboBox );
//			
//			var comboBox1:ComboBox = new ComboBox( comboData, 100 );
//			con.addChild( comboBox1 );
//			comboBox1.x = 200;
		}
		
		protected function testAlert( con:Sprite ):void
		{
			Alert.show( "希望每个单身的人都能够相信爱情，一爱再爱不要低下头，最终有情人终成眷属。", function abc( type:uint ):void{ Debug.printServer( type )}, "下一关" );
		}
		
		override protected function openComplete():void
		{
		}
		
		override public function hide():void
		{
			super.hide();
		}
		
		override protected function get skinName():String
		{
			return "test.UITestViewPanel";
		}
		
		override protected function get resNames():Array
		{
			return [ "testPanel"];
		}
		
	}
}