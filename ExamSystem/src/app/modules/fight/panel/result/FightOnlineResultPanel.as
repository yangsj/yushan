package app.modules.fight.panel.result
{
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import app.modules.fight.events.FightOnlineEvent;
	import app.modules.fight.model.FightEndVo;
	import app.modules.util.Num;
	
	import net.victoryang.framework.BasePanel;
	import net.victoryang.func.removedAllChildren;
	
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-10-17
	 */
	public class FightOnlineResultPanel extends BasePanel
	{
		/**
		* btnAgain
		*/
		public var btnAgain:SimpleButton;
		/**
		 * btnCancel
		 */
		public var btnCancel:SimpleButton;
		/**
		 * txtPlayerName1
		 */
		public var txtPlayerName1:TextField;
		/**
		 * txtPlayerName2
		 */
		public var txtPlayerName2:TextField;
		/**
		 * conExp1
		 */
		public var conExp1:MovieClip;
		/**
		 * conExp2
		 */
		public var conExp2:MovieClip;
		/**
		 * conMoney1
		 */
		public var conMoney1:MovieClip;
		/**
		 * conMoney2
		 */
		public var conMoney2:MovieClip;
		/**
		 * conItems1
		 */
		public var conItems1:MovieClip;
		/**
		 * conItems2
		 */
		public var conItems2:MovieClip;
		
		public function FightOnlineResultPanel()
		{
			super();
		}
		
		override protected function onceInit():void
		{
			super.onceInit();
			btnCancel.addEventListener( MouseEvent.CLICK, btnCancelHandler );
			btnAgain.addEventListener( MouseEvent.CLICK, btnAgainHandler );
		}
		
		protected function btnAgainHandler(event:MouseEvent):void
		{
			dispatchEvent( new FightOnlineEvent( FightOnlineEvent.AGAIN_BATTLE ));
		}
		
		protected function btnCancelHandler(event:MouseEvent):void
		{
			btnClose.dispatchEvent( new MouseEvent( MouseEvent.CLICK ));
		}
		
		public function setPlayer( winName:String, loseName:String ):void
		{
			txtPlayerName1.text = winName;
			txtPlayerName2.text = loseName;
		}
		
		public function setData( winVo:FightEndVo, loseVo:FightEndVo ):void
		{
//			txtExp1.text = winVo.addExp + "";
//			txtMoney1.text = winVo.addMoney + "";
//			txtItems1.text = "";
//			txtItems1.text = "x" + winVo.items.length;
//			
//			txtExp2.text = loseVo.addExp + "";
//			txtMoney2.text = loseVo.addMoney + "";
//			txtItems2.text = "";
//			txtItems2.text = "x" + loseVo.items.length;
			
			setConNum( conExp1, winVo.addExp );
			setConNum( conMoney1, winVo.addMoney );
			setConNum( conItems1, winVo.items.length );
			setConNum( conExp2, loseVo.addExp );
			setConNum( conMoney2, loseVo.addMoney );
			setConNum( conItems2, loseVo.items.length );
		}
		
		private function setConNum( con:Sprite, num:int ):void
		{
			removedAllChildren( con );
			var shapeNum:Shape = Num.getShape( num );
			shapeNum.x = -shapeNum.width * 0.5;
			shapeNum.y = -shapeNum.height * 0.5;
			con.addChild( shapeNum );
		}
		
		override protected function get resNames():Array
		{
			return ["ui_fight_online_result"];
		}
		
		override protected function get skinName():String
		{
			return "ui_Skin_FightOnlineResultPanel";
		}
		
	}
}