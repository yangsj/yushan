package app.modules.fight.view.panel
{
	import app.modules.ViewName;
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-11-20
	 */
	public class FightPracticeEndMediator extends FightResultBaseMediator
	{
		[Inject]
		public var view:FightPracticeEndPanel;
		
		public function FightPracticeEndMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			view.setData( fightModel.fightEndVo );
		}
		
		override protected function practiceHandler( event:FightResultEvent ):void
		{
			view.hide();
			fightService.startRound( 3 );
		}
		
		override protected function closeHandler( event:FightResultEvent ):void
		{
			closeView( ViewName.FightAlone );
			closeView( ViewName.FightPractice );
		}
	}
}