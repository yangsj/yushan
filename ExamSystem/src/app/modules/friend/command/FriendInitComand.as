package app.modules.friend.command
{
	import app.modules.ViewName;
	import app.modules.friend.event.FriendEvent;
	import app.modules.friend.model.FriendModel;
	import app.modules.friend.service.FriendService;
	import app.modules.friend.view.FriendAddMediator;
	import app.modules.friend.view.FriendAddView;
	import app.modules.friend.view.FriendMdiator;
	import app.modules.friend.view.FriendOnlineListMediator;
	import app.modules.friend.view.FriendOnlineListView;
	import app.modules.friend.view.FriendView;
	
	import victor.framework.core.BaseCommand;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-6
	 */
	public class FriendInitComand extends BaseCommand
	{
		public function FriendInitComand()
		{
			super();
		}
		
		override public function execute():void
		{
			addView( ViewName.Friend, FriendView, FriendMdiator );
			addView( ViewName.FriendAddView, FriendAddView, FriendAddMediator );
			addView( ViewName.FriendOnline, FriendOnlineListView, FriendOnlineListMediator );
			
			injectActor( FriendModel );
			injectActor( FriendService );
			
			commandMap.mapEvent( FriendEvent.CHECK_ADD, CheckAddFrinedCommand, FriendEvent );
		}
		
	}
}