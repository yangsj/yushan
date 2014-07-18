package app.modules.friend.view
{
	import app.modules.ViewName;
	
	import victor.framework.events.PanelEvent;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-10-23
	 */
	public class FriendOnlineListMediator extends FriendMdiator
	{
		
		public function FriendOnlineListMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			// 关闭
			closeView( ViewName.Friend );
			
			view = this.viewComponent as FriendOnlineListView;
			
			super.onRegister();
			
			addViewListener( PanelEvent.CLOSE, closeQuitHandler, PanelEvent );
		}
		
		override protected function setFriendList():void
		{
			view.setData( friendModel.onLineList );
		}
		
		private function closeQuitHandler( event:PanelEvent ):void
		{
			openView( ViewName.Friend );
		}
		
	}
}