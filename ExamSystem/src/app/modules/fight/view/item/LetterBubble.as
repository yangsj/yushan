package app.modules.fight.view.item
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import app.modules.fight.events.FightAloneEvent;
	import app.modules.fight.model.LetterBubbleVo;
	import app.modules.model.vo.ItemType;
	import app.sound.SoundManager;
	import app.sound.SoundType;
	
	import victor.framework.core.BaseSprite;
	import victor.framework.manager.TickManager;
	import victor.utils.MathUtil;
	import victor.utils.removedFromParent;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-28
	 */
	public class LetterBubble extends BaseSprite
	{
		/**
		 * 半径
		 */
		public static const RADIUS:int = 41;
		/**
		 * 直径
		 */
		public static const DIAMETER:int = 82;
		private static const LetterColor:Array = [0x00FFFF, 0xFFFF99, 0xFFCC99, 0xFFFFCC, 0x99FFCC];
		private static const itemPools:Vector.<LetterBubble> = new Vector.<LetterBubble>();
		
		private const moveArea:Rectangle = new Rectangle(RADIUS, RADIUS, 808, 298 );
		
		
		public var txtLetter:TextField;
		
		private var _data:LetterBubbleVo;
		private var _scale:Number = 1;
		private var _isAlone:Boolean = true;
		private var _bitmapLetter:Bitmap;
		private var _lastRandomNum:int = -1;
		private var _speedX:Number = 1;
		private var _speedY:Number = 1;
		
		private var _propSkinIcon:MovieClip;
		
		public static function get itemInstance():LetterBubble
		{
			if ( itemPools && itemPools.length > 0 )
				return itemPools.pop();
			return new LetterBubble();
		}
		
		public function LetterBubble()
		{
			super();
			setMoveArea();
			mouseChildren = false;
			buttonMode = true;
			setSkinWithName( "ui_Skin_FightItemBubble" );
			
			_propSkinIcon = getObj( "ui_Skin_PropIcon" ) as MovieClip;
			_propSkinIcon.width = DIAMETER;
			_propSkinIcon.height = DIAMETER;
			_propSkinIcon.stop();
			_propSkinIcon.visible = false;
			addChild( _propSkinIcon );
		}
		
		private function addListeners():void
		{
			if ( stage == null ) addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler );
			else addedToStageHandler( null );
			
			addEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler );
			addEventListener( MouseEvent.CLICK, mouseHandler );
		}
		
		protected function mouseHandler(event:MouseEvent):void
		{
			selected( true );
		}
		
		protected function enterFrameHandler(event:Event = null):void
		{
			x += _speedX;
			y += _speedY;
			
			if ( x <= moveArea.x || x >= moveArea.x + moveArea.width )
			{
				x = MathUtil.range( x, moveArea.x + 1, moveArea.x + moveArea.width - 1 );
				changeDirection( -1, 1 );
			}
			
			else if ( y <= moveArea.y || y >= moveArea.y + moveArea.height )
			{
				y = MathUtil.range( y, moveArea.y + 1, moveArea.y + moveArea.height - 1 );
				changeDirection( 1, -1 );
			}
		}
		
		protected function addedToStageHandler(event:Event):void
		{
			removeEventListener( Event.ADDED_TO_STAGE, addedToStageHandler );
			
			// 随机泡泡大小
			if ( _isAlone ) _scale = Number((0.8 + Math.random() * 0.25).toFixed(2));
			else _scale = Number((0.65 + Math.random() * 0.3).toFixed(2));
			
			_skin.scaleX = _skin.scaleY = _scale;
			_propSkinIcon.width = _propSkinIcon.height = _scale * DIAMETER;
			moveArea.x = RADIUS * scale;
			moveArea.y = RADIUS * scale;
			moveArea.width = moveArea.width - moveArea.x * 2;
			moveArea.height = moveArea.height - moveArea.y * 2;
			
			x = MathUtil.range( x, moveArea.x + 5, moveArea.x + moveArea.width - 5 );
			y = MathUtil.range( y, moveArea.x + 5, moveArea.y + moveArea.height- 5 );
			
			_speedX = Number((0.25 + Math.random() * 0.15).toFixed(2));
			_speedY = Number((0.25 + Math.random() * 0.15).toFixed(2));
			_speedX = Math.random() < 0.5 ? _speedX : -_speedX;
			_speedY = Math.random() < 0.5 ? _speedY : -_speedY;
			
			TickManager.doInterval( enterFrameHandler, 20 );
		}
		
		protected function removedFromStageHandler(event:Event):void
		{
			removeEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler );
			removeEventListener( MouseEvent.MOUSE_OVER, mouseHandler );
			removeEventListener( MouseEvent.CLICK, mouseHandler );
			TickManager.clearDoTime( enterFrameHandler );
			
			// 放入对象池 
			if ( itemPools ) itemPools.push( this );
		}
		
		public function setMoveArea( isAlone:Boolean = true ):void
		{
			if ( isAlone )
			{
				moveArea.width  = 785;
				moveArea.height = 480;
			}
			else
			{
				moveArea.width  = 430;
				moveArea.height = 400;
			}
			_isAlone = isAlone;
		}
		
		/**
		 * 改变运动方向
		 */
		public function changeDirection( direx:int = 0, direy:int = 0 ):void
		{
			if ( parent )
			{
				_speedX *= direx;
				_speedY *= direy;
				x += _speedX;
				y += _speedY;
			}
		}
		
		public function setData( vo:LetterBubbleVo ):void
		{
			addListeners();
			
			mouseEnabled = true;
			
			_data = vo;
			
			// 销毁字母图像
			if (_bitmapLetter) {
				_bitmapLetter.bitmapData.dispose();
				removedFromParent( _bitmapLetter );
			}
			
			var frame:int = 5 + vo.itemType;
			// 设置泡泡中的字母
			if ( vo.isLetter ){
				// 创建字母文献文本框
				if ( _lastRandomNum == -1 || txtLetter == null ) {
					_lastRandomNum = int( Math.random() * 5 );
					txtLetter = new TextField();
					txtLetter.defaultTextFormat = new TextFormat("微软雅黑", 50, LetterColor[_lastRandomNum],true,null,null,null,null,"center");
					txtLetter.width = 60;
					txtLetter.height = 70;
					txtLetter.visible = false;
					txtLetter.filters = null;
					
//					txtLetter.cacheAsBitmap = true;
//					txtLetter.x = -30;
//					txtLetter.y = -35;
//					_skin.addChild( txtLetter );
				}
				frame = _lastRandomNum + 1;
				txtLetter.text = vo.displayCase;
				// 将字母以位图渲染
				_bitmapLetter = new Bitmap( new BitmapData(60, 70, true, 0 ), "auto", true );
				_bitmapLetter.bitmapData.draw( txtLetter );
				_bitmapLetter.x = -30;
				_bitmapLetter.y = -35;
				_skin.addChild( _bitmapLetter );
			}
			else
			{
				_propSkinIcon.gotoAndStop( vo.itemType );
			}
			_skin.visible = vo.isLetter;
			_propSkinIcon.visible = !vo.isLetter;
			// 设置skin帧
			(_skin as MovieClip ).gotoAndStop( frame );
			_skin.cacheAsBitmap = true;
		}
		
		/**
		 * 选择
		 * @param value
		 * 
		 */
		public function selected( value:Boolean, isSelf:Boolean = true ):void
		{
			TickManager.clearDoTime( enterFrameHandler );
			if ( value ) {
				mouseEnabled = false;
				TickManager.clearDoTime( enterFrameHandler );
				if ( isSelf ) {
					dispatchEvent( new FightAloneEvent( FightAloneEvent.SELECTED_LETTER, this, true ));
				}
				
				if ( _data.itemType == ItemType.DEFAULT || isSelf == false ) {
					playRemovedEffect();
				}
				
				if ( isSelf ) {
					SoundManager.playEffectMusic( SoundType.BOMB );
				}
			}
		}
		
		public function playRemovedEffect( propType:int = 0 ):void
		{
			var linkage:String = "ui_Skin_BubbleRemoveEffect";
			var loop:int = 1;
			if ( propType > 0 )
			{
				switch ( propType )
				{
					case ItemType.BROOM:
						linkage = "ui_Skin_BroomPropEffect";
						loop = 3;
						break;
				}
			}
			new BubbleRemovedEffect( linkage, localToGlobal( new Point() ), loop );
			removedFromParent( this );
		}
		
		/**
		 * 提示
		 */
		public function hint():void
		{
			selected( true );
		}
		
		public function get data():LetterBubbleVo
		{
			return _data;
		}
		
		/**
		 * 对应的全局坐标
		 */
		public function get globalPoint():Point
		{
			return localToGlobal( new Point());
		}
		
		public function get isEdgeLeft():Boolean
		{
			return x < moveArea.x + RADIUS;
		}
		
		public function get isEdgeRight():Boolean
		{
			return x > moveArea.width - moveArea.x - RADIUS;
		}
		
		public function get isEdgeUp():Boolean
		{
			return y < moveArea.x + RADIUS;
		}
		
		public function get isEdgeDown():Boolean
		{
			return y > moveArea.height - moveArea.x - RADIUS;
		}

		public function get scale():Number
		{
			return _scale;
		}

		public function set scale(value:Number):void
		{
			_scale = value;
		}

		public function get direX():int
		{
			return _speedX < 0 ? -1 : 1;
		}

		public function get direY():int
		{
			return _speedY < 0 ? -1 : 1;
		}

		
	}
}