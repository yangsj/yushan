package app.modules.fight.view.panel
{
	import app.modules.fight.model.FightEndVo;
	
	import net.victoryang.uitl.UtilsFilter;
	
	/**
	 * ……
	 * @author 	victor
	 * 			2013-9-28
	 */
	public class FightWinPanel extends FightResultBasePanel
	{

		public function FightWinPanel()
		{
			super();
		}

		override public function setData( endVo:FightEndVo ):void
		{
			super.setData( endVo );
			mcStar.gotoAndStop( Math.max( endVo.starNum, 1 ));
			mcStar.filters = endVo.starNum == 0 ? [ UtilsFilter.COLOR_GREW ] : [];
		}

		override protected function get skinName():String
		{
			return "ui_Skin_Round_WinMainPanel";
		}

		override protected function get resNames():Array
		{
			return [ "ui_round_winPanel" ];
		}

	}
}
