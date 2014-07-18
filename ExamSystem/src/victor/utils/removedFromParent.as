package victor.utils
{
	import flash.display.DisplayObject;

	/**
	 * ……
	 * @author 	yangsj
	 * 			2014-7-18
	 */
	public function removedFromParent( target:DisplayObject ):DisplayObject
	{
		if ( target && target.parent )
		{
			return target.parent.removeChild( target );
		}
		return target;
	}
	
}
