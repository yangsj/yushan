package app.modules.fight.view
{
	import flash.geom.Point;
	
	import app.events.PackEvent;
	import app.modules.chat.event.ChatEvent;
	import app.modules.fight.FightType;
	import app.modules.fight.events.FightAloneEvent;
	import app.modules.fight.model.FightModel;
	import app.modules.fight.model.FightReadyModel;
	import app.modules.fight.model.LetterBubbleVo;
	import app.modules.fight.service.FightAloneService;
	import app.modules.fight.view.item.LetterBubble;
	import app.modules.fight.view.prop.PropList;
	import app.modules.fight.view.spell.SpellEvent;
	import app.modules.main.event.MainUIEvent;
	import app.modules.map.model.MapModel;
	import app.modules.model.vo.ItemType;
	import app.modules.model.vo.ItemVo;
	import app.sound.SoundManager;
	
	import net.victoryang.components.Tips;
	import net.victoryang.deubg.Debug;
	import net.victoryang.framework.BaseMediator;
	import net.victoryang.managers.TickManager;
	
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-10-22
	 */
	public class FightBaseMediator extends BaseMediator
	{
		[Inject]
		public var fightModel:FightModel;
		[Inject]
		public var readyModel:FightReadyModel;
		[Inject]
		public var mapModel:MapModel;
		[Inject]
		public var fightService:FightAloneService;
		
		private var baseView:FightBaseView;
		
		protected var letterIndex:int = 0;
		/**
		 * 是否点击道具泡泡
		 */
		protected var clickPropBubble:Array;
		/**
		 * 是否一个人状态
		 */
		protected var isAlone:Boolean = true;
		/**
		 * 不是基础模式时出现泡泡的最大数量
		 */
		protected var maxCount:int = 15;
		/**
		 * 选中的泡泡的位置
		 */
		protected var removeBubblePoint:Point;
		
		
		public function FightBaseMediator()
		{
			super();
		}
		
		override public function onRemove():void
		{
			super.onRemove();
			// 展开聊天窗口
			dispatch( new ChatEvent( ChatEvent.SHOW_CHAT ));
			
			baseView.clear();
			
			baseView.removeConChilds();
			
			baseView.isValidOperate = false;
			
			SoundManager.playMainSceneSoundBg();
		}
		
		override public function onRegister():void
		{
			baseView = this.viewComponent as FightBaseView;
			
			super.onRegister();
			
			// 折叠聊天窗口
			dispatch( new ChatEvent( ChatEvent.HIDE_CHAT ));
			
			// 选择字母
			addViewListener( FightAloneEvent.SELECTED_LETTER, selectedLetterHandler, FightAloneEvent );
			// 退出练习
			addViewListener( FightAloneEvent.EXIT_PRACTICE, exitPracticeHandler, FightAloneEvent );
			//
			addViewListener( FightAloneEvent.CLEAR_DISTURB_SELF, clearSelfDisturbHandler, FightAloneEvent );
			//
			addViewListener( PackEvent.USE_ITEM, useItemPorpHandler, PackEvent );
			//
			addContextListener( FightAloneEvent.USE_SKIP_INPUT_AUTO, useSkipInputAutoHandler, FightAloneEvent );
			
			// 更新金币值变化
			addContextListener( MainUIEvent.UPDATE_MONEY, updateMoneyNotify, MainUIEvent );
			addContextListener( MainUIEvent.UPDATE_PROPERTY, updateMoneyNotify, MainUIEvent );
			// 物品使用成功
			addContextListener( PackEvent.USE_SUCCESS, useItemSuccessHandler, PackEvent );
			// 物品更新
			addContextListener( PackEvent.UPDATE_ITEMS, updateItemsHandler, PackEvent );
			// 更新下一个词
			addContextListener( FightAloneEvent.NOTIFY_NEXT_WORD, nextWordUpdateNotify, FightAloneEvent );
			// 显示增加金币动画
			addContextListener( FightAloneEvent.ADD_MONEY_EFFECT, addMoneyEffectHandler, FightAloneEvent );
			// 完成一个单词输入
			addContextListener( SpellEvent.ONE_WORD_OVER, onWordOverHandler, SpellEvent );
			// 练习模式显示答案中
			addContextListener( FightAloneEvent.SHOW_ANSWER_ING, showAnswerIngHandler, FightAloneEvent );
			
			//初始文本
			baseView.setTxtLeftWordsSelf();
			baseView.setTxtLeftWordsDest();
			
			clickPropBubble = [];
			
			baseView.isValidOperate = true;
			fightModel.isUsePorped = false;
			
			SoundManager.playFightSoundBg();
		}
		
		private function useItemPorpHandler( event:PackEvent ):void
		{
			trace( event.data );
		}
		
		private function useSkipInputAutoHandler( event:FightAloneEvent ):void
		{
			if ( fightModel.spellVo )
			{
				baseView.isValidOperate = false;
				var array:Array = [];
				var vo:LetterBubbleVo;
				var items:Vector.<LetterBubbleVo> = fightModel.spellVo.items;
				for ( var i:int = fightModel.inputNumberLettle; i < items.length; i++ ) {
					vo = items[i];
					array.push( vo.lowerCase );
				}
				abc();
				function abc():void 
				{
					if ( array.length > 0 ) {
						baseView.inputLetter(array.shift(), false );
						TickManager.doTimeout( abc, FightType.SKIP_TIME_PER_LETTER );
					}
				}
			}
		}
		
		private function clearSelfDisturbHandler( event:FightAloneEvent ):void
		{
			fightModel.isHasDisturbForSelf = false;
		}
		
		private function showAnswerIngHandler( event:FightAloneEvent ):void
		{
			baseView.isValidOperate = false;
		}
		
		private function exitPracticeHandler( event:FightAloneEvent ):void
		{
			Debug.debug( "退出练习模式" );
			fightService.exitPractice();
		}
		
		private function onWordOverHandler( event:SpellEvent ):void
		{
			baseView.isValidOperate = false;
		}
		
		protected function addMoneyEffectHandler( event:FightAloneEvent ):void
		{
			var array:Array = event.data as Array;
			if ( array[0] && removeBubblePoint )
				baseView.playAddMoneyEffect( int(array[1]), removeBubblePoint );
		}
		
		protected function updateMoneyNotify( event:MainUIEvent ):void
		{
			baseView.updateMoneyDisplay();
		}
		
		protected function updateItemsHandler( event:PackEvent ):void
		{
			if ( clickPropBubble )
			{
				var bubble:LetterBubble = ( clickPropBubble.length > 0 ) ? clickPropBubble.shift() : null;
				if ( bubble )
				{
					var itemType:int = bubble.data.itemType;
					baseView.delPropItemFromDict( itemType );
					baseView.playAddPropEffect( bubble, PropList.itemPoints[ itemType ] );
				}
			}
		}
		
		protected function nextWordUpdateNotify( event:FightAloneEvent ):void
		{
			baseView.isValidOperate = true;
			letterIndex = 0;
			setLetters();
			setRightAnswerNumber();
		}
		
		// 物品使用成功
		protected function useItemSuccessHandler( event:PackEvent ):void
		{
			var itemVo:ItemVo = event.data as ItemVo;
			var isSelf:Boolean = event.type == PackEvent.USE_SUCCESS;
			if ( itemVo )
			{
				if ( itemVo.type == ItemType.EXTRA_TIME )
				{
					baseView.useExtraTimeProp( isSelf );
				}
				else if ( itemVo.type == ItemType.BROOM )
				{
					baseView.useBroomProp( isSelf );
				}
				else if ( itemVo.type == ItemType.HINT )
				{
					if ( isSelf && fightModel.spellVo ) {
						var items:Vector.<LetterBubbleVo> = fightModel.spellVo.items;
						if ( letterIndex < items.length )
						{
							var key:String = items[ letterIndex ].letter;
							baseView.useHintProp( key );
						}
						Tips.showCenter( "已成功提示一个字母【" + key + "】" );
					}
				}
				else if ( itemVo.type == ItemType.SKIP )
				{
					var msg:String = "成功跳过一个单词！";
					if ( fightModel.spellVo ) {
						msg = "成功跳过单词【" + fightModel.spellVo.english + "】";
					}
					baseView.useSkinProp( msg, isSelf );
				}
			}
		}
		
		protected function selectedLetterHandler( event:FightAloneEvent ):void
		{
			var letterBublle:LetterBubble = event.data as LetterBubble;
			var vo:LetterBubbleVo = letterBublle.data;
			
			removeBubblePoint = letterBublle.globalPoint;
			
			// 测试泡泡
			if ( vo.id == -1 )
				return ;
			
			selectedBubble( vo );
			
			// 选中产生道具的字母泡泡
			if ( vo.itemType != ItemType.DEFAULT )
			{
				clickPropBubble.push( letterBublle );
				fightService.inputProp( vo.id );
			}
			else // 字母泡泡
			{
				baseView.delLetterFromDict( vo.letter );
				letterIndex++;
				dispatch( new FightAloneEvent( FightAloneEvent.UPDATE_WORD, vo ));
			}
		}
		
		protected function selectedBubble( vo:LetterBubbleVo ):void
		{
		}
		
		protected function setLetters():void
		{
			setRightAnswerNumber();
			
			if ( fightModel.spellVo )
			{
				var modeType:int = fightModel.modeType;
				var items:Vector.<LetterBubbleVo> = fightModel.spellVo.items.slice();
				fightModel.isHasDisturbForSelf = false;
				items[0].isUpperCase = true;
				baseView.vecAddBubbleVo = new Vector.<LetterBubbleVo>();
				if ( modeType != FightType.MODE_EASY && modeType != FightType.MODE_PRACTICE && modeType != FightType.MODE_ERROR ) // 不为容易和练习
				{
					var length:int = fightModel.allLetterList.length;
					var index:int = 0;
					if ( modeType == FightType.MODE_BATTLE ) {
						maxCount = Math.min( getOnlineAddCaseNumber( items.length ), length );
					} else {
						maxCount = Math.min( int( Math.random() * 3 + 2 ), length );
					}
					for ( index = 0; index < maxCount; index++ ) {
						items.push( fightModel.allLetterList[ index ] );
						baseView.vecAddBubbleVo.push( items[ items.length - 1 ] );
					}
					fightModel.isHasDisturbForSelf = true;
				}
				baseView.setLettersPool( items );
				Debug.debug( " fightModel.currentIndex *********************************************" +  fightModel.currentSelfIndex );
				if ( modeType > 1 )
				{
					var array:Array = fightModel.dictPropPos[ fightModel.currentSelfIndex ] as Array;
//					var array:Array = testProp();// fightModel.dictPropPos[ fightModel.currentSelfIndex ] as Array;
					if ( array ) {
						for each ( var letterVo:LetterBubbleVo in array )
							baseView.addPropItem( letterVo );
					}
					baseView.displayPropItem();
				}
				// 设置自己还剩余单词数量
				baseView.setTxtLeftWordsSelf( fightModel.progressWordsForSelf );
			}
			else if ( fightModel.isBattle ) {
				Tips.showCenter( "你已拼完所有单词，请等待对方拼完再结算！" );
				baseView.isValidOperate = false;
				baseView.setOverStatusForText( "拼词完成，请先等等对手吧");
			}
		}
		
		private function testProp():Array
		{
			var ary:Array = [];
			for ( var i:int = 1; i < 5; i++)
			{
				var vo:LetterBubbleVo = new LetterBubbleVo();
				vo.itemType = i;
				ary.push( vo );
			}
			return ary;
		}
		
		protected function getOnlineAddCaseNumber( wordLength:int ):int
		{
			if ( wordLength < 4 ) {
				return 5 - wordLength;
			} else if ( wordLength < 7 ) {
				return 6;
			} else if ( wordLength < 10 ) {
				return 5;
			} else if ( wordLength < 13 ) {
				return 4;
			} else if ( wordLength < 15 ) {
				return 3;
			}else if ( wordLength < 18 ) {
				return 2;
			}
			return 1;
		}
		
		protected function setRightAnswerNumber():void
		{
			baseView.setRightAnswerNum( fightModel.answerRightNumSelf, true );
			baseView.setRightAnswerNum( fightModel.answerRightNumDest, false );
		}
		
	}
}