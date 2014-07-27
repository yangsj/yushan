package app.modules.task.view
{
	import flash.display.Sprite;
	
	import app.modules.task.model.TaskVo;
	
	import net.victoryang.components.scroll.ScrollPanel;
	import net.victoryang.framework.BasePanel;
	import net.victoryang.func.removedAllChildren;
	
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-9-6
	 */
	public class TaskView extends BasePanel
	{
		private var listContainer:Sprite;
		private var gameScroll:ScrollPanel;
		
		public function TaskView()
		{
		}
		
		public function setDataList( list:Vector.<TaskVo> ):void
		{
			if ( list )
			{
				removedAllChildren( listContainer );
				var i:int = 0;
				var disty:Number = 43;
				var startx:Number = list.length < 7 ? 5 : 0;
				var pos:Number = isNaN( gameScroll.curPos ) ? 0 : gameScroll.curPos;
				for each ( var vo:TaskVo in list )
				{
					var item:TaskItem = TaskItem.itemInstance;
					item.setData( vo );
					item.x = startx;
					item.y = disty * i;
					listContainer.addChild( item );
					i++;
				}
				gameScroll.updateMainHeight( listContainer.height );
				gameScroll.setPos( pos );
			}
		}
		
		override protected function onceInit():void
		{
			super.onceInit();
			
			listContainer = new Sprite();
			listContainer.graphics.beginFill(0, 0 );
			listContainer.graphics.drawRect(0,0,260,288);
			listContainer.graphics.endFill();
			listContainer.x = 23;
			listContainer.y = 46;
			_skin.addChild( listContainer );
			
			gameScroll = new ScrollPanel();
			gameScroll.setTargetAndHeight( listContainer, listContainer.height, listContainer.width );
		}
		
		override protected function get resNames():Array
		{
			return ["ui_task"];
		}
		
		override protected function get skinName():String
		{
			return "ui_Skin_TaskViewPanel";
		}
		
	}
}