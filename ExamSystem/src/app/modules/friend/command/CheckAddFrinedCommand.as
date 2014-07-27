package app.modules.friend.command
{
	import app.core.Alert;
	import app.modules.friend.model.FriendApplyVo;
	import app.modules.friend.model.FriendModel;
	import app.modules.friend.service.FriendService;
	
	import net.victoryang.framework.BaseCommand;
	
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-12-14
	 */
	public class CheckAddFrinedCommand extends BaseCommand
	{
		/*============================================================================*/
		/* private variables                                                          */
		/*============================================================================*/
		
		[Inject]
		public var friendModel:FriendModel;
		[Inject]
		public var friendService:FriendService;
		
		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/
		public function CheckAddFrinedCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			if ( friendModel.applyAddFriendList.length == 1 ) dealApplyList();
		}
		
		/**
		 * 好友申请通知处理
		 */
		private function dealApplyList():void
		{
			var applyVo:FriendApplyVo = friendModel.applyAddFriendList[0];
			Alert.show( "[ " + applyVo.name + " ]申请和您成为好友，您是否同意？", callBack, "同意", "拒绝" );
			function callBack( type:int ):void
			{
				var isAgree:Boolean = type == Alert.YES;
				friendService.agreeAddFriend( applyVo.uid, isAgree );
				friendModel.applyAddFriendList.shift();
				if ( friendModel.isEmptyApplyList == false )
					dealApplyList();
			}
		}
		
		
	}
}