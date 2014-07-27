package app.modules.fight.panel.search
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import app.modules.friend.model.FriendVo;
	
	import net.victoryang.framework.BaseSprite;
	import net.victoryang.func.removedFromParent;
	
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-10-18
	 */
	public class FightSearchItem extends BaseSprite
	{
		public var txtName:TextField;
		public var mcStatus:MovieClip; // 1:在线  2:闯关中 3:对战中
		public var mcBg:MovieClip;
		public var mcSelected:MovieClip;
		
		private var _selected:Boolean = false;
		private var _nameBitmap:Bitmap;
		private var _friendVo:FriendVo;
		
		public static var selectedItem:FightSearchItem;
		
		public function FightSearchItem()
		{
			super();
			setSkinWithName( "ui_Skin_FightFriendItem" );
			
			mouseChildren = false;
			buttonMode = true;
			selected = false;
			
			mcBg.alpha = 0;
			
			addEventListener( MouseEvent.MOUSE_OVER, mouseHandler );
			addEventListener( MouseEvent.MOUSE_OUT, mouseHandler );
			addEventListener( MouseEvent.CLICK, mouseHandler );
		}
		
		protected function mouseHandler(event:MouseEvent):void
		{
			var type:String = event.type;
			if ( _selected)
				return;
			if ( type == MouseEvent.MOUSE_OUT || type == MouseEvent.MOUSE_OVER )
			{
				mcSelected.gotoAndStop( 2 );
				mcSelected.visible = type == MouseEvent.MOUSE_OVER;
			}
			else if ( type == MouseEvent.CLICK )
			{
				if ( selectedItem )
					selectedItem.selected = false;
				selectedItem = this
				selected = true;
			}
		}
		
		public function setData( friendVo:FriendVo ):void
		{
			_friendVo =friendVo;
			removedFromParent( _nameBitmap );
			txtName.visible = false;
			txtName.text = _friendVo.name;
			_nameBitmap = new Bitmap( new BitmapData( txtName.width, txtName.height, true, 0 ));
			_nameBitmap.bitmapData.draw( txtName );
			_nameBitmap.x = txtName.x;
			_nameBitmap.y = txtName.y;
			_skin.addChild( _nameBitmap );
			
			setBg( friendVo.gender );
			setStatus( friendVo.status );
		}
		
		public function setBg( frame:int ):void
		{
			mcBg.gotoAndStop( frame%2 + 1 );
		}
		
		public function setStatus( status:int ):void
		{
			mcStatus.gotoAndStop( status );
		}

		/**
		 * 是否选择
		 */
		public function get selected():Boolean
		{
			return _selected;
		}

		/**
		 * @private
		 */
		public function set selected(value:Boolean):void
		{
			_selected = value;
			mcSelected.gotoAndStop( 1 );
			mcSelected.visible = value;
		}

		public function get friendVo():FriendVo
		{
			return _friendVo;
		}

		
	}
}