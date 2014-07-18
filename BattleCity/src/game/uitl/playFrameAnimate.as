package game.uitl
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2014-7-17
	 */
	public function playFrameAnimate( clip:MovieClip, func:Function = null ):void
	{
		if ( clip )
		{
			clip.addEventListener( Event.ENTER_FRAME, enterFrameHandler );
			
			function enterFrameHandler( event:Event ):void
			{
				if ( clip.currentFrame == clip.totalFrames )
				{
					clip.removeEventListener( Event.ENTER_FRAME, enterFrameHandler );
					calls( func );
				}
			}
		}
	}
		
}