package app.modules.fight.view.panel
{
	import app.modules.ViewName;

	/**
	 * ……
	 * @author 	victor
	 * 			2013-9-28
	 */
	public class FightWinMediator extends FightResultBaseMediator
	{
		[Inject]
		public var view:FightWinPanel;

		public function FightWinMediator()
		{
			super();
		}

		override public function onRegister():void
		{
			super.onRegister();
			view.setData( fightModel.fightEndVo );
			
			// 是否是达人闯关成功|是，则打开分享界面
			if ( fightModel.modeType == 3 )
				openView( ViewName.ShareWeiboPanel );
		}
		
		override protected function againHandler(event:FightResultEvent):void
		{
			super.againHandler( event );
			view.hide();
		}
		
		override protected function nextHandler(event:FightResultEvent):void
		{
			super.nextHandler( event );
			view.hide();
		}
		
		override protected function practiceHandler(event:FightResultEvent):void
		{
			super.practiceHandler( event );
			view.hide();
		}
		
	}
}
