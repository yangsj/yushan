package app.core
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import victoryang.interfaces.IDisposable;
	import victoryang.managers.TickManager;
	
	
	/**
	 * ……按指定的帧频播放MovieClip元件动画
	 * @author 	victor 
	 * 			2013-9-26
	 */
	public class FrameAnimation implements IDisposable
	{
		private var _movieClip:MovieClip;
		private var _frameRate:int = 24;
		private var _frameTime:int = 33;
		private var _autoPlay:Boolean = true;
		private var _isStop:Boolean = false;
		
		public function FrameAnimation( clip:MovieClip, frameRate:int = 24, autoPlay:Boolean = true )
		{
			this._movieClip = clip;
			this._frameRate = frameRate;
			this._frameTime = int( 1000 / frameRate );
			this._autoPlay = autoPlay;
			
			stop();
			
			this._movieClip.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler );
			this._movieClip.addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler );
			
			if ( this._movieClip.stage &&　_autoPlay　)
			{
				play();
			}
		}
		
		protected function addedToStageHandler(event:Event):void
		{
			if (_autoPlay)
			{
				play();
			}
		}
		
		protected function removedFromStageHandler(event:Event):void
		{
			stop();
		}
		
		private function gotoNextFrame():void
		{
			gotoFrame( _movieClip );
		}
		
		private function gotoFrame( targetClip:DisplayObjectContainer, isPlay:Boolean = true ):void
		{
			if ( targetClip )
			{
				var clip:MovieClip = targetClip as MovieClip;
				if ( clip )
				{
					if (isPlay )
					{
						if ( clip.currentFrame == clip.totalFrames )
							clip.gotoAndStop( 1 );
						else clip.nextFrame();
					}
					else clip.stop();
				}
				var leng:int = targetClip.numChildren;
				for ( var i:int = 0; i < leng; i++ )
				{
					gotoFrame( targetClip.getChildAt( i ) as DisplayObjectContainer, isPlay );
				}
			}
		}
		
		public function play():void
		{
			if ( _isStop )
			{
				_isStop = false;
				TickManager.instance.doInterval( gotoNextFrame, _frameTime );
			}
		}
		
		public function stop():void
		{
			if ( _isStop == false )
			{
				_isStop = true;
				gotoFrame( _movieClip, false );
				TickManager.instance.clearDoTime( gotoNextFrame );
			}
		}
		
		public function dispose():void
		{
			stop();
			if ( _movieClip )
			{
				_movieClip.removeEventListener( Event.ADDED_TO_STAGE, addedToStageHandler );
				_movieClip.removeEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler );
				_movieClip = null;
			}
		}
		
	}
}