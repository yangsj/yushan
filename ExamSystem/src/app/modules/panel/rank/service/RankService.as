package app.modules.panel.rank.service
{
	import app.data.GameData;
	import app.modules.panel.rank.events.RankEvent;
	import app.modules.panel.rank.model.RankModel;
	import app.modules.panel.rank.model.RankVo;
	
	import ff.client_cmd_e;
	import ff.get_rank_list_req_t;
	import ff.get_rank_list_ret_t;
	import ff.rank_data_t;
	import ff.server_cmd_e;
	
	import victor.framework.core.BaseService;
	import victor.framework.socket.SocketResp;
	
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-9-28
	 */
	public class RankService extends BaseService
	{
		[Inject]
		public var rankModel:RankModel;
		
		public function RankService()
		{
			super();
		}
		
		override protected function initRegist():void
		{
			regist( server_cmd_e.GET_RANK_LIST_RET, rankListNotify, get_rank_list_ret_t );
		}
		
		private function rankListNotify( resp:SocketResp ):void
		{
			var data:get_rank_list_ret_t = resp.data as get_rank_list_ret_t;
			var array:Array = data.rank_list;
			var list:Vector.<RankVo> = new Vector.<RankVo>();
			var rankVo:RankVo;
			var type:int = data.rank_type;
			for each ( var rank:rank_data_t in array )
			{
				rankVo = new RankVo();
				rankVo.type = type;
				rankVo.rank = rank.rank_num;
				rankVo.name = rank.nick_name;
				rankVo.level = rank.level;
				rankVo.validity = rank.valid_time;
				rankVo.honor = rank.honour;
				rankVo.uid = rank.uid;
				rankVo.isSelf = rank.uid == GameData.instance.selfVo.uid;
				list.push( rankVo );
			}
			rankModel.setListByType( type, list );
			dispatch( new RankEvent( RankEvent.COMPLETE_NOTITY, list ));
		}
		
		public function getListByType( type:int ):void
		{
			var req:get_rank_list_req_t = new get_rank_list_req_t();
			req.rank_type = type;
			call( client_cmd_e.GET_RANK_LIST_REQ, req );
		}
		
	}
}