package victor.utils
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	/**
	 * ……
	 * @author 	yangsj
	 * 			2014-7-18
	 */
	public function removeAllChildren( target:DisplayObjectContainer, isChildren:Boolean = false ):void
	{
		if ( target )
		{
			if ( target.hasOwnProperty( "removeChildren" ))
			{
				target[ "removeChildren" ]();
			}
			else
			{
				while ( target.numChildren > 0 )
				{
					var dis:DisplayObject = target.removeChildAt( 0 );
					if ( isChildren && dis is DisplayObjectContainer )
					{
						removeAllChildren( dis as DisplayObjectContainer, isChildren );
					}
				}
			}
		}
	}


}
