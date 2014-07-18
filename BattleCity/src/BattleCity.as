package
{
	import flash.display.Sprite;
	
	import game.GamePanel;
	import game.uitl.apps;
	
	[SWF(width="960", height="560")]
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2014-7-17
	 */
	public class BattleCity extends Sprite
	{
		
		
		public function BattleCity()
		{
			
			apps = stage;
			addChild( new GamePanel() );
		}
		
		
	}
}