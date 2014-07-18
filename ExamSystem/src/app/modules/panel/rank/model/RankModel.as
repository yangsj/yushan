package app.modules.panel.rank.model
{
	import flash.utils.Dictionary;
	
	import org.robotlegs.mvcs.Actor;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-28
	 */
	public class RankModel extends Actor
	{
		private var _dictList:Dictionary = new Dictionary();
		
		public function RankModel()
		{
			super();
		}
		
		public function clearDictList():void
		{
			_dictList = new Dictionary();
		}
		
		public function getListByType( type:int ):Vector.<RankVo>
		{
			_dictList ||= new Dictionary();
			return _dictList[ type ] as Vector.<RankVo>;
		}
		
		public function setListByType( type:int, list:Vector.<RankVo> ):void
		{
			_dictList ||= new Dictionary();
			_dictList[ type ] = list;
		}

	}
}