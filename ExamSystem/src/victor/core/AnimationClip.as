package victor.core
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import victor.framework.interfaces.IDisposable;
	import victor.framework.manager.LoaderManager;
	import victor.framework.manager.TickManager;
	import victor.utils.calls;
	import victor.utils.removedFromParent;


	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-9-18
	 */
	public class AnimationClip extends Sprite implements IDisposable
	{
		private var _frameRate:int = 24;
		private var _frameList:Vector.<FrameVo>;
		private var _bitmap:Bitmap;
		private var _frameIndex:int;
		private var _totalFrames:int;
		private var _linkage:String;
		private var _loopNum:int = 0;
		private var _onComplete:Function;
		private var _isLoop:Boolean = true;
		private var _bitmapDataList:Vector.<BitmapData>;

		public function AnimationClip( linkage:String = "", loopNum:int = 0, onComplete:Function = null, frameRate:int = 24 )
		{
			mouseChildren = false;
			setLinkage( linkage, loopNum, onComplete, frameRate );
		}

		////////////////////////// public functions ///////////////////////////////

		public function dispose():void
		{
			stop();
			clear();
			_onComplete = null;
		}
		
		public function setBitmapDataList(value:Vector.<BitmapData>, frameRate:int = 24 ):void
		{
			_bitmapDataList = value;
			_frameRate = frameRate;
			_totalFrames = value.length;
			refreshFrameRate( frameRate );
		}

		public function setLinkage( linkage:String, loopNum:int = 0, onComplete:Function = null, frameRate:int = 24 ):void
		{
			_frameRate = frameRate;
			_loopNum = loopNum;
			_onComplete = onComplete;
			_isLoop = loopNum == 0;
			if ( linkage )
			{
				this.linkage = linkage;
				setClip( LoaderManager.getObj( linkage ) as MovieClip );
			}
		}

		public function setClip( clip:MovieClip ):void
		{
			if ( clip )
			{
				drawBitmap( clip );
				refreshFrameRate( _frameRate );
				start();
			}
		}

		public function refreshFrameRate( frameRate:int = 24 ):void
		{
			removedFromParent( _bitmap );
			_frameRate = frameRate;
			_bitmap = new Bitmap();
			addChild( _bitmap );
		}

		public function start():void
		{
			if ( _totalFrames > 1 )
			{
				TickManager.instance.clearDoTime( loop );
				TickManager.instance.doInterval( loop, 1000 / _frameRate );
			}
			else
			{
				loopComplete();
			}
			loop()
		}

		public function stop():void
		{
			TickManager.instance.clearDoTime( loop );
		}

		///////////////////// private fucntions ///////////////////

		private function drawBitmap( clip:MovieClip ):void
		{
			clear();

			var frameVo:FrameVo;
			var bmd:BitmapData;
			var rec:Rectangle;
			var matrix:Matrix = new Matrix();
			_frameIndex = 1;
			_totalFrames = clip.totalFrames;
			_frameList = new Vector.<FrameVo>( _totalFrames );
			for ( var i:int = 1; i <= _totalFrames; i++ )
			{
				clip.gotoAndStop( i );
				frameVo = new FrameVo();
				rec = clip.getBounds( clip );
				matrix.tx = -rec.x;
				matrix.ty = -rec.y;
				bmd = new BitmapData( rec.width, rec.height, true, 0 );
				bmd.draw( clip, matrix );
				frameVo.point = new Point( rec.x, rec.y );
				frameVo.bitmapData = bmd;
				_frameList[ i - 1 ] = frameVo;
			}
		}

		private function loop():void
		{
			if ( ( !_frameList && !_bitmapDataList ) || ( _frameList && _frameList.length == 0 ) || (_bitmapDataList && _bitmapDataList.length == 0 ) ) 
			{
				return ;
			}
			if ( _frameList )
			{
				var frameVo:FrameVo = _frameList[ _frameIndex % _totalFrames ];
				_bitmap.x = frameVo.x;
				_bitmap.y = frameVo.y;
				_bitmap.bitmapData = frameVo.bitmapData;
			}
			else if ( _bitmapDataList )
			{
				_bitmap.x = 0;
				_bitmap.y = 0;
				_bitmap.bitmapData = _bitmapDataList[ _frameIndex % _totalFrames ];
			}
			
			if ( _isLoop == false )
			{
				if ( _frameIndex % _totalFrames == 0 ) { _loopNum--; }
				if ( _loopNum == 0 ) loopComplete();
			}
			_frameIndex++;
		}
		
		private function loopComplete():void
		{
			calls( _onComplete, this );
			stop();
		}
		
		private function clear():void
		{
			if ( _frameList )
			{
				while ( _frameList.length > 0 )
				{
					var frameVo:FrameVo = _frameList.pop();
					if ( frameVo )
						frameVo.dispose();
					frameVo = null;
				}
				_frameList = null;
			}
			removedFromParent( _bitmap );
			_bitmap = null;
		}

		/////////////////////// getters/setters ///////////////
		
		public function get linkage():String
		{
			return _linkage;
		}
		
		public function set linkage(value:String):void
		{
			_linkage = value;
		}


	}
}
import flash.display.BitmapData;
import flash.geom.Point;

import victor.framework.interfaces.IDisposable;

class FrameVo implements IDisposable
{
	public var point:Point;
	public var bitmapData:BitmapData;

	public function get x():Number
	{
		return point.x;
	}

	public function get y():Number
	{
		return point.y;
	}

	public function dispose():void
	{
		if ( bitmapData )
			bitmapData.dispose();
		point = null;
		bitmapData = null;
	}
}

