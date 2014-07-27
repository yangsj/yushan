package app.modules.fight.view.online
{
	import app.data.GameData;
	import app.events.PackEvent;
	import app.modules.ViewName;
	import app.modules.fight.events.FightAloneEvent;
	import app.modules.fight.events.FightOnlineEvent;
	import app.modules.fight.model.LetterBubbleVo;
	import app.modules.fight.service.FightOnlineService;
	import app.modules.fight.view.FightBaseMediator;
	import app.modules.fight.view.spell.SpellVo;
	
	import net.victoryang.deubg.Debug;
	import net.victoryang.func.removedAllChildren;
	
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-9-27
	 */
	public class FightOnlineMediator extends FightBaseMediator
	{
		[Inject]
		public var view:FightOnlineView;
		[Inject]
		public var onlineService:FightOnlineService;
		
		public function FightOnlineMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			view.isAlone = false;
			isAlone = false;
			maxCount = 15;
			
			super.onRegister();
			
			// 若是结果显示面板已打开则关闭
			closeView( ViewName.FightOnlineResultPanel );
			
			// 结束通知
			addContextListener( FightOnlineEvent.BATTLE_END, endBattleNotify, FightOnlineEvent );
			// 删除对手屏幕中的泡泡
			addContextListener( FightOnlineEvent.DEL_DEST_BUBLLE, delDestBubbleHandler, FightOnlineEvent );
			// 对手更新下一个单词
			addContextListener( FightOnlineEvent.DEST_UPDATE_NEXT, destUpdateNextNotify, FightOnlineEvent );
			// 对手使用个道具
			addContextListener( PackEvent.DEST_USE_SUCCESS, useItemSuccessHandler, PackEvent );
			
			addViewListener( FightAloneEvent.CLEAR_DISTURB_DEST, clearDisturbDestHandler, FightAloneEvent );
			
			initData();
			
			view.btnClose.visible = false;
		}
		
		private function clearDisturbDestHandler( event:FightAloneEvent ):void
		{
			fightModel.isHasDisturbForDest = false;
		}
		
		// 删除对手屏幕中的泡泡
		private function delDestBubbleHandler( event:FightOnlineEvent ):void
		{
			var letterVo:LetterBubbleVo = event.data as LetterBubbleVo;
			view.delBubbleByIdForOther( letterVo.id );
		}
		
		private function destUpdateNextNotify( event:FightOnlineEvent ):void
		{
			view.answerResult( Boolean( event.data ), false );
			setOtherLetters();
		}
		
		// 结束通知
		private function endBattleNotify( event:FightOnlineEvent ):void
		{
			view.clear();
			openView( ViewName.FightOnlineResultPanel );
		}
		
		private function initData():void
		{
			letterIndex = 0;
			view.initialize();
			view.setPlayerName( GameData.instance.selfVo.name, readyModel.destVo.name );
			updateMoneyNotify( null );
			setLetters();
			setOtherLetters();
		}
		
		private function setOtherLetters():void
		{
			setRightAnswerNumber();
			
			if ( fightModel.spellCopyVo )
			{
				var spellVo:SpellVo = fightModel.spellCopyVo;
				var items:Vector.<LetterBubbleVo> = spellVo.items.slice();
				var length:int = fightModel.allLetterListCopy.length;
				var index:int = 0;
				fightModel.isHasDisturbForDest = false;
				items[0].isUpperCase = true;
				Debug.debug( "对手的单词：" + spellVo.chinese );
				view.vecAddBubbleVoForOther = new Vector.<LetterBubbleVo>();
				maxCount = Math.min( getOnlineAddCaseNumber( items.length ), length );
				for ( index = 0; index < maxCount; index++ ) {
					items.push( fightModel.allLetterListCopy[ index ] );
					view.vecAddBubbleVoForOther.push( items[ items.length - 1 ]);
				}
				fightModel.isHasDisturbForDest = maxCount > 0;
				
				view.setLettersPool( items, false );
				
				var array:Array = fightModel.dictPropPos[ fightModel.currentDestIndex ] as Array;
				if ( array ) {
					var letterVo:LetterBubbleVo;
					for each ( letterVo in array )
						view.addPropItem( letterVo, false );
				}
				view.displayPropItem( false );
				
				// 设置自己还剩余单词数量
				view.setTxtLeftWordsDest( fightModel.progressWordsForDest );
			}
			else
			{
				removedAllChildren( view.container2 );
			}
		}
		
		override protected function nextWordUpdateNotify( event:FightAloneEvent ):void
		{
			view.answerResult( Boolean( event.data ), true );
			super.nextWordUpdateNotify( event );
		}
		
		// 选择泡泡通知对方
		override protected function selectedBubble(vo:LetterBubbleVo):void
		{
			onlineService.selectedBubble( vo );
		}
		
	}
}