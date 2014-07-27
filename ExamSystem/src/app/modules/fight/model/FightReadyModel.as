package app.modules.fight.model
{
	import app.data.GameData;
	
	import org.robotlegs.mvcs.Actor;
	
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-10-19
	 */
	public class FightReadyModel extends Actor
	{
		
		private var _destVo:FightMatchingVo;
		private var _result:int;
		
		public function FightReadyModel()
		{
			super();
		}
		
		/**
		 * 自己
		 * @return 
		 * 
		 */
		public function get selfVo():FightMatchingVo
		{
			var vo:FightMatchingVo = new FightMatchingVo();
			vo.uid = GameData.instance.selfVo.uid;
			vo.gender = GameData.instance.selfVo.gender;
			vo.grade = GameData.instance.selfVo.grade;
			vo.level = GameData.instance.selfVo.level;
			vo.name = GameData.instance.selfVo.name;
			return vo;
		}
		
		/**
		 * 匹配对手数据
		 */
		public function get destVo():FightMatchingVo
		{
			return _destVo ||= new FightMatchingVo();
		}
		
		/**
		 * @private
		 */
		public function set destVo(value:FightMatchingVo):void
		{
			_destVo = value;
		}

		/**
		 * 匹配结果（0成功，1对方拒绝，2对方不在线）
		 */
		public function get result():int
		{
			return _result;
		}

		/**
		 * @private
		 */
		public function set result(value:int):void
		{
			_result = value;
		}
		
		/**
		 * 匹配成功
		 */
		public function get isSuccessed():Boolean
		{
			return _result == 0;
		}
		
		/**
		 * 对方拒绝
		 */
		public function get isRefuse():Boolean
		{
			return _result == 1;
		}
		
		/**
		 * 对方离线
		 */
		public function get isOffline():Boolean
		{
			return _result == 2;
		}


	}
}