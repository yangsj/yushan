package game.uitl 
{
	import flash.display.DisplayObjectContainer;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2014-7-17
	 */
	public function removeAllChildren( target:DisplayObjectContainer ):void
	{
		while ( target && target.numChildren > 0 )
		{
			target.removeChildAt( 0 );
		}
	}
}