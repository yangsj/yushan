package app.modules.fight.view.item
{
	import flash.geom.Point;
	
	import net.victoryang.framework.BaseSprite;
	import net.victoryang.framework.ViewStruct;
	import net.victoryang.func.removedAllChildren;
	import net.victoryang.func.removedFromParent;
	
	import victor.core.AnimationClip;
	
	
	/**
	 * ……
	 * @author 	victor 
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
			removedAllChildren( this );
			removedFromParent( this );
		}
	}
}