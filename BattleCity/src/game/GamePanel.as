package game
{
	import flash.display.Sprite;
	
	import game.skin.Background;
	import game.skin.PassAllRound;
	import game.skin.PassRound;
	import game.skin.Ready321;
	import game.skin.StartPanel;
	import game.uitl.removeFromParent;
	
	/**
	 * 
	 * @author victor
	 * 			2014-7-3
	 */
	public class GamePanel extends Sprite
	{
		private var backGround:Background;
		private var startPanel:StartPanel;
		private var gameController:LogicController;
		
		public function GamePanel()
		{
			super(); 
			
			init();
		}
		
		protected function init():void
		{
			startPanel 		= new StartPanel( onPreStartFunc );
			backGround 		= new Background( onBackToStart, hide );
			gameController 	= new LogicController( 	backGround.effectContainer, 
				backGround.modelContainer, 
				onBackToStart, 
				passLevel, 
				backGround.refreshScoreDisplay, 
				backGround.refreshEnemyNumDisplay );
			
			addChild( backGround );
			addChild( startPanel );
		}
		
		protected function passLevel():void
		{
		}
		
		protected function getResult():void
		{
			if( false )
			{
				addChild( new PassAllRound( 0, 0, hide ) );
			}
			else
			{
				addChild( new PassRound( "", onPreStartFunc ) );
			}
		}
		
		private function onBackToStart():void
		{
			startPanel.show();
			backGround.endGame();
			gameController.clear();
		}
		
		private function onPreStartFunc():void
		{
			backGround.initData( 1, 0 );
			gameController.setData( 1 );
			startPanel.hide();
			onPlayReadyGo();
		}
		
		private function onPlayReadyGo():void
		{
			addChild( new Ready321( onStartGame ));
		}
		
		private function onStartGame():void
		{
			backGround.startGame();
			gameController.startGame();
		}
		
		public function hide():void
		{
			removeFromParent(this);
		}
		
		public function destroy():void
		{
			if ( startPanel )
			{
				startPanel.destroy();
				startPanel = null;
			}
			if ( backGround )
			{
				backGround.destroy();
				backGround = null;
			}
		}
	}
}