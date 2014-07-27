package app.modules.map.panel.item
{
	import flash.display.MovieClip;
	
	import app.modules.map.main.item.MapItemBase;
	import app.modules.map.model.ChapterVo;
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-9-25
	 */
	public class GroupItem extends MapItemBase
	{
		private var vecListItem:Vector.<RoundItem>;
		private var chapterVo:ChapterVo;
		private var index:int;
		
		public function GroupItem( skin:MovieClip, index:int )
		{
			super( skin );
			skin.mouseChildren = true;
			skin.buttonMode = false;
			skin.mouseEnabled = false;
			this.index = index;
			createItems();
		}
		
		override public function dispose():void
		{
			super.dispose();
			clearItems();
			chapterVo = null;
		}
		
		private function clearItems():void
		{
			if ( vecListItem )
			{
				while ( vecListItem.length > 0 )
					vecListItem.pop().dispose();
			}
			vecListItem = null;
		}
		
		private function createItems():void
		{
			var item:RoundItem;
			vecListItem ||= new Vector.<RoundItem>();
			for ( var i:int = 0; i < 5; i++ )
			{
				item = new RoundItem( skin.getChildByName( "r" + i ) as MovieClip, 5 * index + i + 1);
				vecListItem.push( item );
			}
		}
		
		public function setData( chapterVo:ChapterVo ):void
		{
			this.chapterVo = chapterVo;
			var item:RoundItem;
			for ( var i:int = 0; i < 5; i++ )
			{
				item = vecListItem[ i ];
				item.setData( chapterVo.roundList[ i ] );
			}
		}
	}
}