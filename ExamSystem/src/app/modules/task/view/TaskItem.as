package app.modules.task.view
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import app.modules.task.event.TaskEvent;
	import app.modules.task.model.TaskVo;
	
	import victoryang.components.Text;
	import victoryang.components.Tips;
	import victoryang.framework.BaseSprite;
	import victoryang.func.removedFromParent;
	
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-11-5
	 */
	public class TaskItem extends BaseSprite
	{
		/*============================================================================*/
		/* private variables                                                          */
		/*============================================================================*/
		
		public var txtDes:TextField;
		/**
		 * 1帧为常态|2为正在进行|3已完成
		 */
		public var bgStatus:MovieClip;
		
		private var bitmapCon:Sprite;
		private var bitmapDes:Bitmap;
		private var bitmapMask:Shape;
		private var time:Number = 0;
		private var endMoveX:Number = 0;
		private var txtWidth:Number = 0;
		
		private var _data:TaskVo;
		
		// 创建对象池
		private static const vecPools:Vector.<TaskItem> = new Vector.<TaskItem>();
		public static function get itemInstance():TaskItem
		{
			if ( vecPools && vecPools.length > 0 )
				return vecPools.shift();
			return new TaskItem();
		}
		
		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/
		public function TaskItem()
		{
			setSkinWithName( "ui_Skin_TaskItem" );
			txtDes = Text.cloneText( txtDes );
			txtDes.visible = false;
			txtDes.mouseEnabled = false;
			
			txtWidth = txtDes.width;
			
			bitmapCon = new Sprite();
			bitmapCon.mouseEnabled = false;
			bitmapCon.mouseEnabled = false;
			_skin.addChild( bitmapCon );

			bitmapMask = new Shape();
			bitmapMask.graphics.beginFill( 0 );
			bitmapMask.graphics.drawRect( txtDes.x - 4, 0, txtDes.width, height );
			bitmapMask.graphics.endFill();
			bitmapCon.mask = bitmapMask;
			_skin.addChild( bitmapMask );
		}
		
		/*============================================================================*/
		/* private functions                                                          */
		/*============================================================================*/
		
		private function addListeners():void
		{
			addEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler );
			addEventListener( MouseEvent.CLICK, onClickHandler );
			addEventListener( MouseEvent.ROLL_OVER, rollMouseHandler );
			addEventListener( MouseEvent.ROLL_OUT , rollMouseHandler );
		}
		
		private function removeListeners():void
		{
			removeEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler );
			removeEventListener( MouseEvent.CLICK, onClickHandler );
			removeEventListener( MouseEvent.ROLL_OVER, rollMouseHandler );
			removeEventListener( MouseEvent.ROLL_OUT , rollMouseHandler );
		}
		
		private function startMoveDes( isLoop:Boolean = false ):void
		{
			if ( time > 0 )
			{
				if ( bitmapDes ) {
					var endx:Number = bitmapDes.x == txtDes.x ? endMoveX : txtDes.x;
					TweenLite.to( bitmapDes, time, {
														x:endx, 
														ease:Linear.easeNone, 
														onComplete:startMoveDes, 
														onCompleteParams:[ true ], 
														delay: isLoop ? 1 : 0 
													});
				}
			}
		}
		
		private function stopMoveDes():void
		{
			if ( bitmapDes ) {
				bitmapDes.x = txtDes.x;
				TweenLite.killTweensOf( bitmapDes );
			}
		}
		
		/*============================================================================*/
		/* events handlers                                                            */
		/*============================================================================*/
		
		protected function removedFromStageHandler(event:Event):void
		{
			stopMoveDes();
			removeListeners();
			if ( vecPools ) {
				vecPools.push( this );
			}
		}
		
		protected function onClickHandler(event:MouseEvent):void
		{
			if ( data.isEd ) {
//				dispatchEvent( new ViewEvent( ViewEvent.SHOW_VIEW, ViewName.TaskCompleted, data, true ));
				dispatchEvent( new TaskEvent( TaskEvent.OPEN_REWARD, data, true ));
			} else if ( data.isIng ) {
				Tips.showMouse( "该任务还未完成，不能领取奖励！！！" );
			} else {
				Tips.showMouse( "该任务奖励奖励已领取" );
			}
		}
		
		protected function rollMouseHandler(event:MouseEvent):void
		{
			if ( event.type == MouseEvent.ROLL_OVER ) {
				startMoveDes();
			} else if ( event.type == MouseEvent.ROLL_OUT ) {
				stopMoveDes();
			}
		}
		
		/*============================================================================*/
		/* public functions                                                           */
		/*============================================================================*/
		
		public function setData( vo:TaskVo ):void
		{
			_data = vo;
			
			bgStatus.gotoAndStop( vo.isEd ? 3 : 1 );
			addListeners();
			
			if (  txtDes.htmlText != vo.fullDescribe )
			{
				txtDes.htmlText = vo.fullDescribe;
				txtDes.width = txtDes.textWidth + 10;
				if ( bitmapDes ) {
					if ( bitmapDes.bitmapData )
						bitmapDes.bitmapData.dispose();
					removedFromParent( bitmapDes );
				}
				bitmapDes = new Bitmap( new BitmapData( txtDes.width, txtDes.height, true, 0 ));
				bitmapDes.bitmapData.draw( txtDes );
				bitmapDes.x = txtDes.x;
				bitmapDes.y = txtDes.y;
				bitmapCon.addChild( bitmapDes );
				
				endMoveX = txtDes.x;
				time = 0;
				
				if ( bitmapDes.width > txtWidth ) {
					var diff:Number = ( bitmapDes.width - txtWidth );
					endMoveX = endMoveX - diff;
					time = diff / 60;
				}
				
				bitmapCon.mouseChildren = false;
				bitmapCon.mouseEnabled = false;
			}
		}

		/*============================================================================*/
		/* public variables                                                           */
		/*============================================================================*/
		
		public function get data():TaskVo
		{
			return _data;
		}
		
		
	}
}