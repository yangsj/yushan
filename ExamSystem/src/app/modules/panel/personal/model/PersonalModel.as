package app.modules.panel.personal.model
{
	import org.robotlegs.mvcs.Actor;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-11-30
	 */
	public class PersonalModel extends Actor
	{
		private var _list:Vector.<ErrorListVo>;
		
		private var _englshList:Array;
		private var _chineseList:Array;
		
		public function PersonalModel()
		{
			super();
			clearList();
		}
		
		public function clearList():void
		{
			_list ||= new Vector.<ErrorListVo>();
			_list.length = 0;
		}
		
		public function addVo( value:ErrorListVo ):void
		{
			_list.push( value );
		}

		public function get list():Vector.<ErrorListVo>
		{
			return _list;
		}

		public function get englshList():Array
		{
			return _englshList ||= [];
		}

		public function set englshList(value:Array):void
		{
			_englshList = value;
		}

		public function get chineseList():Array
		{
			return _chineseList ||= [];
		}

		public function set chineseList(value:Array):void
		{
			_chineseList = value;
		}


	}
}