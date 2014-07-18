package app.modules.main.model
{
	import org.robotlegs.mvcs.Actor;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-25
	 */
	public class MainModel extends Actor
	{
		private var _hasLoadCompleted:Boolean;
		private var _hasEnterGame:Boolean;
		
		public function MainModel()
		{
			super();
		}

		/**
		 * 主资源是否加载完成
		 */
		public function get hasLoadCompleted():Boolean
		{
			return _hasLoadCompleted;
		}

		/**
		 * @private
		 */
		public function set hasLoadCompleted(value:Boolean):void
		{
			_hasLoadCompleted = _hasLoadCompleted ? true : value;
		}

		/**
		 * 已经进入游戏了
		 */
		public function get hasEnterGame():Boolean
		{
			return _hasEnterGame;
		}

		/**
		 * @private
		 */
		public function set hasEnterGame(value:Boolean):void
		{
			_hasEnterGame = value;
		}


	}
}