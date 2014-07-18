package app.modules.map.model
{
	import org.robotlegs.mvcs.Actor;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-22
	 */
	public class MapModel extends Actor
	{
		/**
		 * 是否获取地图数据
		 */
		public var hasMapList:Boolean;
		
		private var _currentMapVo:MapVo;
		private var _currentRoundVo:RoundVo;
		private var _currentChapterVo:ChapterVo;
		private var _mapList:Vector.<MapVo>;
		private var _isNeddOpenFromFight:Boolean = false;
		private var _isSelectedRound:Boolean = true;
		
		public function MapModel()
		{
			super();
		}
		
		public function updateMapVo( mapVo:MapVo ):void
		{
			
		}
		
		public function nextRound():void
		{
			
		}

		public function get currentMapVo():MapVo
		{
			return _currentMapVo ||= new MapVo();
		}

		public function set currentMapVo(value:MapVo):void
		{
			_currentMapVo = value;
		}

		public function get currentRoundVo():RoundVo
		{
			return _currentRoundVo ||= new RoundVo();
		}

		public function set currentRoundVo(value:RoundVo):void
		{
			_currentRoundVo = value;
		}

		public function get mapList():Vector.<MapVo>
		{
			return _mapList;
		}

		public function set mapList(value:Vector.<MapVo>):void
		{
			_mapList = value;
		}

		/**
		 * 选中章节数据
		 */
		public function get currentChapterVo():ChapterVo
		{
			return _currentChapterVo;
		}

		/**
		 * @private
		 */
		public function set currentChapterVo(value:ChapterVo):void
		{
			_currentChapterVo = value;
		}

		/**
		 * 从闯关界面返回是否需要打开关卡列表
		 */
		public function get isNeddOpenFromFight():Boolean
		{
			return _isNeddOpenFromFight;
		}

		/**
		 * @private
		 */
		public function set isNeddOpenFromFight(value:Boolean):void
		{
			_isNeddOpenFromFight = value;
		}

		/**
		 * 是否选择闯关，否侧是练习
		 */
		public function get isSelectedRound():Boolean
		{
			return _isSelectedRound;
		}

		/**
		 * @private
		 */
		public function set isSelectedRound(value:Boolean):void
		{
			_isSelectedRound = value;
		}
		

	}
}