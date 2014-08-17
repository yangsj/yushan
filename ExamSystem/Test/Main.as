package 
{
	import flash.display.*;
	import flash.events.*;

	[SWF(width="550", height="502", frameRate="1", backgroundColor="#ffffff")]
	public class Main extends MovieClip 
	{
		private var main:Sprite=new Sprite //显视涂鸦
		private var bmd:BitmapData=new BitmapData(550, 502, true, 0) //涂鸦数据
		private var bmp:Bitmap=new Bitmap(bmd) //涂鸦数据图片
		private var drawCanvas:Sprite=new Sprite //不可见的画板
		private var action:Boolean=false //是否为橡皮擦
		private var ctrl:Sprite=new Sprite //控制是否为橡皮擦

		public function Main() 
		{
		        super();
		        init()
		}

		private function init():void 
		{
		        addChild(main)
		        main.addChild(bmp)
		        addChild(ctrl)
		        ctrl.graphics.beginFill(0)
		        ctrl.graphics.drawRect(0, 0, 50, 50)
		        ctrl.graphics.endFill()
		        ctrl.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void {
				action=!action
		        })
		        stage.addEventListener(MouseEvent.MOUSE_DOWN, down)
		        stage.addEventListener(MouseEvent.MOUSE_MOVE, move)
		}

		private function down(e:MouseEvent):void {
		        drawCanvas.graphics.clear()
		        drawCanvas.graphics.lineStyle(25, 0xff0000)
		        drawCanvas.graphics.moveTo(mouseX, mouseY)
		}

		private function move(e:MouseEvent):void {
		        if (e.buttonDown) {
				drawCanvas.graphics.lineTo(mouseX, mouseY);
				bmd.draw(drawCanvas, null, null, action ? BlendMode.ERASE : BlendMode.NORMAL)
				e.updateAfterEvent()
		        }
		}
	}
}