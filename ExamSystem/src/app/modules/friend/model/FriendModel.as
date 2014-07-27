package app.modules.friend.model
{
	import app.modules.friend.event.FriendEvent;
	
	import org.robotlegs.mvcs.Actor;
	

	/**
	 * ……
	 * @author 	victor
	 * 			2013-9-6
	 */
	public class FriendModel extends Actor
	{
		/**
		 * 是否已获得好友列表数据
		 */
		public var hasFriendList:Boolean;
		
		private var _friendList:Vector.<FriendVo>;
		private var _applyAddFriendList:Vector.<FriendApplyVo>;
		private var _searchUserList:Vector.<FriendVo>;

		public function FriendModel()
		{
			super();
		}
		
		////////// publics 
		
		/**
		 * 更新列表
		 */
		public function update():void
		{
			dispatch( new FriendEvent( FriendEvent.UPDATE_LIST ));
		}
		
		/**
		 * 清空列表长度
		 */
		public function clearZero():void
		{
			friendList.length = 0;
		}

		/**
		 * 添加好友，若是添加的好友已存在列表中将会更新好友数据
		 * @param friendVo
		 */
		public function addFriend( friendVo:FriendVo, isUpdate:Boolean = true ):void
		{
			if ( friendVo ) {
				
				friendList.push( friendVo );
				
				if ( isUpdate ) update();
			}
		}
		
		/**
		 * 删除好友
		 * @param uid 需要删除的好友id
		 */
		public function delFriend( uid:int ):void
		{
			var key:int = getIndexByUid( uid );
			
			if ( key != -1 ) friendList.splice( key, 1 );
			
			update();
		}

		/**
		 * 更新好友数据。若是当前好友不在列表中，则添加到列表中
		 * @param friendVo
		 */
		public function updateFriend( friendVo:FriendVo, needUpdate:Boolean = true ):void
		{
			if ( friendVo ) {
				var key:int = getIndexByUid( friendVo.uid );
				
				if ( key != -1 ) friendList[ key ] = friendVo;
				else friendList.push( friendVo );
				
				if ( needUpdate ) update();
			}
		}

		/**
		 * 通过好友id获取好友数据信息。若是找不到指定的好友，则返回null。
		 * @param uid
		 * @return 
		 */
		public function getFriendByUId( uid:int ):FriendVo
		{
			for each ( var friendVo:FriendVo in friendList ) {
				
				if ( friendVo && friendVo.uid == uid )
					return friendVo;
			}
			return null;
		}

		/**
		 * 通过id获取好友数据在列表中的排列序号index。若是找不到指定的数据，则返回-1。
		 * @param uid
		 * @return 
		 */
		public function getIndexByUid( uid:int ):int
		{
			var friendVo:FriendVo;
			
			for ( var key:String in friendList ) {
				
				friendVo = friendList[ key ];
				if ( friendVo && friendVo.uid == uid )
					return int( key );
			}
			return -1;
		}
		
		/**
		 * 获取所有列表【按在线和离线排序，在线在前】
		 */
		public function get allList():Vector.<FriendVo>
		{
			friendList.sort( 
				
				function abc( vo1:FriendVo, vo2:FriendVo ):Number { 
					return vo1.onLine ? -1 : 1;
				}
			);
			return friendList;
		}
		
		/**
		 * 获取在线好友列表
		 */
		public function get onLineList():Vector.<FriendVo>
		{
			var vecList:Vector.<FriendVo> = new Vector.<FriendVo>();
			
			for each (var friendVo:FriendVo in friendList ) {
				
				if ( !friendVo.offLine )
					vecList.push( friendVo );
			}
			return vecList;
		}

		/**
		 * 好友列表数据
		 */
		public function get friendList():Vector.<FriendVo>
		{
			return _friendList ||= new Vector.<FriendVo>();
		}
		
		////////////////////////
		///		好友申请数据	////
		////////////////////////
		
		/**
		 * 好友申请列表是否为空
		 */
		public function get isEmptyApplyList():Boolean
		{
			return _applyAddFriendList == null || _applyAddFriendList.length == 0;
		}

		/**
		 * 好友申请列表
		 */
		public function get applyAddFriendList():Vector.<FriendApplyVo>
		{
			return _applyAddFriendList ||= new Vector.<FriendApplyVo>();
		}

		/**
		 * @private
		 */
		public function addApplyAddFriendList(applyVo:FriendApplyVo):void
		{
			applyAddFriendList.push( applyVo );
		}
		
		/**
		 * 在线对战搜索用户玩家数据列表
		 */
		public function get searchUserList():Vector.<FriendVo>
		{
			return _searchUserList ||= new Vector.<FriendVo>();
		}
		
		/**
		 * @private
		 */
		public function set searchUserList(value:Vector.<FriendVo>):void
		{
			_searchUserList = value;
		}

		

	}
}
