package app.modules.model
{
	import app.modules.model.vo.ItemVo;
	
	import org.robotlegs.mvcs.Actor;
	
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-9-24
	 */
	public class PackModel extends Actor
	{
		private var _hasPackItems:Boolean;
		private var _itemList:Vector.<ItemVo>;
		
		public function PackModel()
		{
			super();
		}
		
		public function addNumByType( type:int, num:int = 1 ):ItemVo
		{
			var index:int = getIndexByType( type );
			if ( index != -1 )
			{
				var itemVo:ItemVo = itemList[ index ];
				itemVo.num += num;
				return itemVo;
			}
			return null;
		}
		
		/**
		 * 删除指定道具指定的数量
		 * @param itemId
		 * @param num
		 * @return 
		 */
		public function delNumByType( type:int, num:int = 1 ):ItemVo
		{
			var index:int = getIndexByType( type );
			if ( index != -1 )
			{
				var itemVo:ItemVo = itemList[ index ];
				itemVo.num -= num;
				return itemVo;
			}
			return null;
		}
		
		/**
		 * 更新指定物品的数据
		 * @param itemVo
		 */
		public function updateItem( itemVo:ItemVo ):void
		{
			var index:int = getIndexByType( itemVo.type );
			if ( index == -1 )
				itemList.push( itemVo );
			else itemList[ index ] = itemVo;
		}
		
		/**
		 * 通过type获取指定物品在背包里的排序
		 * @param type
		 * @return 
		 */
		public function getIndexByType( type:int ):int
		{
			var itemVo:ItemVo;
			for ( var key:String in itemList )
			{
				itemVo = itemList[key];
				if ( itemVo && itemVo.type == type )
					return int( key );
			}
			return -1;
		}
		
		/**
		 * 获取item
		 * @param type
		 * @return 
		 */
		public function getItemByType( type:int ):ItemVo
		{
			var index:int = getIndexByType( type );
			if ( index != -1 )
			{
				return itemList[ index ];
			}
			return null;
		}
		
		//////////////////////////////
		
		
		///////////// getters/setters 
		
		/**
		 * 物品列表数据
		 */
		public function get itemList():Vector.<ItemVo>
		{
			return _itemList ||= new Vector.<ItemVo>();
		}

		/**
		 * 是否获取过背包物品数据
		 */
		public function get hasPackItems():Boolean
		{
			return _hasPackItems;
		}

		/**
		 * @private
		 */
		public function set hasPackItems(value:Boolean):void
		{
			_hasPackItems = _hasPackItems ? true : value;
		}


	}
}