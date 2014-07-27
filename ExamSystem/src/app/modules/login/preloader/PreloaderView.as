package app.modules.login.preloader
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextField;
	
	import net.victoryang.components.Text;
	import net.victoryang.events.LoadEvent;
	import net.victoryang.framework.BaseScene;
	import net.victoryang.framework.ViewStruct;
	import net.victoryang.func.apps;
	import net.victoryang.func.removedFromParent;
	


	/**
	 * ……
	 * @author 	victor
	 * 			2013-8-28
	 */
	public class PreloaderView extends BaseScene
	{
		public var mcProgressBar:MovieClip;
		public var txtProgressValue:TextField;

		private var rollWord:PreloaderRollWordLine;
		private var stopFrame:int = 0;
		
		public function PreloaderView()
		{
			super();
		}

		override protected function onceInit():void
		{
			super.onceInit();

			txtProgressValue ||= Text.getText( 45, 0xffffff, "宋体" );
			addChild( txtProgressValue );
		}

		override public function dispose():void
		{
			super.dispose();

			if ( rollWord )
			{
				removedFromParent( rollWord );
				rollWord.dispose();
				rollWord = null;
			}
			mcProgressBar.removeEventListener( Event.ENTER_FRAME, barEnterFrameHandler );
		}

		override public function show():void
		{
			ViewStruct.addChild( this, ViewStruct.LOADING );
			mcProgressBar.gotoAndStop( 1 );
			if ( rollWord == null )
			{
				rollWord = new PreloaderRollWordLine();
				rollWord.x = ( apps.stageWidth - rollWord.width ) >> 1;
				rollWord.y = txtProgressValue.y + txtProgressValue.height + 10;
				addChild( rollWord );
			}
			else
			{
				rollWord.clear();
			}
			rollWord.initialize();
			mcProgressBar.addEventListener( Event.ENTER_FRAME, barEnterFrameHandler );
		}

		protected function barEnterFrameHandler( event:Event ):void
		{
			if ( mcProgressBar.currentFrame < stopFrame )
			{
				mcProgressBar.nextFrame();
				if ( mcProgressBar.currentFrame >= 100 )
				{
					txtProgressValue.text = mcProgressBar.currentFrame + ".00%";
				}
				else
				{
					txtProgressValue.text = ( mcProgressBar.currentFrame + Number( Math.random().toFixed( 2 ))) + "%";
				}
			}
			if ( mcProgressBar.currentFrame == mcProgressBar.totalFrames )
			{
				mcProgressBar.removeEventListener( Event.ENTER_FRAME, barEnterFrameHandler );
				dispatchEvent( new LoadEvent( LoadEvent.LOAD_COMPLETE, data ));
			}
		}

		public function setProgressValue( value:Number ):void
		{
			stopFrame = int( value * 100 );
		}

		override protected function get skinName():String
		{
			// 引用资源
			ui_Skin_Preloader;
			return "ui_Skin_Preloader";
		}

	}
}
