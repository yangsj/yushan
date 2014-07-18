package app.modules.fight.view
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Back;
	import com.greensock.easing.Linear;
	
	import flash.display.InteractiveObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.utils.Dictionary;
	
	import app.base.BaseLoadView;
	import app.core.ButtonSkin;
	import app.core.Tips;
	import app.data.GameData;
	import app.events.PackEvent;
	import app.modules.fight.events.FightAloneEvent;
	import app.modules.fight.model.LetterBubbleVo;
	import app.modules.fight.view.item.LetterBubble;
	import app.modules.fight.view.prop.PropList;
	import app.modules.fight.view.spell.SpellArea;
	import app.modules.model.vo.ItemType;
	import app.sound.SoundManager;
	import app.sound.SoundType;
	
	import victor.framework.core.ViewStruct;
	import victor.framework.manager.TickManager;
	import victor.utils.HtmlText;
	import victor.utils.MathUtil;
	import victor.utils.apps;
	import victor.utils.removeAllChildren;
	import victor.utils.removedFromParent;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-10-17
	 */
	public class FightBaseView extends BaseLoadView
	{
		public var txtRoundNum:TextField; // 显示关卡数
		public var txtName:TextField;// 所属地图名称
		public var txtTime:TextField; // 时间显示
		public var txtMoney:TextField; // 自己金钱数量显示
		public var container:Sprite; // 自己字母泡泡显示容器
		public var container2:Sprite;// 对手字母泡泡显示容器
		public var btnClose:InteractiveObject; // 退出【练习模式有】
		public var txtLeftWordsSelf:TextField;//自己剩余单词显示
		public var txtLeftWordsDest:TextField;//对手剩余单词显示
		public var btnShowAnswer:InteractiveObject;// 显示单词
		public var txtChinese:TextField;//中文显示
		public var txtEnglish:TextField;//英文显示
		public var selfBar:MovieClip;
		public var destBar:MovieClip;
		public var txtRightSelf:TextField;//自己剩余单词显示
		public var txtRightDest:TextField;//对手剩余单词显示
		
		public var isAlone:Boolean = true;
		public var mapId:int = 0;
		public var vecAddBubbleVo:Vector.<LetterBubbleVo>; // 记录增加干扰的泡泡
		
		private var _isValidOperate:Boolean = true;
		
		protected var spellArea:SpellArea;
		protected var propList:PropList;
		protected var effectContainer:Sprite;
		protected var dictLetterSelf:Dictionary;
		protected var selfCurrentTime:int = 120;
		protected var dictProps:Dictionary;
		protected var dictCheckItem:Dictionary;
		protected var points:Array = [];
		protected var totalTime:Number = 60;
		
		public function FightBaseView()
		{
			super();
		}
		
		override protected function onceInit():void
		{
			super.onceInit();
			
			spellArea = new SpellArea();
			addChild( spellArea );
			spellArea.txtChinese = txtChinese;
			spellArea.txtEnglish = txtEnglish;
			spellArea.btnShowAnswer = btnShowAnswer;
			spellArea.initSkin();
			
			propList = new PropList();
			addChild( propList );
			
			effectContainer = new Sprite();
			addChild( effectContainer );
			
			btnClose = ButtonSkin.buttonExit;
			addChild( btnClose );
			btnClose.visible = false;
			btnClose.addEventListener(MouseEvent.CLICK, onClickBtnCloseHandler );
			
			mouseEnabled = false;
			
			txtRightSelf ||= new TextField();
			txtRightDest ||= new TextField();
		}
		
		protected function onClickBtnCloseHandler(event:MouseEvent):void
		{
			SoundManager.playEffectMusic( SoundType.CLICK01 );
			dispatchEvent( new FightAloneEvent( FightAloneEvent.EXIT_PRACTICE ));
		}
		
		override public function hide():void
		{
			super.hide();
			clear();
		}
		
		override protected function addToParent():void
		{
			ViewStruct.addChild( this, ViewStruct.SCENE2 );
		}
		
		public function initialize( isPractice:Boolean = false ):void
		{
			totalTime = selfCurrentTime;
			isValidOperate = true;
			
			apps.addEventListener( KeyboardEvent.KEY_UP, keyDownHandler );
			apps.focus = apps;
			
			dictProps = new Dictionary();
			
			if ( txtTime )
				txtTime.visible = !isPractice;
			if ( !isPractice ) {
				timerHandler();
				TickManager.doInterval( timerHandler, 1000 );
			}
			TickManager.doInterval( enterFrameHandler, 20 );
		}
		
		public function clear():void
		{
			apps.removeEventListener( KeyboardEvent.KEY_UP, keyDownHandler );
			TickManager.clearDoTime( enterFrameHandler );
			TickManager.clearDoTime( timerHandler );
			spellArea.clear();
			propList.clear();
			clearDict( dictLetterSelf );
			clearDict( dictProps );
			clearDict( dictCheckItem );
		}
		
		public function setTxtLeftWordsSelf( num:String = "" ):void
		{
			txtLeftWordsSelf.text = num.toString();
		}
		
		public function setTxtLeftWordsDest( num:String = "" ):void
		{
			if (txtLeftWordsDest ) {
				txtLeftWordsDest.text = num.toString();
			}
		}
		
		public function removeConChilds():void
		{
			removeAllChildren( container );
			removeAllChildren( container2 );
		}
		
		public function playAddMoneyEffect( num:int, point:Point ):void
		{
			if ( num > 0 )
			{
				// 252 26  // 820 30
				var endx:Number = isAlone ? txtMoney.x + txtMoney.width * 0.5 : txtMoney.x - 25;
				var endy:Number = isAlone ? txtMoney.y - 25 : txtMoney.y + txtMoney.height* 0.5;
				var mc:MovieClip = getObj("ui_Skin_AddMoneyEffectNum")as MovieClip;
				mc.txtNum.text = "+" + num;
				mc.x = point.x;
				mc.y = point.y;
				mc.gotoAndStop( mapId + 1 );
				effectContainer.addChild( mc ); 
				TweenLite.to( mc, 0.4, { x:endx, y:endy, ease:Linear.easeNone });
				TweenLite.to( mc, 0.3, { scaleX:0.1, 
										scaleY:0.1, 
										onComplete:removedFromParent, 
										onCompleteParams:[mc], 
										delay:0.4,
										ease:Back.easeIn });
				
				txtMoney.text = (int( txtMoney.text ) + 1) + "";
			}
		}
		
		public function playAddPropEffect( bubble:LetterBubble, point:Point ):void
		{
			var pos:Point = bubble.localToGlobal( new Point());
			bubble.x = pos.x;
			bubble.y = pos.y;
			effectContainer.addChild( bubble );
			TweenLite.to( bubble, 0.4, { x:point.x, y:point.y, ease:Linear.easeNone });
			TweenLite.to( bubble, 0.3, { scaleX:0.1, 
										scaleY:0.1, 
										ease:Back.easeIn, 
										delay:0.4, 
										onComplete:removedFromParent, 
										onCompleteParams:[bubble] });
		}
		
		public function delPropItemFromDict( itemType:int ):void
		{
			delete dictProps[ itemType ];
			delete dictProps[ itemType + "_data" ];
		}
		
		public function addPropItem( lettetVo:LetterBubbleVo, isSelf:Boolean = true ):void
		{
			if ( lettetVo ) 
			{
				if ( isSelf ) dictProps[ lettetVo.itemType + "_data" ] = lettetVo;
				else dictProps[ lettetVo.itemType + "_other" ] = lettetVo;
			}
		}
		
		public function displayPropItem( isSelf:Boolean = true ):void
		{
			var bubble:LetterBubble;
			var lettetVo:LetterBubbleVo;
			var point:Array;
			for ( var key:String in dictProps )
			{
				var selfKey:Boolean = key.indexOf( "_data" ) != -1;
				var destKey:Boolean = key.indexOf( "_other" ) != -1;
				if ( selfKey || destKey )
				{
					lettetVo = dictProps[ key ];
					point = points.splice(int(Math.random() * points.length), 1)[0];
					bubble = LetterBubble.itemInstance;
					bubble.scaleX = 1;
					bubble.scaleY = 1;
					bubble.setMoveArea( isAlone );
					bubble.setData( lettetVo );
					bubble.x = point[0];
					bubble.y = point[1];
					
					if ( isSelf ) dictProps[ lettetVo.itemType ] = bubble;
					
					if ( isSelf && selfKey ) container.addChild( bubble );
					else if ( isSelf==false && destKey ) container2.addChild( bubble );
				}
			}
		}
		
		public function setLettersPool( list:Vector.<LetterBubbleVo>, isSelf:Boolean = true ):void
		{
		}
		
		public function delLetterFromDict( letter:String, isSelf:Boolean = true ):void
		{
		}
		
		public function setRoundName( roundName:String ):void
		{
		}
		
		public function setRoundNum( roundNumStr:String ):void
		{
			txtRoundNum.text = roundNumStr;
		}
		
		/**
		 * 输入字母
		 * @param key
		 * @param isKeyboard
		 */
		public function inputLetter( key:String, isKeyboard:Boolean = true ):void
		{
			key = key.toLowerCase();
			if ( dictLetterSelf && parent )
			{
				var bubble:LetterBubble;
				if ( isNaN( Number(key) )) {
					var ary:Array = dictLetterSelf[ key ];
					bubble = ary && ary.length > 0 ? ary[ 0 ] : null;
					
					if ( bubble ) bubble.selected( true );
					else if ( isKeyboard ) Tips.showCenter( "按键无效" );
				} else {
//					bubble = dictProps[ key ];
					propList.dispatchEvent( new PackEvent( PackEvent.USE_ITEM, key ));
				}
			}
		}
		
		public function setRightAnswerNum( num:int, isSelf:Boolean = true ):void
		{
			if ( isSelf ) txtRightSelf.text = num.toString();
			else txtRightDest.text = num.toString();
		}
		
		public function updateMoneyDisplay():void
		{
			txtMoney.text = GameData.instance.selfVo.money.toString();
		}
		
		/**
		 * 使用时间道具
		 */
		public function useExtraTimeProp( isSelf:Boolean = true ):void
		{
		}
		
		/**
		 * 使用跳过道具
		 * @param msg
		 * @param isSelf
		 */
		public function useSkinProp( msg:String, isSelf:Boolean = true ):void
		{
			if ( isAlone )
				Tips.showCenter( msg );
			else{
				var point:Point = getShowTipsPoint( false );
				Tips.show( msg, point.x, point.y );
			}
		}
		
		/**
		 * 使用 扫帚
		 */
		public function useBroomProp( isSelf:Boolean = true ):void
		{
			if ( vecAddBubbleVo && vecAddBubbleVo.length > 0 )
			{
				while ( vecAddBubbleVo.length > 0 )
				{
					var vo:LetterBubbleVo = vecAddBubbleVo.pop();
					var key:String = vo.lowerCase;
					if ( dictLetterSelf && parent )
					{
						var ary:Array = dictLetterSelf[ key ];
						var bubble:LetterBubble = ary && ary.length > 0 ? ary[ 0 ] : null;
						if ( bubble ) {
							bubble.playRemovedEffect( ItemType.BROOM );
						}
					}
					if ( isAlone )
						Tips.showCenter( "成功清除屏幕中的干扰泡泡" );
					else{
						var point:Point = getShowTipsPoint( false );
						Tips.show( "成功清除屏幕中的干扰泡泡", point.x, point.y );
					}
					dispatchEvent( new FightAloneEvent( FightAloneEvent.CLEAR_DISTURB_SELF ));
				}
			}
		}
		
		/**
		 * 提示
		 * @param key
		 * @param isSelf
		 */
		public function useHintProp( key:String, isSelf:Boolean = true ):void
		{
			if ( dictLetterSelf )
			{
				var ary:Array = dictLetterSelf[ key ];
				var bubble:LetterBubble = ary && ary.length > 0 ? ary[ 0 ] : null;
				if ( bubble ) bubble.hint();
			}
		}
		
		public function setOverStatusForText( msg:String ):void
		{
			if ( txtEnglish.text )
			{
				txtChinese.text = msg;
				txtEnglish.text = "";
			}
		}
		
		protected function getShowTipsPoint( isSelft:Boolean ):Point
		{
			var point:Point = new Point(container2.x + 207, container2.y + 207 + 80 );
			if ( isSelft ){
				point.x = container.x + 207;
			}
			if ( isAlone )
			{
				point.x = apps.stageWidth >> 1;
				point.y = apps.stageHeight * 0.7;
			}
			return point;
		}
		
		protected function setTimeText( text:TextField, seconds:int, mcBar:MovieClip ):void
		{
			text.htmlText = getTimeString( seconds );
			
			if ( mcBar ) {
				mcBar.bar.scaleX = MathUtil.range( seconds / totalTime, 0, 1 );
				if ( mcBar.rotation > 0 ) {
					text.x = MathUtil.range( mcBar.x - mcBar.bar.width, mcBar.x - mcBar.width, mcBar.x - text.width );
				} else {
					text.x = MathUtil.range( mcBar.x + mcBar.bar.width - text.width, mcBar.x, mcBar.x + mcBar.width - text.width );
				}
			}
			
			function getTimeString( seconds:int ):String
			{
				if ( seconds <= 0 ) return HtmlText.color( "00:00", 0xff0000 );
				var min:int = int(seconds/60);
				var sec:int = seconds%60;
				return HtmlText.color( (min < 10 ? "0" + min : min) + ":" + (sec < 10 ? "0" + sec : sec), seconds <= 10 ? 0xff0000 : 0xffffff );
			}
		}
		
		protected function clearDict( dict:Dictionary ):void
		{
			if ( dict ) {
				for ( var key:String in dict )
					delete dict[ key ];
			}
		}
		
		protected function timerHandler():void
		{
			selfCurrentTime--;
			setTimeText( txtTime, selfCurrentTime, selfBar );
			
			if ( selfCurrentTime <= 0 ) 
			{
				var msg:String = "时间到，请先等等对手吧";
				if ( isValidOperate ) {
					isValidOperate = false;
					if ( isAlone )
					{
						Tips.showCenter( msg, 28 );
					}
					else
					{
						var point:Point = getShowTipsPoint(true);
						Tips.show( msg, point.x, point.y, 28 );
					}
					setOverStatusForText( msg );
				}
			}
		}
		
		protected function keyDownHandler( event:KeyboardEvent ):void
		{
			if ( isValidOperate )
			{
				var charCode:int = event.charCode;
				var key:String = String.fromCharCode( charCode ).toLocaleLowerCase();
				if ( !(event.target is TextField) ) {
					inputLetter( key, true );
				}
			}
		}
		
		protected function enterFrameHandler( event:Event = null ):void
		{
		}
		
		protected function hitTestCheck( container:Sprite ):void
		{
			dictCheckItem ||= new Dictionary();
			clearDict( dictCheckItem );
			
			var mc1:LetterBubble, mc2:LetterBubble;
			for ( var i:int = 0; i < container.numChildren; i++ ) {
				mc1 = container.getChildAt( i ) as LetterBubble;
				if ( mc1 ) {
					for ( var j:int = 0; j < container.numChildren; j++ ) {
						mc2 = container.getChildAt( j ) as LetterBubble;
						if ( mc2 && mc1 != mc2 ) {
							
							var key1:String = mc1.name + mc2.name;
							var key2:String = mc2.name + mc1.name;
							if ( dictCheckItem[key1] || dictCheckItem[key2] ) continue;
							dictCheckItem[key1] = true;
							dictCheckItem[key2] = true;
							
							var dist0:Number = LetterBubble.RADIUS * ( mc1.scale + mc2.scale );
							var dist1:Number = MathUtil.distance( mc1.x, mc1.y, mc2.x, mc2.y) + 1;
							if ( dist1 <= dist0 ) {
								var rate:Number = ( dist0 / dist1 );
								var absx:Number = Math.abs( mc1.x - mc2.x );
								var absy:Number = Math.abs( mc1.y - mc2.y );
								var movex:Number = absx * rate;
								var movey:Number = absy * rate;
								var dx1:Number = mc1.direX;
								var dy1:Number = mc1.direY;
								var dx2:Number = mc2.direX;
								var dy2:Number = mc2.direY;
								
								// 校正泡泡的间距
								if ( dist1 < dist0 )
								{
									if ( mc1.x < mc2.x ) {
										if ( mc2.isEdgeRight )
											mc1.x = mc2.x - movex;
										else mc2.x = mc1.x + movex;
									} else {
										if ( mc2.isEdgeLeft )
											mc1.x = mc2.x + movex;
										else mc2.x = mc1.x - movex;
									}
									
									if ( mc1.y < mc2.y ) {
										if ( mc2.isEdgeDown )
											mc1.y = mc2.y - movey;
										else mc2.y = mc1.y + movey;
									} else {
										if ( mc2.isEdgeUp )
											mc1.y = mc2.y + movey;
										else mc2.y = mc1.y - movey;
									}
								}
								
								// 方式1：与原来方向相反
//								mc1.changeDirection( -1, -1 );
//								mc2.changeDirection( -1, -1 );
								
								// 方式2：可能改变一个方向，也可能改变两个方向
								if ( dx1 == dx2 ) {
									mc1.changeDirection( 1, -1 );
									mc2.changeDirection( 1, -1 );
								} else if ( dy1 == dy2 ) {
									mc1.changeDirection( -1, 1 );
									mc2.changeDirection( -1, 1 );
								} else　{
									if ( absx == absy )　{
										mc1.changeDirection( -1, -1 );
										mc2.changeDirection( -1, -1 );
									}　
									else　if ( absx > absy )　{
										mc1.changeDirection( -1, 1 );
										mc2.changeDirection( -1, 1 );
									}　else　{
										mc1.changeDirection( 1, -1 );
										mc2.changeDirection( 1, -1 );
									}
								}
							}
						}
					}
				}
			}
		}

		public function get isValidOperate():Boolean
		{
			return _isValidOperate;
		}

		public function set isValidOperate(value:Boolean):void
		{
			_isValidOperate = value;
			container.mouseChildren = value;
		}
		
		override protected function get resNames():Array
		{
			return [ "ui_fight", "ui_prop_list" ];
		}

	}
}