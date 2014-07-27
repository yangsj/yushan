package app.modules.panel.personal.view
{
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import app.modules.fight.view.prop.item.PropItem;
	import app.modules.model.vo.ItemType;
	import app.modules.model.vo.ItemVo;
	
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-11-30
	 */
	public class PersonalPropList extends Sprite
	{
		private static var _itemPoints:Vector.<Point>;
		private static var _propIndex:Array;
		
		private var vecItemSkin:Vector.<PropItem>;
		
		public function PersonalPropList()
		{
			super();
			
			x = 70;
			y = 170;
			
			if ( _propIndex == null )
			{
				var key:int = 0;
				_propIndex = [];
				for ( var i:int = 0; i < 4; i++ )
				{
					key = [ItemType.EXTRA_TIME, ItemType.HINT, ItemType.BROOM, ItemType.SKIP][i];
					_propIndex[key] = i;
				}
			}
			
			createListItems();
		}
		
		private function createListItems():void
		{
			var item:PropItem;
			vecItemSkin = new Vector.<PropItem>( 4 );
			for (var i:int = 0; i < 4; i++ )
			{
				item = new PropItem();
				item.x = 125 * ( i % 2 );
				item.y = 84 * int( i/2 );
				addChild( item );
				vecItemSkin[ i ] = item;
			}
		}       
		
		public function setData( itemList:Vector.<ItemVo> ):void
		{
			var leng:int = itemList.length;
			var item:PropItem;
			var itemVo:ItemVo;
			for (var i:int = 0; i < 4; i++ )
			{
				itemVo = itemList[ i ];
				item = vecItemSkin[ _propIndex[itemVo.type] ];
				item.setData( itemVo );
				item.displayOnlyNum();
			}
		}    
	}
}