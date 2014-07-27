package app.modules.fight.panel.friend
{
	import app.modules.fight.panel.search.FightSearchBasePanel;
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-10-17
	 */
	public class FightFriendPanel extends FightSearchBasePanel
	{
		
		public function FightFriendPanel()
		{
			super();
		}
		
		override protected function beforeRender():void
		{
			super.beforeRender();
			createScroll( 264, 332 );
		}
		
		override protected function get skinName():String
		{
			return "ui_Skin_FightFriendPanel";
		}
		
	}
}