package app.modules.fight.command
{
	import app.modules.ViewName;
	import app.modules.fight.model.FightModel;
	import app.modules.fight.model.FightReadyModel;
	import app.modules.fight.panel.friend.FightFriendMediator;
	import app.modules.fight.panel.friend.FightFriendPanel;
	import app.modules.fight.panel.matching.FightMatchingMediator;
	import app.modules.fight.panel.matching.FightMatchingPanel;
	import app.modules.fight.panel.ready.FightReadyMediator;
	import app.modules.fight.panel.ready.FightReadyPanel;
	import app.modules.fight.panel.result.FightOnlineResultMediator;
	import app.modules.fight.panel.result.FightOnlineResultPanel;
	import app.modules.fight.panel.search.FightSearchMediator;
	import app.modules.fight.panel.search.FightSearchPanel;
	import app.modules.fight.service.FightAloneService;
	import app.modules.fight.service.FightOnlineService;
	import app.modules.fight.view.alone.FightAloneMediator;
	import app.modules.fight.view.alone.FightAloneView;
	import app.modules.fight.view.online.FightOnlineMediator;
	import app.modules.fight.view.online.FightOnlineView;
	import app.modules.fight.view.panel.FightLoseMediator;
	import app.modules.fight.view.panel.FightLosePanel;
	import app.modules.fight.view.panel.FightPracticeEndMediator;
	import app.modules.fight.view.panel.FightPracticeEndPanel;
	import app.modules.fight.view.panel.FightWinMediator;
	import app.modules.fight.view.panel.FightWinPanel;
	import app.modules.fight.view.practice.FightPracticeMediator;
	import app.modules.fight.view.practice.FightPracticeView;
	import app.modules.fight.view.prop.PropList;
	import app.modules.fight.view.prop.PropListMediator;
	import app.modules.fight.view.spell.SpellArea;
	import app.modules.fight.view.spell.SpellAreaMediator;
	
	import victor.framework.core.BaseCommand;
	import victor.framework.events.PanelEvent;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-27
	 */
	public class FightInitCommand extends BaseCommand
	{
		public function FightInitCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			addView( ViewName.FightPractice, FightPracticeView, FightPracticeMediator );//错误练习界面
			addView( ViewName.FightPracticeEndPanel, FightPracticeEndPanel, FightPracticeEndMediator ); // 错误练习结束面板
			
			addView( ViewName.FightAlone, FightAloneView, FightAloneMediator );//闯关和练习本关界面
			
			addView( ViewName.FightWinPanel, FightWinPanel, FightWinMediator );// 闯关胜利结算界面
			addView( ViewName.FightLosePanel, FightLosePanel, FightLoseMediator );// 闯关失败结算界面
			
			addView( ViewName.FightOnline, FightOnlineView, FightOnlineMediator );//在线对战界面
			addView( ViewName.FightMatchingPanel, FightMatchingPanel, FightMatchingMediator );//匹配界面
			addView( ViewName.FightReadyPanel, FightReadyPanel, FightReadyMediator );//准备界面
			addView( ViewName.FightOnlineResultPanel, FightOnlineResultPanel, FightOnlineResultMediator );//在线对战结束界面
			addView( ViewName.FightFriendPanel, FightFriendPanel, FightFriendMediator );//好友在线对战
			addView( ViewName.FightSearchPanel, FightSearchPanel, FightSearchMediator );//搜索在线对战
			
			mapView( PropList, PropListMediator ); //道具列表
			mapView( SpellArea, SpellAreaMediator );//批次字母输入
			
			injectActor( FightModel );
			injectActor( FightReadyModel );
			injectActor( FightAloneService );
			injectActor( FightOnlineService );
			
			commandMap.mapEvent( PanelEvent.LOAD_END,   FightInviteCommand, PanelEvent );
			commandMap.mapEvent( PanelEvent.LOAD_START, FightInviteCommand, PanelEvent );
		}
		
	}
}