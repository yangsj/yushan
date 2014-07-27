package app.modules.fight.panel.ready
{
	import flash.display.Sprite;
	
	import app.core.ButtonSkin;
	import app.modules.fight.model.FightMatchingVo;
	
	import net.victoryang.framework.BasePanel;
	import net.victoryang.func.removedFromParent;
	
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-10-17
	 */
	public class FightReadyPanel extends BasePanel
	{
		private var itemLeft:FightReadyItem;
		private var itemRight:FightReadyItem;
		
		public var player1:Sprite;
		public var player2:Sprite;
		
		public function FightReadyPanel()
		{
			super();
		}
		
		override protected function onceInit():void
		{
			super.onceInit();
			
			removedFromParent( btnClose );
			btnClose = ButtonSkin.buttonExit;
			_skin.addChild( btnClose );
			
			itemLeft = new FightReadyItem( player1 );
			itemRight = new FightReadyItem( player2 );
			player2.mouseChildren = false;
			player2.mouseEnabled = false;
		}
		
		public function setData( self:FightMatchingVo, deatVo:FightMatchingVo ):void
		{
			itemLeft.setData( self );
			itemRight.setData( deatVo );
		}
		
		public function refreshStatus( isOk:Boolean = true ):void
		{
			itemRight.refreshStatus( isOk );
		}
		
		override protected function get resNames():Array
		{
			return ["ui_ready" ];
		}
		
		override protected function get skinName():String
		{
			return "ui_Skin_FightReadyPanel";
		}
	}
}