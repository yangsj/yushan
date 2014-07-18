package app.modules.login.preloader
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Linear;
	
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.text.TextField;
	
	import app.Language;
	import app.core.Text;
	
	import victor.framework.debug.Debug;
	import victor.framework.interfaces.IDisposable;
	import victor.utils.BitmapUtil;
	import victor.utils.removeAllChildren;
	import victor.utils.removedFromParent;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-6
	 */
	public class PreloaderRollWordLine extends Sprite implements IDisposable
	{
		private var txtLine:TextField;
		private var maskShape:Shape;
		private var wordArray:Array;
		private var lastIndex:int;
		private var bitmapCon:Sprite;
		
		private const HEIGHT:Number = 26;
		
		public function PreloaderRollWordLine()
		{
			this.graphics.beginFill(0,0);
			this.graphics.drawRect( 0, 0, 500, HEIGHT);
			this.graphics.endFill();
			
			bitmapCon = new Sprite();
			addChild( bitmapCon );
			
			Debug.debug( " new PreloaderRollWordLine()************************" );
		}
		
		public function clear():void
		{
			TweenMax.killDelayedCallsTo( start );
			removeAllChildren( bitmapCon );
		}
		
		public function dispose():void
		{
			clear();
			this.mask = null;
			removeAllChildren( this );
			removedFromParent( maskShape );
		}
		
		public function initialize():void
		{
			removeAllChildren( bitmapCon );
			if ( txtLine == null )
			{
				txtLine = Text.getText( 16, 0x0066FF, "微软雅黑", 0, 0, 500, HEIGHT);
			}
			
			if ( maskShape == null || this.mask == null )
			{
				
				removedFromParent( maskShape );
				if ( maskShape == null )
				{
					maskShape = new Shape();
					maskShape.graphics.beginFill(0, 0);
					maskShape.graphics.drawRect( 0, 0, 500, HEIGHT);
					maskShape.graphics.endFill();
				}
				maskShape.x = x;
				maskShape.y = y;
				parent.addChild( maskShape );
				this.mask = maskShape;
			}
			Debug.debug( "initialize loading tips app_________________________" );
			wordArray ||= Language.PreloaderRollWordLine_0.split("|");
			if ( wordArray && wordArray.length > 0 )
			{
				start();
			}
		}
		
		private function start():void
		{	
			var index:int = lastIndex;
//			while ( index == lastIndex ) {
//				index = int(wordArray.length * Math.random());
//			}
//			lastIndex = index;
			var bitmap:Bitmap;
			txtLine.text = wordArray[ lastIndex ];
			bitmap = BitmapUtil.cloneBitmapFromTarget( txtLine );
			bitmap.y = HEIGHT;
			bitmap.alpha = 0;
			bitmapCon.addChild( bitmap );
			
			lastIndex++;
			if ( lastIndex == wordArray.length ) lastIndex = 0;
			
			const moveTime:Number = 0.4;
			const delayTime:Number = 2.4;
			
			TweenMax.to( bitmap, moveTime, { y:0, alpha:1, ease:Linear.easeNone });
			TweenMax.to( bitmap, moveTime, { 	
												y:-HEIGHT, 
												alpha:0, 
												delay:delayTime,
												ease:Linear.easeNone, 
												onComplete:removedFromParent, 
												onCompleteParams:[ bitmap ]
											});	
			TweenMax.delayedCall( delayTime, start );
		}
		
		/*
		和同学比赛提高得更快哦
		练习模式将记录你曾经出错过的单词
		是不是感觉越来越难了,努力提高自己吧
		玩过的关卡可以重复玩
		遇到困难请老师和同学帮忙吧
		学无止境,游戏中的提高也是如此
		*/
		
		
		
	}
}