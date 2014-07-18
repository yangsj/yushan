package app.modules.friend.view
{
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-10-23
	 */
	public class FriendOnlineListView extends FriendView
	{
		
		public function FriendOnlineListView()
		{
			super();
		}
		
		override protected function onceInit():void
		{
			scrollHeight = 165;
		}
		
		override protected function get skinName():String
		{
			return "ui_Skin_FriendOnlineView";
		}
	}
}