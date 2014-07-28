package app.modules.fight.view.online
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.utils.Dictionary;
	
	import app.modules.fight.events.FightAloneEvent;
	import app.modules.fight.model.LetterBubbleVo;
	import app.modules.fight.view.FightBaseView;
	import app.modules.fight.view.item.LetterBubble;
	import app.modules.model.vo.ItemType;
	
	import victoryang.components.Tips;
	import victoryang.deubg.Debug;
	import victoryang.func.removedAllChildren;
	
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-9-27
	 */
	public class FightOnlineView extends FightBaseView
	{
		public var txtPlayer1:TextField; // 玩家自己的名字
		public var txtPlayer2:TextField; // 玩家对手的名字
		public var txtTime2:TextField; // 时间显示
		
		private var dictLetterOther:Dictionary;
		private var destCurrentTime:int = 120;
		
		public var vecAddBubbleVoForOther:Vector.<LetterBubbleVo>; // 记录增加干扰的泡泡
		
		public function FightOnlineView()
		{
			super();
		}
		
		override protected function onceInit():void
		{
			super.onceInit();
			container2.mouseChildren = false;
			container2.mouseEnabled = false;
		}
		
		override public function initialize( isPractice:Boolean = false ):void
		{
			selfCurrentTime = 120;
			destCurrentTime = 120;
			super.initialize( isPractice );
		}
		
		override public function clear():void
		{
			super.clear();
			Debug.debug( "FightOnlineView.clear()" );
			clearDict( dictLetterOther );
		}
		
		public function answerResult( isWin:Boolean, isSelf:Boolean ):void
		{
			var msg:String = isWin ? "时间 +3 秒" : "时间 -10 秒";
			var time:int = isWin ? 3 : -10;
			var point:Point = getShowTipsPoint( isSelf );
			
			Debug.debug( isSelf, time, selfCurrentTime, destCurrentTime );
			
			if ( isSelf ) selfCurrentTime += time;
			else destCurrentTime += time;
			
			Debug.debug( isSelf, time, selfCurrentTime, destCurrentTime );
			
			Tips.show( msg, point.x, point.y, 25 );
		}
		
		/**
		 * 删除对手屏幕泡泡
		 * @param id
		 * @return 
		 */
		public function delBubbleByIdForOther( id:int ):LetterBubble
		{
			Debug.debug( "xiaochu bubble_id:" + id  );
			var letter:LetterBubble;
			for ( var i:int = 0; i < container2.numChildren; i++ )
			{
				letter = container2.getChildAt( i ) as LetterBubble;
				if ( letter && letter.data.id == id )
				{
					Debug.debug( "对手消除泡泡：" + letter.data.upperCase + "|" + letter.data.id );
					letter.selected( true, false );
					var itemType:int = letter.data.itemType;
					if ( itemType != ItemType.DEFAULT ) delete dictProps[itemType+"_other"];
					break;
				}
			}
			return letter;
		}
		
		override public function delLetterFromDict( letter:String, isSelf:Boolean = true ):void
		{
			if ( isSelf == false )
				return ;
			
			var key:String = letter.toLocaleLowerCase();
			var dict:Dictionary = isSelf ? dictLetterSelf : dictLetterOther;
			var ary:Array = dict[ key ];
			if ( ary && ary.length > 0 )
			{
				ary.shift();
				dict[ key ] = ary;
			}
			else
			{
				delete dict[ key ];
			}
		}
		
		override public function setLettersPool( list1:Vector.<LetterBubbleVo>, isSelf:Boolean = true ):void
		{
			setPool( list1, isSelf ? container : container2, isSelf );
		}
		
		private function setPool( list:Vector.<LetterBubbleVo>, con:Sprite, isSelf:Boolean = true ):void
		{
			points = [[40.25, 44.5],[110.15, 44.5],[180.05, 44.5],[249.95, 44.5],[319.85, 44.5],[389.75, 44.5],[54, 106.7],[118.4, 106.7],[182.8, 106.7],[247.25, 106.7],[311.6, 106.7],[376, 106.7],[40.25, 168.9],[103.65, 168.9],[167.05, 168.9],[230.45, 168.9],[293.85, 168.9],[357.25, 168.9],[72.75, 231.1],[136.15, 231.1],[199.55, 231.1],[262.95, 231.1],[326.35, 231.1],[389.75, 231.1],[56.5, 355.5],[119.9, 355.5],[183.3, 355.5],[246.7, 355.5],[310.1, 355.5],[373.5, 355.5],[40.25, 293.3],[110.15, 293.3],[180.05, 293.3],[249.95, 293.3],[319.85, 293.3],[389.75, 293.3]];
			var dict:Dictionary = new Dictionary();
			removedAllChildren( con, false );
			var key:String;
			var bubble:LetterBubble;
			var point:Array;
			for each ( var vo:LetterBubbleVo in list )
			{
				point = points.splice(int(Math.random() * points.length), 1)[0];
				key = vo.letter.toLocaleLowerCase();
				bubble = LetterBubble.itemInstance;
				bubble.scaleX = 1;
				bubble.scaleY = 1;
				bubble.setMoveArea( isAlone );
				bubble.setData( vo );
				bubble.x = point[0];
				bubble.y = point[1];
				con.addChild( bubble );
				dict[ key ] ||= [];
				dict[ key ].push( bubble );
				Debug.debug( (isSelf ? "自己屏幕：" : "对手屏幕：") + key );
			}
			if ( isSelf ) dictLetterSelf = dict;
			else dictLetterOther = dict;
		}
		
		override protected function timerHandler():void
		{
			destCurrentTime--;
			setTimeText( txtTime2, destCurrentTime, destBar );
			
			super.timerHandler();
		}
		
		/**
		 * 使用时间道具
		 */
		override public function useExtraTimeProp( isSelf:Boolean = true ):void
		{
			var point:Point = getShowTipsPoint( isSelf );
			if ( isSelf ) {
				selfCurrentTime += 8;
			} else {
				destCurrentTime += 8;
			}
			Tips.show( "时间 +8s", point.x, point.y );
		}
		
		/**
		* 使用 扫帚
		*/
		override public function useBroomProp( isSelf:Boolean = true ):void
		{
			if ( isSelf ) {
				super.useBroomProp();
			}
			else if ( vecAddBubbleVoForOther && vecAddBubbleVoForOther.length > 0 )
			{
				var vo:LetterBubbleVo = vecAddBubbleVoForOther.pop();
				var key:String = vo.lowerCase;
				if ( dictLetterOther && parent )
				{
					var ary:Array = dictLetterOther[ key ];
					var bubble:LetterBubble = ary && ary.length > 0 ? ary[ 0 ] : null;
					if ( bubble ) {
						bubble.playRemovedEffect( vo.itemType );
					}
				}
				var point:Point = getShowTipsPoint( false );
				Tips.show( "对手成功清除屏幕中的一个干扰泡泡", point.x, point.y );
				dispatchEvent( new FightAloneEvent( FightAloneEvent.CLEAR_DISTURB_DEST ));
			}
		}
		
		public function setPlayerName( playerName1:String, playerName2:String ):void
		{
			txtPlayer1.text = playerName1;
			txtPlayer2.text = playerName2;
		}
		
		override protected function enterFrameHandler( event:Event = null ):void
		{
			hitTestCheck( container );
			hitTestCheck( container2 );
		}
		
		override protected function get skinName():String
		{
			return "ui_Skin_FightOnlineView";
		}
	}
}