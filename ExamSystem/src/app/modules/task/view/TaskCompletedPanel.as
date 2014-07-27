package app.modules.task.view
{
	import flash.display.InteractiveObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import app.modules.fight.view.prop.item.PropItem;
	import app.modules.model.vo.ItemVo;
	import app.modules.task.event.TaskEvent;
	import app.modules.task.model.TaskVo;
	import app.modules.util.Num;
	
	import net.victoryang.framework.BasePanel;
	import net.victoryang.func.removedAllChildren;
	import net.victoryang.uitl.UtilsFilter;
	
	
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-11-22
	 */
	public class TaskCompletedPanel extends BasePanel
	{
		
		public var conExpNum:Sprite;
		public var conMoneyNum:Sprite;
		public var btnTake:InteractiveObject;
		
		private var propListContainer:Sprite;
		
		public function TaskCompletedPanel()
		{
			super();
		}
		
		override protected function openComplete():void
		{
			super.openComplete();
			createPropList();
			addEventListener(Event.ENTER_FRAME, enterFrameHandler );
			btnTake.addEventListener(MouseEvent.CLICK, btnTakeClickHandler );
		}
		
		protected function btnTakeClickHandler(event:MouseEvent):void
		{
			dispatchEvent( new TaskEvent( TaskEvent.TAKE_REWARD, data ));
			btnTake.mouseEnabled = false;
			btnTake.filters = [ UtilsFilter.COLOR_GREW ];
		}
		
		protected function enterFrameHandler(event:Event):void
		{
			if ( parent )
			{
				parent.setChildIndex( this, parent.numChildren - 1 );
			} else{
				removeEventListener(Event.ENTER_FRAME, enterFrameHandler );
			}
		}
		
		private function createPropList():void
		{
			removedAllChildren( propListContainer );
			var item:PropItem;
			var taskVo:TaskVo = data as TaskVo;
			btnTake.mouseEnabled = false;
			if ( taskVo )
			{
				var vec:Vector.<ItemVo> = taskVo.propList;
				var length:int = vec.length;
				for ( var i:int = 0; i < length; i++ )
				{
					item = new PropItem();
					item.setData(vec[i]);
					item.x = 80 * i;
					item.mouseChildren = false;
					item.mouseEnabled = false;
					propListContainer.addChild( item );
				}
				
				removedAllChildren( conExpNum );
				removedAllChildren( conMoneyNum );
				
				var shapeNum:Shape = Num.getShape( taskVo.rewardExp );
				shapeNum.y = -shapeNum.height * 0.5;
				conExpNum.addChild( shapeNum );
				
				shapeNum = Num.getShape( taskVo.rewardMoney );
				shapeNum.y = -shapeNum.height * 0.5;
				conMoneyNum.addChild( shapeNum );
				
				btnTake.mouseEnabled = taskVo.isEd;
				btnTake.filters = taskVo.isEd ? [] : [ UtilsFilter.COLOR_GREW ];
			}
		}
		
		override protected function onceInit():void
		{
			super.onceInit();
			
			propListContainer = new Sprite();
			propListContainer.x = 274;
			propListContainer.y = 140;
			addChild( propListContainer );
		}
		
		override protected function get resNames():Array
		{
			return ["ui_task", "ui_prop_list"];
		}
		
		override protected function get skinName():String
		{
			return "ui_Skin_TaskCompletedPanel";
		}
		
	}
}