package game.uitl 
{
	import flash.display.DisplayObject;

	/**
	 * ……
	 * @author 	yangsj
	 * 			2014-7-17
	 */
	public function removeFromParent( target:DisplayObject ):void
	{
		if ( target && target.parent )
			target.parent.removeChild( target );
	}

}
