package app.modules.fight.view.item
{
	import flash.geom.Point;
	
	import victor.core.AnimationClip;
	import victor.framework.core.BaseSprite;
	import victor.framework.core.ViewStruct;
	import victor.utils.removeAllChildren;
	import victor.utils.removedFromParent;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-10-30
	 */
	public class BubbleRemovedEffect extends BaseSprite
	{
		private var clip:AnimationClip;
		
		public function BubbleRemovedEffect( linkage:String, point:Point, loop:int = 1 )
		{
			x = point.x;
			y = point.y;
			
			this.mouseChildren = false;
			this.mouseEnabled = false;
			
			addChild( new AnimationClip( linkage, loop, loopComplete ) );
			ViewStruct.addChild( this, ViewStruct.EFFECT );
		}
		
		private function loopComplete():void
		{
			playComplete();
		}
		
		private function playComplete():void
		{
			removeAllChildren( this );
			removedFromParent( this );
		}
	}
}