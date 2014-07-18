package app.modules.fight.service
{
	import flash.utils.Dictionary;
	
	import app.core.Tips;
	import app.data.GameData;
	import app.modules.LoadingEffect;
	import app.modules.ViewName;
	import app.modules.fight.events.FightAloneEvent;
	import app.modules.fight.events.FightOnlineEvent;
	import app.modules.fight.model.FightEndVo;
	import app.modules.fight.model.FightModel;
	import app.modules.fight.model.LetterBubbleVo;
	import app.modules.fight.view.spell.SpellVo;
	import app.modules.map.model.MapModel;
	import app.modules.map.model.RoundVo;
	import app.modules.model.vo.ItemVo;
	import app.modules.task.event.TaskEvent;
	import app.sound.SoundManager;
	import app.sound.SoundType;
	
	import ff.bubble_info_t;
	import ff.client_cmd_e;
	import ff.end_round_ret_t;
	import ff.input_req_t;
	import ff.next_word_t;
	import ff.quit_round_req_t;
	import ff.select_item_bubble_req_t;
	import ff.server_cmd_e;
	import ff.start_round_req_t;
	import ff.start_round_ret_t;
	
	import victor.framework.core.BaseService;
	import victor.framework.debug.Debug;
	import victor.framework.manager.TickManager;
	import victor.framework.socket.SocketResp;

	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-9-24
	 */
	public class FightAloneService extends BaseService
	{
		[Inject]
		public var fightModel:FightModel;
		[Inject]
		public var mapModel:MapModel;

		public function FightAloneService()
		{
			super();
		}

		override protected function initRegist():void
		{
			// 闯关练习开始关卡
			regist( server_cmd_e.START_ROUND_RET, startRoundNotify, start_round_ret_t );
			// 关卡结束
			regist( server_cmd_e.END_ROUND_RET, endRoundNotify, end_round_ret_t );
			// 闯关练习下一个单词
			regist( server_cmd_e.NEXT_WORD_RET, nextWordNotify, next_word_t );
		}

		// 闯关练习开始
		private function startRoundNotify( resp:SocketResp ):void
		{
			Tips.isFighting = true;
			
			fightModel.isFighting = true;
			fightModel.isSelfExit = false;
			fightModel.isHasDisturbForSelf = false;
			fightModel.isHasDisturbForDest = false;
			
			var data:start_round_ret_t = resp.data as start_round_ret_t;
			var cnAry:Array = data.chinese_words;
			var blanks:Array = data.blank;
			var bubbles:Array = data.bubble_info;
			var length:int = cnAry.length;
			var spellVo:SpellVo;
			var info:bubble_info_t;
			var order:int;
			var index:int;
			var tempBub:Array;
			var english:String = "";
			var letterBubbleVo:LetterBubbleVo;
			
			var spellList:Vector.<SpellVo> = new Vector.<SpellVo>( length );
			var spellList2:Vector.<SpellVo> = new Vector.<SpellVo>( length );
			var listBub:Vector.<LetterBubbleVo>;
			var listBub2:Vector.<LetterBubbleVo>;
			var allLetterList:Vector.<LetterBubbleVo> = new Vector.<LetterBubbleVo>();
			var allLetterList2:Vector.<LetterBubbleVo> = new Vector.<LetterBubbleVo>();
			
			// 单词数据
			for ( var i:int = 0; i < length; i++ )
			{
				index = int( blanks[ i ]);
				tempBub = bubbles.splice( 0, index );
				listBub = new Vector.<LetterBubbleVo>();
				listBub2 = new Vector.<LetterBubbleVo>();
				english = "";
				order = 0;
				for each ( info in tempBub )
				{
					letterBubbleVo = new LetterBubbleVo();
					letterBubbleVo.index = order;
					letterBubbleVo.id = info.bubble_id;
					letterBubbleVo.letter = info.word;
					letterBubbleVo.itemType = info.item_type;
					listBub.push( letterBubbleVo );
					allLetterList.push( letterBubbleVo );
					
					letterBubbleVo = new LetterBubbleVo();
					letterBubbleVo.index = order;
					letterBubbleVo.id = info.bubble_id;
					letterBubbleVo.letter = info.word;
					letterBubbleVo.itemType = info.item_type;
					listBub2.push( letterBubbleVo );
					allLetterList2.push( letterBubbleVo );
					
					english += letterBubbleVo.letter;
					order++;
					
				}
				spellVo = new SpellVo();
				spellVo.chinese = cnAry[ i ];
				spellVo.english = english;
				spellVo.items = listBub;
				spellList[ i ] = spellVo;
				
				spellVo = new SpellVo();
				spellVo.chinese = cnAry[ i ];
				spellVo.english = english;
				spellVo.items = listBub2;
				spellList2[ i ] = spellVo;
				
				Debug.debug( spellVo.chinese, english );
			}
			// 道具数据
			var dict:Dictionary = new Dictionary();
			for ( var key:* in data.bubble_item )
			{
				var ary:Array = data.bubble_item[key];
				var temp:Array = [];
				order = 0;
				for each ( info in ary )
				{
					letterBubbleVo = new LetterBubbleVo();
					letterBubbleVo.index = order;
					letterBubbleVo.id = info.bubble_id;
					letterBubbleVo.letter = info.word;
					letterBubbleVo.itemType = info.item_type;
					temp.push( letterBubbleVo );
					order++;
				}
				dict[ key ] = temp;
			}
			fightModel.dictPropPos = dict;
			fightModel.allLetterList = allLetterList;
			fightModel.allLetterListCopy = allLetterList2;
			fightModel.spellList = spellList;
			fightModel.spellListCopy = spellList2;
			fightModel.modeType = data.mode;
			fightModel.mapId = data.round_type;
			fightModel.roundId = data.round_id;
			fightModel.totalWordsNum = spellList.length;
			mapModel.currentMapVo.mapId = data.round_type;
			fightModel.isEnded = false;
			fightModel.answerRightNumSelf = 0;
			fightModel.answerRightNumDest = 0;
			
			Tips.isBattle = fightModel.isBattle;

			// 清零
			fightModel.currentSelfIndex = 0;
			fightModel.currentDestIndex = 0;
			
			// 设置第一个单词信息
			updateSelfWordList();
			updateDestWordList();

			if ( fightModel.modeType == 5 ) // 在线对战
			{
				closeView( ViewName.FightReadyPanel );
				openView( ViewName.FightOnline );
			}
			else // 闯关和练习/错误练习
			{
				dispatch( new FightAloneEvent( FightAloneEvent.NOTIFY_START_ROUND ));
			}
		}

		// 结束
		private function endRoundNotify( resp:SocketResp ):void
		{
			var data:end_round_ret_t = resp.data as end_round_ret_t;
			var endVo:FightEndVo = getBattleEndVo( data );
			fightModel.fightEndVo = endVo;
			fightModel.isEnded = true;
			
			SoundManager.playEffectMusic( endVo.isWin ? SoundType.SUCCESS : SoundType.FAILED );
			
			if ( fightModel.isSelfExit )
			{
				if ( fightModel.isErrorPractice ) {
					closeView( ViewName.FightPractice );
				} else {
					closeView( ViewName.FightAlone );
				}
			}
			else
			{
				TickManager.doTimeout( function abc():void {
					dispatch( new FightAloneEvent( FightAloneEvent.NOTIFY_END_ROUND ));
				}, 500 );
				
				fightModel.isFighting = false;
				
				dispatch( new TaskEvent( TaskEvent.TASK_CHECK_COMPLETED ));
			}
			
			Tips.isFighting = false;
			Tips.isBattle = false;
		}

		// 下一个单词
		private function nextWordNotify( resp:SocketResp ):void
		{
			var data:next_word_t = resp.data as next_word_t;
			var isSelf:Boolean = data.uid == GameData.instance.selfVo.uid;
			
			if ( data.answer_flag ) {
				if ( isSelf ) fightModel.answerRightNumSelf++;
				else fightModel.answerRightNumDest++;
			}
			
			if ( isSelf )
			{
				var isDelay:Boolean = false;
				// 不是使用道具完成一个单词时
				if ( !fightModel.isUsePorped ) {
					if ( data.answer_flag ) {
						Tips.showCenter( "恭喜您！答对了。" );
					} else {
						if (　!fightModel.isPractice || ( fightModel.isPractice && fightModel.isShowAnswer == false )) {
							Tips.showCenter( "请牢记，下次就不会再错了。" );
						}
						isDelay = true;
					}
				}
				fightModel.isUsePorped = false;
				
				// 设置下一个单词信息
				fightModel.currentSelfIndex++;
				updateSelfWordList();
				
				var time:int = fightModel.isErrorLastAnswerForPractice || isDelay ? 2000 : 500;
				TickManager.doTimeout( function abc( result:Boolean ):void {
					if ( !fightModel.isEnded ) {
						dispatch( new FightAloneEvent( FightAloneEvent.NOTIFY_NEXT_WORD, result ));
					}
				}, time, data.answer_flag );
			}
			else
			{
				fightModel.currentDestIndex++;
				updateDestWordList();
				//
				dispatch( new FightOnlineEvent( FightOnlineEvent.DEST_UPDATE_NEXT, data.answer_flag ));
			}
		}
		
		private function updateSelfWordList():void
		{
			fightModel.updateSelfWordList();
		}
		
		private function updateDestWordList():void
		{
			fightModel.updateDestWordList();
		}

		////////////// request ///////////
		
		public function getBattleEndVo( battleData:end_round_ret_t ):FightEndVo
		{
			var endVo:FightEndVo = new FightEndVo();
			if ( battleData )
			{
				var dict:Dictionary = battleData.inc_items;
				for each ( var key:String in dict )
				{
					var itemVo:ItemVo = new ItemVo();
					itemVo.type = int( key );
					itemVo.num = dict[key];
					endVo.items.push( itemVo );
				}
				endVo.addExp = battleData.inc_exp;
				endVo.addMoney = battleData.inc_coin;
				endVo.currentLevel = battleData.cur_level;
				endVo.isWin = battleData.win;
				endVo.rightNum = battleData.right_num;
				endVo.starNum = battleData.inc_star;
				endVo.wrongList = battleData.wrong_words;
			}
			return endVo;
		}

		/**
		 * 开始战斗 [type: 0 表示普通闯关，1表示练习这一关, 2 表示进行下一关, 3 错误练习]
		 * @param roundLevel 世界地图的类型
		 * @param roundType 0-9 哪一组
		 * @param destUid 对手的uid，只在对战时有效
		 */
		public function startRound( type:int = 0 ):void
		{
			var roundVo:RoundVo = mapModel.currentRoundVo;
			var req:start_round_req_t = new start_round_req_t();
			req.round_type = roundVo.mapId;
			req.round_group_id = roundVo.chapterId;
			req.round_id = roundVo.roundId;
			req.mode = type;
			call( client_cmd_e.START_ROUND_REQ, req );
		}

		public function inputOver( sequence:Array ):void
		{
			var req:input_req_t = new input_req_t();
			req.input = sequence;
			call( client_cmd_e.INPUT_REQ, req );
			LoadingEffect.hide();
		}

		/**
		 * 点击到道具
		 * @param id
		 */
		public function inputProp( id:int ):void
		{
			var req:select_item_bubble_req_t = new select_item_bubble_req_t();
			req.bubble_id = id;
			call( client_cmd_e.SELECT_ITEM_BUBBLE_REQ , req );
			LoadingEffect.hide();
		}
		
		/**
		 * 退出练习
		 */
		public function exitPractice():void
		{
			fightModel.isSelfExit = true;
			var req:quit_round_req_t = new quit_round_req_t();
			call( client_cmd_e.QUIT_ROUND_REQ , req );
		}
		

	}
}
