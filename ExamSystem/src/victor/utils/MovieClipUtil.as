package victor.utils
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.Dictionary;

	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-6-28
	 */
	public class MovieClipUtil
	{
		private static const dict:Dictionary = new Dictionary();

		public static function playMovieClip( mc:MovieClip, completeCall:Function = null, completeCallParams:* = null ):void
		{
			if ( mc )
			{
				mc.addEventListener( Event.ENTER_FRAME, frameCompleteHandler );
				mc.gotoAndPlay( 1 );
				
				dict[mc] = {handler:frameCompleteHandler, func:completeCall, params:completeCallParams};
			}
			function frameCompleteHandler( event:Event ):void
			{
				if ( mc.currentFrame == mc.totalFrames )
				{
					mc.stop();
					mc.removeEventListener( Event.ENTER_FRAME, frameCompleteHandler );
					calls( completeCall, completeCallParams );
					dict[mc] = null;
					delete dict[ mc ];
				}
			}
		}
		
		public static function stopMovieClip( mc:MovieClip, completeCall:Function = null ):void
		{
			if ( mc )
			{
				var obj:Object = dict[ mc ];
				mc.stop();
				if ( obj )
				{
					mc.removeEventListener( Event.ENTER_FRAME, obj["handler"] );
				}
			}
		}

	}
}
