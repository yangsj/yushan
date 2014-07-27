package app.modules.fight.view.panel
{
	import flash.text.TextField;
	
	import app.modules.fight.model.FightEndVo;
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-11-20
	 */
	public class FightPracticeEndPanel extends FightResultBasePanel
	{
		public var txtErrorWordList:TextField;
		
		public function FightPracticeEndPanel()
		{
			super();
		}
		
		override public function setData( endVo:FightEndVo ):void
		{
			super.setData( endVo );
			txtErrorWordList.text = "";
			var i:int = 0;
			for each ( var word:String in endVo.wrongList ) {
				txtErrorWordList.appendText( word + "\t" + (i!=0&&i%3==0?"\n":"") );
				i++;
			}
		}
		
		override protected function get resNames():Array
		{
			return ["ui_fight_error"];
		}
		
		override protected function get skinName():String
		{
			return "ui_Skin_FightPracticeEndPanel";
		}
		
	}
}