package app.modules.map.service
{
	import flash.utils.Dictionary;
	
	import app.events.GameEvent;
	import app.modules.map.event.MapEvent;
	import app.modules.map.model.ChapterVo;
	import app.modules.map.model.MapModel;
	import app.modules.map.model.MapVo;
	import app.modules.map.model.RoundVo;
	import app.modules.map.panel.event.SelectedRoundEvent;
	
	import ff.chapter_detail_req_t;
	import ff.chapter_detail_ret_t;
	import ff.chapter_info_t;
	import ff.client_cmd_e;
	import ff.game_info_ret_t;
	import ff.round_group_info_t;
	import ff.round_info_t;
	import ff.server_cmd_e;
	
	import victor.framework.core.BaseService;
	import victor.framework.socket.SocketResp;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-22
	 */
	public class MapService extends BaseService
	{
		[Inject]
		public var mapModel:MapModel;
		
		public function MapService()
		{
			super();
		}
		
		override protected function initRegist():void
		{
			// 地图数据通知
			regist( server_cmd_e.GAME_INFO_RET, mapDataNotify, game_info_ret_t );
			// 地图章节详细数据通知
			regist( server_cmd_e.CHAPTER_DETAIL_RET, chapterDetailNotify, chapter_detail_ret_t );
		}
		
		private function mapDataNotify( resp:SocketResp ):void
		{
			var data:game_info_ret_t = resp.data as game_info_ret_t;
			var dict:Dictionary = data.all_chapter_info;
			var info:chapter_info_t;
			var mapVo:MapVo;
			var mapList:Vector.<MapVo> = new Vector.<MapVo>();
			for ( var key:String in dict )
			{
				info = dict[ key ];
				mapVo = new MapVo();
				mapVo.mapId = int( key );
				mapVo.status = info.status;
				mapList.push( mapVo );
			}
			mapModel.mapList = mapList;
			
			// 获取到数据检查是否进入游戏（登陆时检查一次）
			if ( mapModel.hasMapList == false )
			{
				mapModel.hasMapList = true;
				dispatch( new GameEvent( GameEvent.ACQUIRE_MAP_DATA ));
			}
			else
			{
				dispatch( new MapEvent( MapEvent.UPDATE_MAP_DATA ));
			}
		}
		
		private function chapterDetailNotify( resp:SocketResp ):void
		{
			var data:chapter_detail_ret_t = resp.data as chapter_detail_ret_t;
			var chapterList:Vector.<ChapterVo> = new Vector.<ChapterVo>();
			var chapterVo:ChapterVo;
			var roundVo:RoundVo;
			var groupList:Vector.<RoundVo>;
			var mapVo:MapVo = new MapVo();
			mapVo.mapId = data.chapter_type;
			mapVo.status = 1;
			for ( var key:String in data.round_group_info )
			{
				var info:round_group_info_t = data.round_group_info[ key ];
				chapterVo = new ChapterVo();
				chapterVo.mapId = mapVo.mapId;
				chapterVo.chapterId = int( key );
				groupList = new Vector.<RoundVo>();
				chapterVo.roundList = groupList;
				chapterList.push( chapterVo );
				var len:int = info.round_info.length;
				for ( var index:int = 0;index < 5; index++ )
				{
					var roundInfo:round_info_t = index < len ? info.round_info[ index ] : new round_info_t();
					roundVo = new RoundVo();
					roundVo.mapId = mapVo.mapId;
					roundVo.chapterId = chapterVo.chapterId;
					roundVo.roundId = index;
					roundVo.type = roundInfo.rount_type;
					roundVo.starNum = roundInfo.star_num;
					roundVo.status = roundInfo.status;
					groupList.push( roundVo );
				}
			}
			mapVo.currentStarNum = data.win_star_num;
			mapVo.totalStarNum = data.pass_need_star_nuum + data.win_star_num;
			mapVo.chapterList = chapterList;
			mapModel.currentMapVo = mapVo;
			
			dispatch( new SelectedRoundEvent( SelectedRoundEvent.CHAPTER_DETAIL ));
			
		}
		
		//////////////////////
		
		/**
		 * 获取章节地图详细数据
		 * @param mapId
		 */
		public function getChapterDetailInfo( mapId:int ):void
		{
			var req:chapter_detail_req_t = new chapter_detail_req_t();
			req.chapter_type = mapId;
			call( client_cmd_e.CHAPTER_DETAIL_REQ, req );
		}
		
	}
}