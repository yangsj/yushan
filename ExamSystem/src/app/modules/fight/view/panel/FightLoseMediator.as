package app.modules.fight.view.panel
{

	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-9-28
	 */
	public class FightLoseMediator extends FightResultBaseMediator
	{
		[Inject]
		public var view:FightLosePanel;

		public function FightLoseMediator()
		{
			super();
		}

		override public function onRegister():void
		{
			super.onRegister();
			view.setData( fightModel.fightEndVo );
		}
		
		override protected function againHandler(event:FightResultEvent):void
		{
			super.againHandler( event );
			view.hide();
		}
		
		override protected function nextHandler(event:FightResultEvent):void
		{
//			super.nextHandler( event );
//			view.hide();
		}
		
		override protected function practiceHandler(event:FightResultEvent):void
		{
			super.practiceHandler( event );
			view.hide();
		}

	}
}
