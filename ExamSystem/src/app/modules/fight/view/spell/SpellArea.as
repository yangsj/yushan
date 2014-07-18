package app.modules.fight.view.spell
{
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import app.modules.fight.events.FightAloneEvent;
	import app.modules.fight.model.LetterBubbleVo;
	
	import victor.framework.core.BaseSprite;
	import victor.framework.manager.TickManager;
	import victor.utils.removedFromParent;


	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-9-27
	 */
	public class SpellArea extends BaseSprite
	{
		private const MAX:int = 14;

		public var btnShowAnswer:InteractiveObject;
		public var txtChinese:TextField;
		public var txtEnglish:TextField;
		
		private var _inputList:Vector.<LetterBubbleVo>;
		private var _spellVo:SpellVo;
		private var _inputNum:int = 0;
		private var _isPractice:Boolean = false;
		private var _lastIsAnswerError:Boolean = false;

		public function SpellArea()
		{
			super();
		}
		
		public function setPos(isPractice:Boolean = false ):void
		{
			_isPractice = isPractice;
//			x = isPractice ? 440 : 330;
//			y = 460;
		}

		public function initSkin():void
		{
//			setSkinWithName( "ui_Skin_Round_SpellArea" );
			txtChinese.mouseEnabled = false;
			if ( btnShowAnswer == null ) {
				btnShowAnswer = new Sprite();
			}
			btnShowAnswer.addEventListener(MouseEvent.CLICK, onClickBtnShowAnswerHandler );
			// 不显示
			removedFromParent( btnShowAnswer );
		}
		
		protected function onClickBtnShowAnswerHandler(event:MouseEvent):void
		{
			dispatchEvent( new SpellEvent( SpellEvent.CLICK_SHOW ));
			showAnswerResult();
		}
		
		public function showAnswerResult():void
		{
			btnShowAnswer.mouseEnabled = false;
			showAnswer();
			inputOver();
		}
		
		public function setInitData( spellVo:SpellVo ):void
		{
			btnShowAnswer.mouseEnabled = true;
			_lastIsAnswerError = false;
			
			_spellVo = spellVo;
			_inputList = new Vector.<LetterBubbleVo>( _spellVo.charsLength );
			_inputNum = 0;

			txtChinese.text = spellVo.chinese;

			// 初始化字母显示格子
			displayInput();
		}

		/**
		 * 设置单个字母显示
		 * @param index 位置
		 * @param letter 字母
		 */
		public function setSingleLetter( letterBubbleVo:LetterBubbleVo ):void
		{
			if ( _inputList && _spellVo )
			{
				_inputNum = getEmptyIndex;
				var isOver:Boolean = false;
				var isErrorInput:Boolean = false;
				if ( _inputNum != -1 )
				{
					var current:LetterBubbleVo = _spellVo.items[ _inputNum ];
					if ( letterBubbleVo && current.lowerCase == letterBubbleVo.lowerCase ) // 输入的字母顺序是否正确
					{
						_inputList[_inputNum] = letterBubbleVo;
						displayInput();
						
						isOver = ( getEmptyIndex == -1 );
						
						// add money
						dispatchEvent( new FightAloneEvent( FightAloneEvent.ADD_MONEY_EFFECT ));
					}
					else 
					{
						isErrorInput = true;
						isOver = true;
						_lastIsAnswerError = true;
					}
				}
				if ( isOver ) {
					if ( isErrorInput || (_isPractice && _lastIsAnswerError ))
						showAnswerResult();
					else inputOver();
				}
			}
			else
			{
				throw new Error( "setSingleLetter没有初始化" );
			}
		}
		
		public function get inputList():Vector.<LetterBubbleVo>
		{
			return _inputList;
		}
		
		public function clear():void
		{
			TickManager.instance.clearDoTime( inputOver );
		}
		
		private function showAnswer():void
		{
			var item:SpellItem;
			var leng:int = Math.min(_spellVo.items.length, MAX );
			txtEnglish.text = _spellVo.english;
			dispatchEvent( new SpellEvent( SpellEvent.SHOW_ANSWER ));
		}
		
		public function get lastIsAnswerError():Boolean
		{
			return _lastIsAnswerError;
		}
		
		/**
		 * 没有空位置时返回-1
		 */
		private function get getEmptyIndex():int
		{
			var leng:int = _inputList.length;
			for ( var i:int = 0; i < leng; i++ )
			{
				if ( _inputList[ i ] == null )
					return i;
			}
			return -1;
		}
		
		private function inputOver():void
		{
			clear();
			dispatchEvent( new SpellEvent( SpellEvent.INPUT_OVER ));
		}
		
		private function displayInput():void
		{
			var letterVo:LetterBubbleVo;
			var length:int = _spellVo.charsLength;
			var str:String = "";
			for ( var i:int = 0; i < length; i++ )
			{
				letterVo = _inputList[i];
				if ( letterVo ) {
					str += letterVo.letter;
				} else {
					str += " _";
				}
			}
			txtEnglish.text = str;
		}
		

	}
}
