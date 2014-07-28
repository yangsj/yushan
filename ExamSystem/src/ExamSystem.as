package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import app.AppContext;
	import app.GameConfig;
	
	import victoryang.func.apps;
	
	
	[SWF( width = "960", height = "560", frameRate = "60" )]
	/**
	 * ……
	 * @author 	victor 
	 * 			2014-6-29
	 */
	public class ExamSystem extends Sprite
	{
		
		
		public function ExamSystem()
		{
			if ( stage )
				initApp();
			else addEventListener( Event.ADDED_TO_STAGE, initApp );
		}
		
		private function initApp( event:Event = null ):void
		{
			removeEventListener( Event.ADDED_TO_STAGE, initApp );
			
			apps = stage;
			apps.align = StageAlign.TOP_LEFT;
			apps.scaleMode = StageScaleMode.NO_SCALE;
			apps.color = 0;
			
			// 初始化并启动应用
			new AppContext( this );
			
			//ui_Skin_YScrollBar
			this.graphics.beginBitmapFill(new ui_Skin_PreloaderBG());
			this.graphics.drawRect( 0, 0, GameConfig.stageWidth, GameConfig.stageHeight );
			this.graphics.endFill();
		}
		
		/*============================================================================*/
		/* private functions                                                          */
		/*============================================================================*/
		
		
		
		/*============================================================================*/
		/* events handlers                                                            */
		/*============================================================================*/
		
		
		
		/*============================================================================*/
		/* public functions                                                           */
		/*============================================================================*/
		
		
		
	}
}