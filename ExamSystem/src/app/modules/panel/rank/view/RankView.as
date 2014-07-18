package app.modules.panel.rank.view
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import app.base.BasePanel;
	import app.modules.panel.rank.events.RankEvent;
	import app.modules.panel.rank.model.RankVo;
	
	import victor.core.TabButtonControl;
	import victor.core.scroll.GameScrollPanel;
	import victor.utils.removeAllChildren;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-28
	 */
	public class RankView extends BasePanel
	{
		private var tabName:Array = ["周实力榜", "月实力榜", "综合实力榜", "财富榜", "丰收榜"];
		private var tabControl:TabButtonControl;
		private var gameScroll:GameScrollPanel;
		
		public var listContainer:Sprite;
		public var currentTabType:int = 0;
		
		public function RankView()
		{
		}
		
		public function defaultSelected():void
		{
			tabControl.setDefaultTarget( null, true );
		}
		
		public function createList(list:Vector.<RankVo>):void
		{
			if ( list )
			{
				removeAllChildren( listContainer );
				var i:int = 0;
				var disty:Number = 40;
				var item:RankItem;
				for each ( var vo:RankVo in list )
				{
					item = RankItem.instance;
					item.setData( vo );
					item.y = disty * i;
					listContainer.addChild( item );
					i++;
				}
				gameScroll.updateMainHeight( listContainer.height );
				gameScroll.setPos( 0 );
			}
		}
		
		private function createTabButton():void
		{
			tabControl = new TabButtonControl( tabControlHandler );
			
			var mc:MovieClip;
			for ( var i:int = 0; i < 5; i++ )
			{
				mc = _skin.getChildByName( "tab" + i ) as MovieClip;
				mc.setName( tabName[i] );
				tabControl.addTarget( mc, i );
			}
		}
		
		private function tabControlHandler( clickTarget:MovieClip, data:Object ):void
		{
			currentTabType = int( data );
			dispatchEvent( new RankEvent( RankEvent.CHANGE_TAB ));
		}
		
		override protected function  onceInit():void
		{
			super.onceInit();
			
			gameScroll = new GameScrollPanel();
			gameScroll.setTargetAndHeight( listContainer, 205, 652 );
			
			createTabButton();
		}
		
		override protected function get resNames():Array
		{
			return ["ui_Ranking"];
		}
		
		override protected function get skinName():String
		{
			return "ui_Skin_RankingViewPanel";
		}
		
	}
}