package app.data
{
	import app.events.GameEvent;
	import app.modules.main.event.MainUIEvent;
	
	import org.robotlegs.mvcs.Actor;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-8-28
	 */
	public class GameData extends Actor
	{
		////////////////////////////////////////////////////////
		
		private static var _instance:GameData;
		public static function get instance():GameData
		{
			if ( _instance == null )
				new GameData();
			return _instance;
		}

		
		////////////////////////////////////////////////////////
		
		public function GameData()
		{
			if ( _instance )
				throw new Error("GameData重复创建！！！");
			_instance = this;
		}
		
		////////////////////////////////////////////////////////
		
		/**
		 * 玩家自己的数据
		 */
		public var selfVo:PlayerSelfVo;
		
		////////////////////////////////////////////////////////
		
		public function updateLevel( level:int ):void
		{
			var tempLevel:int = selfVo.level;
			selfVo.level = level;
			// 升级
			if ( tempLevel< level )
				dispatch( new GameEvent( GameEvent.LEVEL_UP ));
		}
		
		public function updateAddMoney( money:int ):void
		{
			selfVo.money += money;
			dispatch(  new MainUIEvent( MainUIEvent.UPDATE_MONEY, selfVo.money ));
		}
		
		public function updateAddExp( exp:int ):void
		{
			selfVo.exp += exp;
			dispatch(  new MainUIEvent( MainUIEvent.UPDATE_EXP, selfVo.exp ));
		}
		
		///////////////////////////////////////////////////////
		
		

	}
}