package app.modules.fight.view.spell
{
	import app.modules.fight.events.FightAloneEvent;
	import app.modules.fight.model.FightModel;
	import app.modules.fight.model.LetterBubbleVo;
	import app.modules.fight.service.FightAloneService;
	
	import net.victoryang.framework.BaseMediator;
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-9-27
	 */
	public class SpellAreaMediator extends BaseMediator
	{
		[Inject]
		public var view:SpellArea;
		[Inject]
		public var fightModel:FightModel;
		[Inject]
		public var fightService:FightAloneService;
		
		private var isSendInput:Boolean = false;
		
		public function SpellAreaMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			
			// 移除字母
			addViewListener( FightAloneEvent.REMOVED_LETTER, removedLetterHandler, FightAloneEvent );
			// 输入结束
			addViewListener( SpellEvent.INPUT_OVER, inputOverHandler, SpellEvent );
			// 显示答案
			addViewListener( SpellEvent.SHOW_ANSWER, showAnswerHandler, SpellEvent );
			// 
			addViewListener( SpellEvent.CLICK_SHOW, clickShowHandler, SpellEvent );
			
			//
			addContextListener( FightAloneEvent.USE_SKIP_INPUT_AUTO, useSkipInputAutoHandler, FightAloneEvent );
			
			// 练习中使用跳过道具
			addContextListener( SpellEvent.SHOW_ANSWER, showAnswerByPropHandler, SpellEvent );
			
			// start
			addContextListener( FightAloneEvent.NOTIFY_START_ROUND, nextWordNotify, FightAloneEvent );
			// 更新数据
			addContextListener( FightAloneEvent.UPDATE_WORD, updateWordHandler, FightAloneEvent );
			// 更新下一个
			addContextListener( FightAloneEvent.NOTIFY_NEXT_WORD, nextWordNotify, FightAloneEvent );
			// 字母拼写正确,增加金币
			addViewListener( FightAloneEvent.ADD_MONEY_EFFECT, addMoneyEffectHandler, FightAloneEvent );
			
			fightModel.isShowAnswer = false;
			fightModel.isErrorLastAnswerForPractice = false;
			isSendInput = false;
			if ( fightModel.modeType == 5 ) {
				nextWordNotify( null );
			}
			
		}
		
		private function useSkipInputAutoHandler( event:FightAloneEvent ):void
		{
			isSendInput = true;
		}
		
		private function clickShowHandler( event:SpellEvent ):void
		{
			fightModel.isShowAnswer = true;
		}
		
		private function showAnswerHandler( event:SpellEvent ):void
		{
			fightModel.isErrorLastAnswerForPractice = true;
			dispatch( new FightAloneEvent( FightAloneEvent.SHOW_ANSWER_ING ));
		}
		
		private function addMoneyEffectHandler( event:FightAloneEvent ):void
		{
			dispatch( new FightAloneEvent(FightAloneEvent.ADD_MONEY_EFFECT, [ true, 1 ] ));
		}
		
		private function inputOverHandler( event:SpellEvent ):void
		{
			if ( isSendInput == false )
			{
				var sequence:Array = [];
				for each ( var vo:LetterBubbleVo in view.inputList ) {
					if ( vo == null ) break;
					sequence.push( vo.id );
				}
				isSendInput = true;
				fightService.inputOver( sequence );
				
				dispatch( new SpellEvent( SpellEvent.ONE_WORD_OVER ));
			}
		}
		
		private function nextWordNotify( event:FightAloneEvent ):void
		{
			fightModel.inputNumberLettle = 0;
			fightModel.isShowAnswer = false;
			
			setNextWrodInfo();
			
			if ( view.btnShowAnswer ) {
				view.btnShowAnswer.visible = fightModel.isPractice;
			}
		}
		
		private function setNextWrodInfo():void
		{
			if ( fightModel.spellVo )
			{
				fightModel.isErrorLastAnswerForPractice = false;
				isSendInput = false;
				view.setInitData( fightModel.spellVo );
				view.setPos( fightModel.isPractice );
			}
		}
		
		private function updateWordHandler( event:FightAloneEvent ):void
		{
			fightModel.inputNumberLettle += 1;
			view.setSingleLetter( event.data as LetterBubbleVo );
		}
		
		private function removedLetterHandler( evnt:FightAloneEvent ):void
		{
		}
		
		private function showAnswerByPropHandler( event:SpellEvent ):void
		{
			view.showAnswerResult();
		}
		
	}
}