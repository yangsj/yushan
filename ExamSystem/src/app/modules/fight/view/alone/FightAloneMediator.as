package app.modules.fight.view.alone
{
	import app.modules.ViewName;
	import app.modules.fight.events.FightAloneEvent;
	import app.modules.fight.view.FightBaseMediator;
	
	import net.victoryang.uitl.HtmlText;
	
	
	/**
	 * ……
	 * @author 	victor
	 * 			2013-9-27
	 */
	public class FightAloneMediator extends FightBaseMediator
	{
		[Inject]
		public var view:FightAloneView;
		
		public function FightAloneMediator()
		{
			super();
		}
		
		override public function onRemove():void
		{
			super.onRemove();
			fightModel.modeType = 0;
			if ( mapModel.isNeddOpenFromFight )
				openView( ViewName.SelectedRoundPanel, mapModel.currentMapVo );
		}

		override public function onRegister():void
		{
			view.isAlone = true;
			isAlone = true;
			maxCount = 18;
			
			super.onRegister();

			// 开始通知
			addContextListener( FightAloneEvent.NOTIFY_START_ROUND, startRoundNotify, FightAloneEvent );
			// 结束通知
			addContextListener( FightAloneEvent.NOTIFY_END_ROUND, endRoundNotify, FightAloneEvent );
			
			// 拉取数据
			pullData();
			
			view.btnClose.visible = true;
		}
		
		protected function endRoundNotify( event:FightAloneEvent ):void
		{
			view.clear();
			if ( fightModel.isPractice )
			{
				openView( ViewName.FightPracticeEndPanel );
			}
			else if ( fightModel.fightEndVo.isWin )
				openView( ViewName.FightWinPanel );
			else openView( ViewName.FightLosePanel );
		}
		
		private function startRoundNotify( event:FightAloneEvent ):void
		{
			initData();
		}

		protected function  pullData():void
		{
			fightService.startRound( mapModel.isSelectedRound ? 0 : 1 );
		}

		private function initData():void
		{
			if ( fightModel.isPractice ) {
				view.setRoundName( mapModel.currentMapVo.mapName + "<br>" + HtmlText.color("练习", 0xffffff ) );
			} else {
				view.setRoundName( mapModel.currentMapVo.mapName + "<br>" + HtmlText.color("第" + ( fightModel.roundId + 1 ) + "关", 0xffffff ) );
			}
			view.selfBar.visible = !fightModel.isPractice;
			
			letterIndex = 0;
			view.initialize( fightModel.isPractice );
			updateMoneyNotify( null );
			setLetters();
			
			// 设置背景
			view.setBg( mapModel.currentMapVo.mapId );
		}

	}
}
