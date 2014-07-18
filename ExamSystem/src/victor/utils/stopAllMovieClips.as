package victor.utils
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;

	/**
	 * ……
	 * @author 	yangsj
	 * 			2014-7-18
	 */
	public function stopAllMovieClips( target:DisplayObjectContainer ):void
	{
		if ( target )
		{
			if ( target.hasOwnProperty( "stopAllMovieClips" ))
			{
				target[ "stopAllMovieClips" ]();
			}
			else
			{
				var numChildren:int = target.numChildren;
				var clip:MovieClip = target as MovieClip;
				var dis:DisplayObjectContainer;
				var i:int = 0;

				if ( clip )
					clip.stop();

				for ( i = 0; i < numChildren; i++ )
				{
					dis = target.getChildAt( i ) as DisplayObjectContainer;
					if ( dis )
						stopAllMovieClips( dis );
				}

			}
		}
	}


}
