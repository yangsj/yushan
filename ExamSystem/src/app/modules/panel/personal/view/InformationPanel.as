package app.modules.panel.personal.view
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import app.data.GameData;
	import app.data.PlayerSelfVo;
	import app.modules.login.register.CheckboxPanel;
	import app.modules.login.register.RegisterConfig;
	import app.modules.login.register.vo.RegisterVo;
	import app.modules.model.GenderType;
	import app.modules.panel.personal.events.PersonalEvent;
	
	import net.victoryang.components.Tips;
	import net.victoryang.core.TabButtons;
	import net.victoryang.deubg.Debug;
	import net.victoryang.framework.BasePanel;
	import net.victoryang.uitl.StringUitl;
	
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-12-3
	 */
	public class InformationPanel extends BasePanel
	{
		/*============================================================================*/
		/* private variables                                                          */
		/*============================================================================*/
		
		public var checkboxArea:SimpleButton;
		public var checkboxGrade:SimpleButton;
		public var btnCommit:SimpleButton;
		
		public var txtRealName:TextField;
		public var txtArea:TextField;
		public var txtSchool:TextField;
		public var txtClass:TextField;
		public var txtQQ:TextField;
		public var txtEmail:TextField;
		public var txtName:TextField;
		public var txtCurPw:TextField;
		public var txtChangePw:TextField;
		public var txtConfirmPw:TextField;
		
		public var tab0:MovieClip;
		public var tab1:MovieClip;
		
		private var tabControl:TabButtons;
		private var gender:int = 0;
		
		private var areaPanel:CheckboxPanel;
		private var gradePanel:CheckboxPanel;
		
		private var _registerVo:RegisterVo;
		
		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/
		public function InformationPanel()
		{
			super();
		}
		
		/*============================================================================*/
		/* private functions                                                          */
		/*============================================================================*/
		
		private function areaCallBackFun( data:Array ):void
		{
			txtArea.text = data[0] + "";
		}
		
		private function gradeCallBackFun( data:Array ):void
		{
			txtClass.text = data[0] + "";
		}
		
		/*============================================================================*/
		/* protected functions                                                        */
		/*============================================================================*/
		
		
		
		/*============================================================================*/
		/* events handlers                                                            */
		/*============================================================================*/
		
		protected function checkboxAreaHandler(event:MouseEvent):void
		{
			event.stopPropagation();
			gradePanel.tweenClose();
			if ( areaPanel.isOpen )
				areaPanel.tweenClose();
			else areaPanel.tweenOpen();
		}
		
		protected function checkboxGradeHandler(event:MouseEvent):void
		{
			event.stopPropagation();
			areaPanel.tweenClose();
			if ( gradePanel.isOpen )
				gradePanel.tweenClose();
			else gradePanel.tweenOpen();
		}
		
		protected function btnCommitHandler(event:MouseEvent):void
		{
			var msg:String;
			if ( _registerVo.realName == txtRealName.text && 
				_registerVo.address == txtArea.text && 
				_registerVo.school == txtSchool.text && 
				_registerVo.grade == txtClass.text && 
				_registerVo.QQ == txtQQ.text && 
				_registerVo.email == txtEmail.text && 
				_registerVo.name == txtName.text && 
				_registerVo.password == txtCurPw.text && 
				_registerVo.gender == gender &&
				_registerVo.passwordConfirm == txtConfirmPw.text )
			{
				msg = "没有任何信息更变";
			}
			
			if ( !msg && txtCurPw.text ) {
				if ( !txtChangePw.text ) {
					msg = "请输入新密码";
				} else if ( txtChangePw.text != txtConfirmPw.text ) {
					msg = "两次密码输入不一致";
				}
			}
			
			if ( !msg )
			{
				if ( !StringUitl.validateEmail( txtEmail.text ))
				{
					msg = "输入电子邮箱无效！";
				}
//				else if ( registerVo.phone && !StringUitl.validatePhoneNumber( registerVo.phone ))
//				{
//					msg = "输入电话号码无效！";
//				}
			}
			
			if ( Boolean( msg ) ){
				Tips.showMouse( msg );
				return ;
			}
			
			_registerVo.gender = gender;
			_registerVo.realName = txtRealName.text;
			_registerVo.address = txtArea.text;
			_registerVo.school = txtSchool.text;
			_registerVo.grade = txtClass.text;
			_registerVo.QQ = txtQQ.text;
			_registerVo.email = txtEmail.text;
			_registerVo.name = txtName.text;
			_registerVo.password = txtCurPw.text;
			_registerVo.passwordConfirm = txtConfirmPw.text;
			
			dispatchEvent( new PersonalEvent( PersonalEvent.CHANGE_INFO, _registerVo, true ));
		}
		
		/*============================================================================*/
		/* override functions                                                         */
		/*============================================================================*/
		
		override protected function onceInit():void
		{
			btnCommit.addEventListener(MouseEvent.CLICK, btnCommitHandler );
			checkboxArea.addEventListener(MouseEvent.CLICK, checkboxAreaHandler );
			checkboxGrade.addEventListener(MouseEvent.CLICK, checkboxGradeHandler );
			
			tabControl = new TabButtons( tabControlHandler );
			tabControl.addTarget( tab0, GenderType.MALE );
			tabControl.addTarget( tab1, GenderType.FEMALE );
			
			areaPanel = new CheckboxPanel();
			areaPanel.x = checkboxArea.x + 25;
			areaPanel.y = checkboxArea.y + checkboxArea.height * 0.5 + 5;
			_skin.addChild( areaPanel );
			areaPanel.callBackFun = areaCallBackFun;
			areaPanel.setData( RegisterConfig.AREA_NAME, true );
			
			gradePanel = new CheckboxPanel();
			gradePanel.x = checkboxGrade.x + 25;
			gradePanel.y = checkboxGrade.y + checkboxGrade.height * 0.5 + 5;
			_skin.addChild( gradePanel );
			gradePanel.callBackFun = gradeCallBackFun;
			gradePanel.setData( RegisterConfig.GRADE_NAME, false );
		}
		
		private function tabControlHandler( mc:MovieClip, data:int ):void
		{
			gender = data;
			Debug.debug( "性别：" + data );
		}
		
		override protected function get skinName():String
		{
			return "ui_Skin_InformationPanel";
		}
		override protected function get resNames():Array
		{
			return ["ui_Personal"];
		}
		
		/*============================================================================*/
		/* public functions                                                           */
		/*============================================================================*/
		
		public function setBaseData():void
		{
			var selfVo:PlayerSelfVo = GameData.instance.selfVo;
			
			txtName.text = selfVo.name;
			txtEmail.text = selfVo.email;
			txtQQ.text = selfVo.qq;
			txtSchool.text = selfVo.school;
			txtRealName.text = selfVo.realName;
			
			tabControl.setTargetByIndex( selfVo.gender );
			areaPanel.selectedForItem( RegisterConfig.getAreaIndexByName( selfVo.address ));
			gradePanel.selectedForItem( RegisterConfig.getGradeIndexByName( selfVo.grade ));
			
			_registerVo = new RegisterVo();
			_registerVo.grade = selfVo.grade;
			_registerVo.address = selfVo.address;
			_registerVo.email = selfVo.email;
			_registerVo.gender = selfVo.gender;
			_registerVo.name = selfVo.name;
			_registerVo.password = "";
			_registerVo.passwordConfirm = "";
			_registerVo.phone = selfVo.phone;
			_registerVo.QQ = selfVo.qq;
			_registerVo.realName = selfVo.realName;
			_registerVo.school = selfVo.school;
			_registerVo.phone = selfVo.phone;
		}

		
		/*============================================================================*/
		/* public variables                                                           */
		/*============================================================================*/
		
		public function get registerVo():RegisterVo
		{
			return _registerVo;
		}
		
		
		
	}
}