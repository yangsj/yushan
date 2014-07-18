package app.modules.map.model
{
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-25
	 */
	public class ChapterVo
	{
		public function ChapterVo()
		{
		}
		
		/**
		 * 所属地图id
		 */
		public var mapId:int;
		/**
		 * 章节id
		 */
		public var chapterId:int;
		/**
		 * 包含5个小关卡的数据列表
		 */
		public var roundList:Vector.<RoundVo>;
		
	}
}