package app.modules.fight.view.panel
{
	import flash.text.TextField;
	
	import app.core.Text;
	import app.modules.fight.model.FightEndVo;

	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-9-28
	 */
	public class FightLosePanel extends FightResultBasePanel
	{
		public function FightLosePanel()
		{
			super();
		}
		
		override protected function onceInit():void
		{
			super.onceInit();
			
			btnNext.visible = false;
		}

		override protected function get skinName():String
		{
			return "ui_Skin_Round_LoseMainPanel";
		}

		override protected function get resNames():Array
		{
			return [ "ui_round_losePanel" ];
		}
	}
}
