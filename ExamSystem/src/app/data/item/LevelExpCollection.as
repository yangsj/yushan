package app.data.item
{
	import flash.utils.Dictionary;
	
	import app.GameConfig;
	import app.data.vo.LevelExpItemVo;
	
	import victor.utils.MathUtil;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-24
	 */
	public class LevelExpCollection
	{
		[Embed( source = "../../../../config/level_exp.xml", mimeType = "application/octet-stream" )]
		private var levelExpXML:Class;
		
		private var dict:Dictionary;
		
		public function LevelExpCollection()
		{
			dict = new Dictionary();
			initData(XML(new levelExpXML()));
		}
		
		private function initData( xml:XML ):void
		{
			var xmllist:XMLList = xml.children();
			var itemVo:LevelExpItemVo;
			for each ( var xl:XML in xmllist )
			{
				itemVo = new LevelExpItemVo( xl.@level, xl.@cur_exp, xl.@next_exp );
				dict[itemVo.level] = itemVo;
			}
		}
		
		public function getItemByLevel( level:int ):LevelExpItemVo
		{
			level = MathUtil.range( level, 1, GameConfig.MAX_LEVEL );
			return dict[ level ] as LevelExpItemVo;
		}
		
		public function getItemByExp( exp:int ):LevelExpItemVo
		{
			var itemVo:LevelExpItemVo;
			for each ( itemVo in dict )
			{
				if ( MathUtil.isRange( exp, itemVo.curExp, itemVo.nextExp - 1 ))
					return itemVo;
			}
			return getItemByLevel( GameConfig.MAX_LEVEL );
		}
		
	}
}