package app.modules.main.view
{
	
	import com.greensock.TweenLite;
	import com.greensock.easing.Back;
	
	import flash.events.MouseEvent;
	
	import app.modules.ViewName;
	import app.sound.SoundManager;
	import app.sound.SoundType;
	
	import net.victoryang.events.ViewEvent;
	import net.victoryang.framework.BaseSprite;
	import net.victoryang.func.apps;
	
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-10-18
	 */
	public class FightButtonMenu extends BaseSprite
	{
		
		public function FightButtonMenu()
		{
			super();
			setSkinWithName( "ui_Skin_FightButtonMenu" );
			
			x = 621;
			y = 460;
		}
		
		protected function onClickHandler(event:MouseEvent):void
		{
			var targetName:String = event.target.name;
			if ( isOpen( targetName ) ) {
				SoundManager.playEffectMusic( SoundType.CLICK01 );
				dispatchEvent( new ViewEvent( ViewEvent.SHOW, targetName, null, true ));
			}
			hide();
		}
		
		private function isOpen( targetName:String ):Boolean
		{
			return [ ViewName.FightFriendPanel, ViewName.FightSearchPanel, ViewName.FightMatchingPanel ].indexOf( targetName ) != -1;
		}
		
		private function openCompleted():void
		{
			apps.addEventListener(MouseEvent.MOUSE_DOWN, onClickHandler );
			TweenLite.killTweensOf( this );
			this.scaleX = 1;
			this.scaleY = 1;
			this.visible = true;
		}
		
		private function hideCompleted():void
		{
			apps.removeEventListener(MouseEvent.MOUSE_DOWN, onClickHandler );
			TweenLite.killTweensOf( this );
			this.scaleX = 0.01;
			this.scaleY = 0.01;
			this.visible = false;
		}
		
		public function show():void
		{
			hideCompleted();
			this.visible = true;
			TweenLite.to( this, 0.3, {scaleX:1, scaleY:1, onComplete:openCompleted, ease:Back.easeOut });
		}
		
		public function hide():void
		{
			openCompleted();
			TweenLite.to( this, 0.3, {scaleX:0.01, scaleY:0.01, onComplete:hideCompleted, ease:Back.easeIn });
		}
		
	}
}