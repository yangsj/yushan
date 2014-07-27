package app.modules.panel.personal.view
{
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import app.data.GameData;
	import app.data.PlayerSelfVo;
	import app.modules.ViewName;
	
	import net.victoryang.events.ViewEvent;
	import net.victoryang.framework.BasePanel;
	
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-9-12
	 */
	public class PersonalPanel extends BasePanel
	{
		public var txtName:TextField;
		public var btnChangeName:SimpleButton;
		public var txtMoney:TextField;
		public var txtLevel:TextField;
		public var txtExp:TextField;
		public var txtRightNum:TextField;
		public var txtErrorNum:TextField;
		public var btnErrorWordList:SimpleButton;
		
		private var oldName:String = "";
		
		public var propList:PersonalPropList;
		
		public function PersonalPanel()
		{
		}
		
		override protected function onceInit():void
		{
			super.onceInit();
			
			propList = new PersonalPropList();
			addChild( propList );
			
			txtErrorNum.mouseEnabled = false;
			txtExp.mouseEnabled = false;
			txtLevel.mouseEnabled = false;
			txtMoney.mouseEnabled = false;
			txtName.mouseEnabled = false;
			txtRightNum.mouseEnabled = false;
			
			btnChangeName.addEventListener(MouseEvent.CLICK, btnChangeNameClickHandler );
			btnErrorWordList.addEventListener(MouseEvent.CLICK, btnErrorWordListClickHandler );
		}
		
		protected function btnChangeNameClickHandler(event:MouseEvent):void
		{
			dispatchEvent( new ViewEvent(ViewEvent.HIDE, ViewName.Personal ));
			dispatchEvent( new ViewEvent(ViewEvent.SHOW, ViewName.InformationPanel ));
		}
		
		protected function btnErrorWordListClickHandler(event:MouseEvent):void
		{
			dispatchEvent( new ViewEvent(ViewEvent.HIDE, ViewName.Personal ));
			dispatchEvent( new ViewEvent( ViewEvent.SHOW, ViewName.ErrorListPanel ));
		}
		
		override protected function afterRender():void
		{
			super.afterRender();
			
			var selfVo:PlayerSelfVo = GameData.instance.selfVo;
			
			txtName.text = oldName = selfVo.name;
			txtMoney.text = selfVo.money.toString();
			txtLevel.text = "Lv." + selfVo.level;
			txtExp.text = selfVo.exp.toString();
			txtRightNum.text = selfVo.rightWordsNum.toString();
			txtErrorNum.text = selfVo.wrongWordsNum.toString();
		}
		
		override protected function get resNames():Array
		{
			return ["ui_Personal", "ui_prop_list"];
		}
		
		override protected function get skinName():String
		{
			return "ui_Skin_PersonalViewPanel";
		}
		
	}
}