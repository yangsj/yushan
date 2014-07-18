package app.modules.serivce
{
	import app.data.GameData;
	import app.events.PackEvent;
	import app.modules.fight.model.FightModel;
	import app.modules.model.PackModel;
	import app.modules.model.vo.ItemVo;
	
	import ff.client_cmd_e;
	import ff.item_t;
	import ff.pack_info_t;
	import ff.server_cmd_e;
	import ff.use_item_req_t;
	import ff.use_item_ret_t;
	
	import victor.framework.core.BaseService;
	import victor.framework.socket.SocketResp;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-24
	 */
	public class PackService extends BaseService
	{
		[Inject]
		public var packModel:PackModel;
		[Inject]
		public var fightModel:FightModel;
		
		public function PackService()
		{
			super();
		}
		
		override protected function initRegist():void
		{
			// 背包物品list数据
			regist( server_cmd_e.PACK_INFO_RET, packInfoNotify, pack_info_t );
			// 使用物品成功
			regist( server_cmd_e.USE_ITEM_RET, useItemSuccessNotify, use_item_ret_t );
		}
		
		/**
		 * 背包列表通知
		 * @param resp
		 */
		private function packInfoNotify( resp:SocketResp ):void
		{
			var data:pack_info_t = resp.data as pack_info_t;
			var itemList:Array = data.item_list;
			var itemVo:ItemVo;
			for each ( var item:item_t in itemList )
			{
				itemVo = new ItemVo();
				itemVo.type = item.item_type;
				itemVo.num = item.item_num;
				packModel.updateItem( itemVo );
			}
			dispatch( new PackEvent( PackEvent.UPDATE_ITEMS ));
		}
		
		/**
		 * 物品使用成功通知
		 * @param resp
		 */
		private function useItemSuccessNotify( resp:SocketResp ):void
		{
			var data:use_item_ret_t = resp.data as use_item_ret_t;
			var itemVo:ItemVo = packModel.delNumByType( data.item_type );
			if ( data.uid == GameData.instance.selfVo.uid ) {
				dispatch( new PackEvent( PackEvent.USE_SUCCESS, itemVo ));
			} else {
				dispatch( new PackEvent( PackEvent.DEST_USE_SUCCESS, itemVo ));
			}
		}
		
		////////////////////////////
		
		/**
		 * 使用物品
		 * @param itemId
		 */
		public function useItem( itemType:int ):void
		{
			var req:use_item_req_t = new use_item_req_t();
			req.item_type = itemType;
			call( client_cmd_e.USE_ITEM_REQ, req );
			
			fightModel.isUsePorped = true;
		}
		
		
	}
}