package app.modules.fight.panel.search
{
	import com.greensock.TweenLite;
	
	import flash.events.Event;
	import flash.text.TextField;
	
	import app.modules.friend.model.FriendVo;
	
	import net.victoryang.uitl.StringUitl;
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-10-17
	 */
	public class FightSearchPanel extends FightSearchBasePanel
	{
		public var txtSearch:TextField;
		
		private var vecList:Vector.<FriendVo>;
		
		public function FightSearchPanel()
		{
			super();
		}
		
		public function setData(list:Vector.<FriendVo>):void
		{
			vecList = list;
			setDataList( list );
		}
		
		protected function textInputHandler(event:Event):void
		{
			TweenLite.killDelayedCallsTo( searchMatching );
			TweenLite.delayedCall(0.1, searchMatching );
		}
		
		private function searchMatching():void
		{
			var input:String = txtSearch.text;
			var vec:Vector.<FriendVo>;
			if ( StringUitl.isEmpty( input ) == true )
				vec = vecList;
			else {
				vec = new Vector.<FriendVo>();
				for each ( var vo:FriendVo in vecList ) {
					if ( vo && vo.name.substr( 0, input.length ) == input ) {
						vec.push( vo );
					}
				}
			}
			setDataList( vec );
		}
		
		override protected function onceInit():void
		{
			super.onceInit();
			txtSearch.addEventListener(Event.CHANGE, textInputHandler );
			
			txtSearch.wordWrap = false;
			txtSearch.multiline = false;
		}
		
		override protected function beforeRender():void
		{
			super.beforeRender();
			createScroll( 264, 290 );
		}
		
		override protected function get skinName():String
		{
			return "ui_Skin_FightSearchPanel";
		}
		
	}
}