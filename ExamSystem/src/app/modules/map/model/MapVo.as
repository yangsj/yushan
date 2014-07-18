package app.modules.map.model
{
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-22
	 */
	public class MapVo
	{
		public function MapVo()
		{
		}
		
		/**
		 * 地图id
		 */
		public var mapId:int;
		/**
		 * 开启状态（0未开启，1已开启）
		 */
		public var status:int;
		/**
		 * 当前已获得的星星数量
		 */
		public var currentStarNum:int;
		/**
		 * 开启下一章节的总星星数量
		 */
		public var totalStarNum:int;
		
		/**
		 * 章节列表
		 */
		public var chapterList:Vector.<ChapterVo>;

		/**
		 * 地图是否开启
		 */
		public function get isOpen():Boolean
		{
			return status == 1;
		}

		public function get mapName():String
		{
			return ["巨鲸群岛","赤色火山","沉睡森林","黄金沙漠","远古冰川","天空"][mapId];
		}
		
	}
}