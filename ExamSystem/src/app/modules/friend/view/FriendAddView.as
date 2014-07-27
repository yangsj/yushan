package app.modules.friend.view
{
	import flash.display.SimpleButton;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	
	import app.modules.friend.event.FriendEvent;
	
	import net.victoryang.framework.BasePanel;
	
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-10-23
	 */
	public class FriendAddView extends BasePanel
	{
		public var txtInput:TextField;
		public var btnAdd:SimpleButton;
		
		public function FriendAddView()
		{
			super();
		}
		
		override protected function onceInit():void
		{
			super.onceInit();
			txtInput.text = "";
			btnAdd.addEventListener( MouseEvent.CLICK, btnAddHandler );
			txtInput.addEventListener(KeyboardEvent.KEY_DOWN, keyHandler );
			txtInput.wordWrap = false;
			txtInput.multiline = false;
		}
		
		protected function keyHandler(event:KeyboardEvent):void
		{
			if ( event.keyCode == Keyboard.ENTER ) {
				btnAddHandler( null );
			}
		}
		
		protected function btnAddHandler(event:MouseEvent):void
		{
			dispatchEvent( new FriendEvent( FriendEvent.ADD_FRIEND ));
		}
		
		override protected function get resNames():Array
		{
			return ["ui_friend"];
		}
		
		override protected function get skinName():String
		{
			return "ui_Skin_FriendAddView";
		}
	}
}