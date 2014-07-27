package app.modules.fight.view.prop.item
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	
	import app.modules.model.vo.ItemVo;
	
	import net.victoryang.components.Text;
	import net.victoryang.framework.ViewStruct;
	import net.victoryang.func.apps;
	import net.victoryang.interfaces.IDisposable;
	import net.victoryang.uitl.MathUtil;
	
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-12-5
	 */
	public class PropItemTips extends Sprite implements IDisposable
	{
		/*============================================================================*/
		/* private variables                                                          */
		/*============================================================================*/
		
		private var bgArea:DisplayObject;
		private var target:DisplayObject;
		private var txtLine:TextField;
		private var isDraw:Boolean = false;
		
		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/
		public function PropItemTips( target:DisplayObject )
		{
							  
			txtLine = Text.getText( 14, 0xffffff, "微软雅黑", 0, 2, 100, 60 );
			txtLine.text = "   ";
			txtLine.height = txtLine.textHeight + 8;
			addChild( txtLine );
			this.target = target;
			if ( target )
			{
				target.addEventListener(MouseEvent.ROLL_OVER, mouseHandler );
				target.addEventListener(MouseEvent.ROLL_OUT , mouseHandler );
			}
		}
		
		protected function mouseHandler( event:MouseEvent ):void
		{
			if ( target && target.stage )
			{
				if ( event.type == MouseEvent.ROLL_OVER )
				{
					ViewStruct.addChild( this, ViewStruct.TIPS );
					drawBg();
					bgArea.alpha = 0.7;
				}
				else if ( event.type == MouseEvent.ROLL_OUT )
				{
					ViewStruct.removeChild( this );
					bgArea.alpha = 1;
				}
			}
		}
		
		private function drawBg():void
		{
			if ( target && target.stage )
			{
				this.graphics.clear();
				this.graphics.beginFill( 0, 0.7 );
				this.graphics.drawRoundRect(0,0,txtLine.width, txtLine.height, 5 );
				this.graphics.endFill();
				
				var point:Point = target.localToGlobal( new Point( ( bgArea.width *0.5 - width *0.5 ), -10 ));
				x = MathUtil.range( point.x, 10, apps.stageWidth - width - 10 );
				y = point.y - height;
				
				var startx:Number = ( width * 0.5 ) - x + point.x;
				this.graphics.beginFill( 0, 0.7 );
				this.graphics.moveTo( startx - 10, txtLine.height );
				this.graphics.lineTo( startx + 10, txtLine.height );
				this.graphics.lineTo( startx, txtLine.height + 15 );
				this.graphics.lineTo( startx - 10, txtLine.height );
				this.graphics.endFill();
			}
		}
		
		/*============================================================================*/
		/* public functions                                                           */
		/*============================================================================*/
		
		public function dispose():void
		{
		}
		
		public function setVo( itemVo:ItemVo ):void
		{
			txtLine.text = itemVo.desc;
			txtLine.width = txtLine.textWidth + 20;
			bgArea = target["bgArea"] as DisplayObject;
			drawBg();
		}
		
	}
}