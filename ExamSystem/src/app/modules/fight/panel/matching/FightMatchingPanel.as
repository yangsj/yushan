package app.modules.fight.panel.matching
{
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import app.core.ButtonSkin;
	import app.data.GameData;
	import app.modules.model.GenderType;
	
	import net.victoryang.components.Tips;
	import net.victoryang.framework.BasePanel;
	import net.victoryang.func.removedFromParent;
	import net.victoryang.managers.TickManager;
	import net.victoryang.uitl.HtmlText;
	
	
	/**
	 * ……自动匹配
	 * @author 	victor 
	 * 			2013-10-17
	 */
	public class FightMatchingPanel extends BasePanel
	{
		public var txtPlayer1:TextField;
		public var txtPlayer2:TextField;
		
		public function FightMatchingPanel()
		{
			super();
		}
		
		override protected function onceInit():void
		{
			removedFromParent( btnClose );
			btnClose = ButtonSkin.buttonExit;
			_skin.addChild( btnClose );
		}
		
		override public function hide():void
		{
			super.hide();
			TickManager.clearDoTime( doTimeout );
		}
		
		override protected function afterRender():void
		{
			super.afterRender();
			var color:uint = GenderType.getColor(GameData.instance.selfVo.gender);
			txtPlayer1.htmlText = HtmlText.color( GameData.instance.selfVo.name, color );
			
			TickManager.doTimeout( doTimeout, 15000 );
		}
		
		private function doTimeout():void
		{
			btnClose.dispatchEvent( new MouseEvent( MouseEvent.CLICK ));
			Tips.showCenter( "自动匹配超时！！！" );
		}
		
		override protected function get resNames():Array
		{
			return ["ui_matching" ];
		}
		
		override protected function get skinName():String
		{
			return "ui_Skin_FightMatchingPanel";
		}
		
	}
}