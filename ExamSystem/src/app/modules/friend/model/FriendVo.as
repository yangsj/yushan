package app.modules.friend.model
{
	import app.data.PlayerBaseVo;
	
	
	/**
	 * ……好友数据
	 * @author 	victor 
	 * 			2013-9-18
	 */
	public class FriendVo extends PlayerBaseVo
	{
		public function FriendVo()
		{
			super();
		}
		
		
		/**
		 * // 1表示在线 | 2 表示闯关中 | 3 表示对战中 | 4表示不在线
		 */
		public var status:int;
		
		
		/**
		 * 是否离线
		 */
		public function get offLine():Boolean
		{
			return status == 4;
		}
		
		/**
		 * 是否在线
		 */
		public function get onLine():Boolean
		{
			return status == 1;
		}
		
		/**
		 * 是否关卡中
		 */
		public function get isAtRound():Boolean
		{
			return status == 2;
		}
		
		/**
		 * 是否对战中
		 */
		public function get isFighting():Boolean
		{
			return status == 3;
		}
		
	}
}