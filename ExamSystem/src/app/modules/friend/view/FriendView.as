package app.modules.friend.view
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
	import app.modules.ViewName;
	import app.modules.friend.model.FriendVo;
	
	import net.victoryang.components.scroll.ScrollPanel;
	import net.victoryang.events.ViewEvent;
	import net.victoryang.framework.BasePanel;
	import net.victoryang.func.removedAllChildren;
	
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-9-6
	 */
	public class FriendView extends BasePanel
	{
		/**
		 * 添加好友  按钮
		 */
		public var btnAddFriend:SimpleButton;
		/**
		 * 查询在线列表  按钮
		 */
		public var btnOnline:SimpleButton;
		/**
		 * container
		 */
		public var container:MovieClip;
		
		protected var gameScroll:ScrollPanel;
		
		protected var scrollHeight:int = 333;
		
		protected var dictItems:Dictionary = new Dictionary();
		
		public function FriendView()
		{
			super();
			isPenetrate = true;
		}
		
		override protected function beforeRender():void
		{
			super.beforeRender();
		}
		
		public function setData( list:Vector.<FriendVo> ):void
		{
			if ( gameScroll == null )
			{
				gameScroll = new ScrollPanel();
				gameScroll.setTargetAndHeight( container, scrollHeight, 264 );
			}
			if ( list )
			{
				removedAllChildren( container );
				var length:int = list.length;
				for ( var i:int = 0; i < length; i++ )
				{
					var item:FriendItem = getItem( i );
					item.setData( list[i] );
					container.addChild( item );
				}
			}
			gameScroll.updateMainHeight( container.height );
			gameScroll.setPos( 0 );
		}
		
		private function getItem( index:int ):FriendItem
		{
			var item:FriendItem = dictItems[ index ] as FriendItem;
			if ( item == null )
			{
				item = new FriendItem();
				item.y = 40 * index;
				dictItems[ index ] = item;
			}
			return item;
		}
		
		override protected function onceInit():void
		{
			super.onceInit();
			
			btnAddFriend.addEventListener(MouseEvent.CLICK, btnAddFriendHandler );
			btnOnline.addEventListener(MouseEvent.CLICK, btnOnlineHandler );
		}
		
		protected function btnAddFriendHandler(event:MouseEvent):void
		{
			dispatchEvent( new ViewEvent( ViewEvent.SHOW, ViewName.FriendAddView ));
		}
		
		protected function btnOnlineHandler(event:MouseEvent):void
		{
			dispatchEvent( new ViewEvent( ViewEvent.SHOW, ViewName.FriendOnline ));
		}
		
		override protected function get resNames():Array
		{
			return ["ui_friend"];
		}
		
		override protected function get skinName():String
		{
			return "ui_Skin_FriendMainView";
		}
		
	}
}