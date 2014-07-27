package app.modules.friend.view
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	
	import app.core.Alert;
	import app.modules.friend.event.FriendEvent;
	import app.modules.friend.model.FriendVo;
	
	import net.victoryang.framework.BaseSprite;
	import net.victoryang.func.apps;
	import net.victoryang.func.removedFromParent;
	
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-10-23
	 */
	public class FriendItem extends BaseSprite
	{
		/**
		 * mcSelected
		 */
		public var mcSelected:MovieClip;
		/**
		 * 玩家状态：1帧在线|2帧闯关|3帧对战中|4帧离线
		 */
		public var mcStatus:MovieClip;
		/**
		 * 玩家名称
		 */
		public var txtName:TextField;
		public var txtLevel:TextField;
		
		private var _data:FriendVo;
		private var _selected:Boolean;
		
		private var _tips1:MovieClip;
		private var _tips2:MovieClip;
		private var _isClick:Boolean = false;
		
		// 聊天
		private const Chat:String = "btnChat";
		// 对战
		private const Battle:String = "btnBattle";
		// 删除
		private const Delete:String = "btnDel";
		
		private static var selectedItem:FriendItem;
		
		public function FriendItem()
		{
			setSkinWithName( "ui_Skin_FriendItem" );
			addEventListener( MouseEvent.MOUSE_OVER, mouseHandler );
			addEventListener( MouseEvent.MOUSE_OUT, mouseHandler );
			addEventListener( MouseEvent.CLICK, mouseHandler );
			mouseChildren = false;
			buttonMode = true;
			mcStatus.stop();
			selected = false;
			
			_tips1 = getObj( "ui_Skin_FriendItemSuspendTips" ) as MovieClip;
			_tips1.addEventListener(MouseEvent.MOUSE_OVER, mouseTipsHandler );
			_tips1.addEventListener(MouseEvent.MOUSE_OUT, mouseTipsHandler );
			_tips1.addEventListener(MouseEvent.CLICK, mouseTips1ClickHandler );
			_tips1.name = "addTips1";
			
//			_tips2 = getObj( "ui_Skin_FriendItemClickTips" ) as MovieClip;
//			_tips2.addEventListener(MouseEvent.MOUSE_OVER, mouseTipsHandler );
//			_tips2.addEventListener(MouseEvent.MOUSE_OUT, mouseTipsHandler );
//			_tips2.name = "addTips2";
//			_tips2.mcBg.stop();
			
			_tips2 = _tips1;
		}
		
		protected function mouseTipsHandler(event:MouseEvent):void
		{
			var currentTarget:DisplayObject = event.currentTarget as DisplayObject;
			if ( event.type == MouseEvent.MOUSE_OVER )
				this[currentTarget.name]();
			else
			{
				removedFromParent( currentTarget );
				selected = false;
			}
		}
		
		protected function mouseTips1ClickHandler(event:MouseEvent):void
		{
			var targetName:String = event.target.name;
			switch ( targetName )
			{
				case Chat:
					dispatchEvent( new FriendEvent( FriendEvent.CHAT, data, true ));
					break;
				case Battle:
					dispatchEvent( new FriendEvent( FriendEvent.BATTLE, data, true ));
					break;
				case Delete:
//					dispatchEvent( new FriendEvent( FriendEvent.DELETE, data, true ));
					Alert.show( "你确定要删除好友【" + data.name + "】吗？", 
						function abc(type:int):void {
							dispatchEvent( new FriendEvent( FriendEvent.DELETE, data, type==Alert.YES ));
						});
					break;
			}
		}
		
		protected function mouseHandler(event:MouseEvent):void
		{
			var type:String = event.type;
			if ( type == MouseEvent.CLICK )
			{
				_isClick = true;
				selected = true;
				addTips1();
			}
			if ( type == MouseEvent.MOUSE_OVER )
			{
				mcSelected.visible = true;
				if ( _isClick )
					addTips1();
				else addTips2();
				_isClick = false;
			}
			else if ( type == MouseEvent.MOUSE_OUT )
			{
				mcSelected.visible = false;
				removedFromParent( _tips1 );
				removedFromParent( _tips2 );
			}
		}
		
		private function addTips1():void
		{
			selected = true;
			removedFromParent( _tips2 );
			if ( _tips1.parent == null )
			{
				var point:Point = this.localToGlobal( new Point());
				if ( point.x - _tips1.width < 0 )
					_tips1.x = point.x + width - 15;
				else _tips1.x = point.x - _tips1.width + 2;
				
				_tips1.y = point.y - 5;
				if ( point.y + _tips1.height > apps.stageHeight )
					_tips1.y = apps.stageHeight - _tips1.height - 5;
				
				apps.addChild( _tips1 );
			}
		}
		
		private function addTips2():void
		{
			selected = true;
			removedFromParent( _tips1 );
			if ( _tips2.parent == null )
			{
				var point:Point = this.localToGlobal( new Point());
				if ( point.x - _tips2.width < 0 )
					_tips2.x = point.x + width - 15;
				else _tips2.x = point.x - _tips2.width + 2;
				
				_tips2.y = point.y - 5;
				if ( point.y + _tips2.height > apps.stageHeight )
					_tips2.y = apps.stageHeight - _tips2.height - 30;
				
				apps.addChild( _tips2 );
			}
		}
		
		public function setData( data:FriendVo ):void
		{
			_data = data;
			
			mcStatus.gotoAndStop( data.status );
			
			txtName.text = data.name;
			txtLevel.text = "Lv " + data.level;
			
//			_tips2.txtName.text = "" + data.name;
//			_tips2.txtGrade.text = "" + data.grade;
//			_tips2.txtLevel.text = "Lv " + data.level;
//			_tips2.mcBg.gotoAndStop( data.gender + 1 );
		}

		public function get data():FriendVo
		{
			return _data ||= new FriendVo();
		}

		public function set data(value:FriendVo):void
		{
			_data = value;
		}

		public function get selected():Boolean
		{
			return _selected;
		}

		public function set selected(value:Boolean):void
		{
			_selected = value;
			mcSelected.visible = value;
			if ( selectedItem != this )
			{
				_isClick = false;
				if ( value )
				{
					if ( selectedItem )
						selectedItem.selected = false;
					selectedItem = this;
				}
			}
		}

		
	}
}