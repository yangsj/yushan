package victor.core.scroll
{

	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import victor.framework.interfaces.IDisposable;
	import victor.utils.MathUtil;
	import victor.utils.UtilsFilter;
	import victor.utils.apps;
	import victor.utils.removeAllChildren;

	/**
	 *  滚动条
	 * @author yangsj
	 */
	public class ScrollBar extends Sprite implements IDisposable
	{
		// 外型
		private var _skin:Sprite;
		private var _upBtn:SimpleButton;
		private var _downBtn:SimpleButton;
		private var _scrollMc:MovieClip;
		// 背景
		private var _listBack:Sprite;
		private var _barHeight:int;
		// 滚动区域的长度
		private var _scrollLen:int;
		private var _upPos:int;
		private var _cur:Number;
		private var _radio:Number;
		private var _emptyLen:int;
		private var _isMove:Boolean;
		private var _isOver:Boolean;
		private var _speed:int = 5;
		private var _curPos:Number;
		// 发生值更改
		public var onChange:Function;
		private var _isLock:Boolean;
		
		private var barSprite:Sprite;

		/**
		 * Construct a <code>FyBaseScrollBar</code>.
		 */
		public function ScrollBar( skin:Sprite )
		{
			_skin = skin;
			_upBtn = _skin.getChildByName( "_UpBtn" ) as SimpleButton;
			_downBtn = _skin.getChildByName( "_DownBtn" ) as SimpleButton;
			_scrollMc = _skin.getChildByName( "_ScrollBtn" ) as MovieClip;
			_listBack = _skin.getChildByName( "_back" ) as Sprite;
			_scrollMc.y = 0;
			_scrollMc.stop();
			_scrollMc.visible = false;
			addChild( _skin );
			
			_scrollMc.buttonMode = true;
			_skin.mouseEnabled = false;
		}

		public function init( value:int ):void
		{
			setBarHeight( value );
			addEvents();
		}

		public function setBarHeight( value:int ):void
		{
			_barHeight = value;
			_upBtn.y = 0;
			_downBtn.y = _barHeight - _downBtn.height;
			_upPos = _upBtn.height + 1;
			_scrollLen = _barHeight - 2 * _upPos;
			_listBack.y = _upPos - 3;
			_listBack.height = _scrollLen + 6;
			_scrollMc.y = _upPos;
			_scrollMc.height = _scrollLen;
			
			if ( !barSprite )
			{
				barSprite = new Sprite();
				barSprite.x = _scrollMc.x;
				barSprite.y = _scrollMc.y;
				barSprite.mouseChildren = false;
				barSprite.mouseEnabled = false;
			}
		}
		
		/**
		 * 滚动条大小
		 */
		public function set radio( value:Number ):void
		{
			_radio = value;
			if ( _radio > 1 )
			{
				_radio = 1;
			}
			else if ( _radio < 0.15 )
			{
				_radio = 0.15;
			}
			if ( _radio == 1 )
			{
				this.mouseEnabled = false;
				this.mouseChildren = false;
				lock();
			}
			else
			{
				unlock();
				update();
			}
		}

		private function lock():void
		{
			if ( _isLock )
			{
				return;
			}
			this.mouseEnabled = false;
			this.mouseChildren = false;
			_scrollMc.visible = false;
			_isLock = true;
			this.filters = [ UtilsFilter.COLOR_GREW ];
		}

		private function unlock():void
		{
			if ( !_isLock )
			{
				return;
			}
			this.mouseEnabled = true;
			this.mouseChildren = true;
			_scrollMc.visible = true;
			_isLock = false;
			this.filters = null;
		}

		/**
		 * 范围 0~1
		 */
		public function set pos( value:Number ):void
		{
			value = MathUtil.range( value, 0, 1 );
			setScrollMcPos( value );
			changeValue( value, false );
		}

		private function setScrollMcPos( value:Number ):void
		{
			var len:Number = _upPos + _emptyLen * value;
			_scrollMc.y = len;
		}

		private function update():void
		{
			var len:int = _radio * _scrollLen;
			if ( len < 10 )
			{
				len = 10;
				_radio = 10 / _scrollLen;
			}
			_scrollMc.height = len;
			_emptyLen = _scrollLen - len;
			_scrollMc.y = _upPos;
		}

		public function change( value:Number ):void
		{
			_cur = value;
		}

		private function scrollMove():void
		{
			if ( stage == null )
			{
				return;
			}
			var cPos:Number;
			if ( _emptyLen == 0 )
			{
				cPos = 0;
			}
			else
			{
				cPos = ( _scrollMc.y - _upPos ) / _emptyLen;
			}
			changeValue( cPos );
		}

		private function changeValue( value:Number, isDispatch:Boolean = true ):void
		{
			if ( _curPos == value )
			{
				return;
			}
			_curPos = value;
			if ( isDispatch && onChange != null )
			{
				onChange( _curPos );
			}
		}

		private function addEvents():void
		{
			_scrollMc.addEventListener( MouseEvent.MOUSE_DOWN, onScrollDown );
			_scrollMc.addEventListener( MouseEvent.MOUSE_OVER, onScrollOver );
			_scrollMc.addEventListener( MouseEvent.MOUSE_OUT, onScrollOut );
			_upBtn.addEventListener( MouseEvent.CLICK, this.onUpBtn );
			_downBtn.addEventListener( MouseEvent.CLICK, this.onDownBtn );
			_listBack.addEventListener( MouseEvent.CLICK, this.onBackHandler );
		}

		/**
		 * 点击滚动条 滚动
		 */
		private function onBackHandler( event:MouseEvent ):void
		{
			var mid:Number = _scrollMc.y + _scrollMc.height >> 1;
			var mouseX:Number = _listBack.mouseY;
			if ( mouseX > mid )
			{
				downMove();
			}
			else
			{
				upMove();
			}
		}

		private function onDownBtn( event:MouseEvent ):void
		{
			this.downMove();
		}

		public function downMove():void
		{
			var endPos:int = _emptyLen + _upPos;
			if ( _scrollMc.y + _speed > endPos )
			{
				_scrollMc.y = _emptyLen + _upPos;
			}
			else
			{
				_scrollMc.y += _speed;
			}
			scrollMove();
		}

		private function onUpBtn( event:MouseEvent ):void
		{
			upMove();
		}

		public function upMove():void
		{
			if ( _scrollMc.y - _speed < _upPos )
			{
				_scrollMc.y = _upPos;
			}
			else
			{
				_scrollMc.y = _scrollMc.y - _speed;
			}
			scrollMove();
		}

		private function removeEvents():void
		{
			if ( _scrollMc )
			{
				_scrollMc.removeEventListener( MouseEvent.MOUSE_DOWN, onScrollDown );
				_scrollMc.removeEventListener( MouseEvent.MOUSE_OVER, onScrollOver );
				_scrollMc.removeEventListener( MouseEvent.MOUSE_OUT, onScrollOut );
			}
			if ( _upBtn )
			{
				_upBtn.removeEventListener( MouseEvent.CLICK, this.onUpBtn );
				_downBtn.removeEventListener( MouseEvent.CLICK, this.onDownBtn );
				_listBack.removeEventListener( MouseEvent.CLICK, this.onBackHandler );
			}
		}

		private function onScrollDown( event:MouseEvent ):void
		{
			_scrollMc.gotoAndStop( 3 );
			
			apps.addEventListener( MouseEvent.MOUSE_UP, onScrollUp, false, 0, true );
			apps.addEventListener( MouseEvent.MOUSE_MOVE, onScrollMove, false, 0, true );
			
			_scrollMc.startDrag( false, new Rectangle( _scrollMc.x, _upPos, 0, _emptyLen ));
			_isMove = true;
			
			barSprite.x = _scrollMc.x;
			barSprite.y = _scrollMc.y;
			barSprite.startDrag( false, new Rectangle( _scrollMc.x, _upPos, 0, _emptyLen ));
		}

		private function onScrollMove( event:MouseEvent ):void
		{
			_scrollMc.x = barSprite.x;
			_scrollMc.y = barSprite.y;
			scrollMove();
		}

		private function onScrollUp( event:MouseEvent ):void
		{
			_scrollMc.gotoAndStop( 2 );
			scrollUpClear();
		}

		/**
		 * 停止拖动滚动
		 */
		private function scrollUpClear():void
		{
			if ( barSprite )
			{
				if ( barSprite.parent )
				{
					barSprite.parent.removeChild( barSprite );
				}
				barSprite.stopDrag();
			}
			this._scrollMc.stopDrag();
			
			apps.removeEventListener( MouseEvent.MOUSE_UP, this.onScrollUp );
			apps.removeEventListener( MouseEvent.MOUSE_MOVE, this.onScrollMove );
			_isMove = false;
			if ( _isOver )
			{
				_scrollMc.gotoAndStop( 2 );
			}
			else
			{
				_scrollMc.gotoAndStop( 1 );
			}
		}

		private function onScrollOut( event:MouseEvent ):void
		{
			if ( _isMove == false )
			{
				_scrollMc.gotoAndStop( 1 );
			}
			_isOver = false;
		}

		private function onScrollOver( event:MouseEvent ):void
		{
			if ( _isMove == false )
			{
				_scrollMc.gotoAndStop( 2 );
			}
			_isOver = true;
		}

		public function dispose():void
		{
			removeAllChildren( _skin );
			removeEvents();
			
			_upBtn = null;
			_downBtn = null;
			_scrollMc = null;
			_listBack = null;
			_skin = null;
			
			onChange = null;
		}

		public function setSpeed( value:int ):void
		{
			_speed = value;
		}

		public function goEnd():void
		{
			setScrollMcPos( 1 );
			changeValue( 1 );
		}

		public function goFirst():void
		{
			setScrollMcPos( 0 );
			changeValue( 0 );
		}

		public function get curPos():Number
		{
			return _curPos;
		}
	}
}
