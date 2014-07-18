package game.skin
{
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import game.uitl.calls;
	
	
	/**
	 * 
	 * @author victor
	 * 			2014-6-30
	 */
	public class Background extends Sprite
	{
		private var uiView:UI_V_GameMainView;
		private var onBackFun:Function;
		private var onExitFun:Function;
		
		private var isStarting:Boolean = false;
		
		public function Background( onBackFun:Function, onExitFun:Function )
		{
			this.onBackFun = onBackFun;
			this.onExitFun = onExitFun;
			
			uiView = new UI_V_GameMainView();
			addChild( uiView );
			
			this.addEventListener( MouseEvent.CLICK, clickHandler );
			
			endGame();
		}
		
		protected function clickHandler( event:MouseEvent ):void
		{
			var target:InteractiveObject = event.target as InteractiveObject;
			if ( target == uiView.btnClose )
			{
				if ( isStarting )
				{
					calls( onBackFun );
				}
				else
				{
					calls( onExitFun );
				}
			}
		}
		
		public function destroy():void
		{
			this.removeEventListener( MouseEvent.CLICK, clickHandler );
			this.onBackFun = null;
			this.onExitFun = null;
		}
		
		public function endGame():void
		{
			isStarting = false;
			setInitStatus( false );
		}
		
		public function startGame():void
		{
			isStarting = true;
		}
		
		public function initData( level:int, totalScore:int ):void
		{
			uiView.mcLevel.gotoAndStop( level );
			setInitStatus( true );
			refreshScoreDisplay( totalScore );
		}
		
		public function refreshScoreDisplay( totalScore:int ):void
		{
			uiView.txtScore.text = totalScore.toString();
		}
		
		public function refreshEnemyNumDisplay( num:int ):void
		{
			num = Math.max( num, 0 );
			uiView.txtNeedScore.text = num.toString();
		}
		
		private function setInitStatus( enabled:Boolean ):void
		{
			uiView.mcLevel.visible = enabled;
			uiView.mcScoreWord.visible = enabled;
			uiView.mcNeedWord.visible = enabled;
			uiView.txtNeedScore.visible = enabled;
			uiView.txtScore.visible = enabled;
		}
		
		public function get effectContainer():Sprite
		{
			return uiView.effectCon;
		}
		
		public function get modelContainer():Sprite
		{
			return uiView.modelCon;
		}
		
		
	}
}