package app.modules.panel.test
{
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import net.victoryang.components.Text;
	import net.victoryang.drag.DragItem;
	import net.victoryang.func.removedAllChildren;
	import net.victoryang.managers.DragManager;
	
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-9-2
	 */
	public class TestItem extends DragItem
	{
		public function TestItem()
		{
			super();
			
			this.graphics.beginFill( 0 );
			this.graphics.drawRect(0,0,100,100);
			this.graphics.endFill();
			
			addEventListener( MouseEvent.MOUSE_DOWN, mouseHandler );
		}
		
		protected function mouseHandler(event:MouseEvent):void
		{
			DragManager.instance.drag( this );
		}
		
		public function setIndex(index:int, colNum:int = 4):void
		{
			x = 110 * ( index % colNum );
			y = 110 * int( index / colNum );
			
			removedAllChildren( this );
			
			var txt:TextField = Text.getText(25, 0xffffff, "宋体");
			txt.text = "NO." + ( index + 1 );
			txt.width = txt.textWidth + 10;
			txt.height = txt.textHeight + 2;
			txt.x = ( width - txt.textWidth ) >> 1;
			txt.y = ( height - txt.textHeight ) >> 1;
			addChild( txt );
		}
		
	}
}