package app.modules.fight.panel.ready
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import app.modules.fight.model.FightMatchingVo;
	
	import net.victoryang.core.Reflection;
	import net.victoryang.interfaces.IDisposable;
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-10-19
	 */
	public class FightReadyItem implements IDisposable
	{
		/**
		 * btnReadyed
		 */
		public var btnReadyed:SimpleButton;
		/**
		 * btnReadying
		 */
		public var btnReadying:SimpleButton;
		/**
		 * mcSex
		 */
		public var mcSex:MovieClip;
		/**
		 * txtPlayer
		 */
		public var txtPlayer:TextField;
		/**
		 * txtGrade
		 */
		public var txtGrade:TextField;
		/**
		 * txtLevel
		 */
		public var txtLevel:TextField;
		/**
		 * mcBg
		 */
		public var mcBg:MovieClip;
		
		public function FightReadyItem( skin:Sprite )
		{
			Reflection.reflection( this, skin );
			refreshStatus( false );
			setSex( 0 );
			btnReadying.addEventListener(MouseEvent.CLICK, onBtnReadingHandler );
		}
		
		protected function onBtnReadingHandler(event:MouseEvent):void
		{
			btnReadying.dispatchEvent( new FightReadyEvent( FightReadyEvent.READY, null, true ));
			refreshStatus( true );
		}
		
		public function dispose():void
		{
//			btnReadying.removeEventListener(MouseEvent.CLICK, onBtnReadingHandler );
//			btnReadyed = null;
//			btnReadying = null;
//			mcSex = null;
//			txtPlayer = null;
//			txtGrade = null;
//			txtLevel = null;
//			mcBg = null;
		}
		
		public function refreshStatus( isOk:Boolean = true ):void
		{
			btnReadyed.visible = isOk;
			btnReadying.visible = !isOk;
		}
		
		public function setData( matchingVo:FightMatchingVo ):void
		{
			txtPlayer.text = matchingVo.name;
			txtGrade.text = matchingVo.grade;
			txtLevel.text = "Lv " + matchingVo.level;
			setSex( matchingVo.gender );
			refreshStatus( false );
		}
		
		private function setSex( gender:int ):void
		{
			mcBg.gotoAndStop( gender + 1 );
			mcSex.gotoAndStop( gender + 1 );
		}
		
	}
}