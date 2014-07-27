package app.modules.fight.view.practice
{
	import app.modules.fight.view.alone.FightAloneMediator;
	import app.modules.fight.view.alone.FightAloneView;
	
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-11-20
	 */
	public class FightPracticeMediator extends FightAloneMediator
	{
		public function FightPracticeMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			view = this.viewComponent as FightAloneView;
			
			super.onRegister();
		}
		
		override protected function pullData():void
		{
			fightService.startRound( 3 );
		}
		
	}
}