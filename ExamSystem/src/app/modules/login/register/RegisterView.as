package app.modules.login.register
{
	import flash.display.InteractiveObject;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import app.Language;
	import app.modules.login.register.event.RegisterEvent;
	import app.modules.login.register.vo.RegisterVo;
	import app.modules.model.GenderType;
	
	import victoryang.components.Tips;
	import victoryang.core.TabButtons;
	import victoryang.deubg.Debug;
	import victoryang.framework.BasePanel;
	import victoryang.func.apps;
	import victoryang.uitl.StringUitl;
	
	
	/**
	 * ……
	 * 区县：
	 * 黄浦区
	 * 卢湾区
	 * 金山区
	 * 徐汇区
	 * 长宁区
	 * 静安区
	 * 普陀区
	 * 闸北区
	 * 虹口区
	 * 杨浦区
	 * 闵行区
	 * 宝山区
	 * 嘉定区
	 * 浦东新区
	 * 松江区
	 * 青浦区
	 * 南汇区
	 * 奉贤区
	 * 崇明县
	 * 
	 * 年级：
	 * 一年级-六年级（预初）
	 * 初一到初三
	 * 高一到高三
	 * @author 	victor 
	 * 			2013-9-4
	 */
	public class RegisterView extends BasePanel
	{
		// required
		public var txtAccount:TextField;
		public var txtPw1:TextField;
		public var txtPw2:TextField;
		public var txtPhone:TextField;
		public var txtEmail:TextField;
		// optional
		public var txtName:TextField;
		public var txtArea:TextField;
		public var txtSchool:TextField;
		public var txtClass:TextField;
		public var txtQQ:TextField;
		
		public var tab0:MovieClip;
		public var tab1:MovieClip;
		
		public var btnRegister:InteractiveObject;
		public var btnLogin:InteractiveObject;
		
		public var checkboxArea:InteractiveObject;
		public var checkboxGrade:InteractiveObject;
		
		private var tabControl:TabButtons;
		private var areaPanel:CheckboxPanel;
		private var gradePanel:CheckboxPanel;
		
		private var _registerVo:RegisterVo;
		private var gender:int;
		
		public function RegisterView()
		{
			super();
			this.graphics.beginFill( 0, 0.4 );
			this.graphics.drawRect(0, 0, apps.stageWidth, apps.stageHeight );
			this.graphics.endFill();
		}
		
		override protected function onceInit():void
		{
			super.onceInit();
			
			btnLogin.addEventListener(MouseEvent.CLICK, btnLoginHandler );
			btnRegister.addEventListener(MouseEvent.CLICK, btnRegisterHandler );
			checkboxArea.addEventListener(MouseEvent.CLICK, checkboxAreaHandler );
			checkboxGrade.addEventListener(MouseEvent.CLICK, checkboxGradeHandler );
			
			tabControl = new TabButtons( tabControlHandler );
			tabControl.addTarget( tab0, GenderType.MALE );
			tabControl.addTarget( tab1, GenderType.FEMALE );
			tabControl.setTargetByIndex( 0 );
			
			txtPhone.maxChars = 11;
			txtPhone.restrict = "0-9";
			txtQQ.restrict = "0-9";
			
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
		
		private function areaCallBackFun( data:Array ):void
		{
			txtArea.text = data[0] + "";
		}
		
		private function gradeCallBackFun( data:Array ):void
		{
			txtClass.text = data[0] + "";
		}
		
		private function tabControlHandler( mc:MovieClip, data:int ):void
		{
			gender = data;
			Debug.debug( "性别：" + data );
		}
		
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
		
		override protected function transitionIn():void
		{
		}
		
		override protected function transitionOut( delay:Number = 0.3 ):void
		{
			super.transitionOut( 0 );
		}
		
		protected function btnLoginHandler(event:MouseEvent):void
		{
			dispatchEvent( new RegisterEvent( RegisterEvent.LOGIN ));
		}
		
		protected function btnRegisterHandler(event:MouseEvent):void
		{
			var msg:String = "";
			var array:Array = Language.lang(Language.RegisterView_0).split("|");
			
			if ( !registerVo.name )
				msg = array[0];
			
			else if ( !registerVo.password )
				msg = array[1];
			
			else if (　!registerVo.passwordConfirm )
				msg = array[2];
			
			else if ( !registerVo.phone )
				msg = array[3];
			
			else if ( !registerVo.email )
				msg = array[4];
			
			if ( !msg )
			{
				if ( registerVo.password != registerVo.passwordConfirm )
				{
					txtPw2.text = "";
					msg =  array[5];
				}
				else
				{
					if ( !StringUitl.validatePhoneNumber( registerVo.phone ))
						msg = array[6];
					else if ( !StringUitl.validateEmail( registerVo.email ))
						msg = array[7];
				}
			}
			
			if ( msg ) Tips.showMouse( msg );
			
			else dispatchEvent( new RegisterEvent( RegisterEvent.REGISTER ));
		}
		
		public function get registerVo():RegisterVo
		{
			_registerVo ||= new RegisterVo();
			_registerVo.name = txtAccount.text;
			_registerVo.password = txtPw1.text;
			_registerVo.passwordConfirm = txtPw2.text;
			_registerVo.phone = txtPhone.text;
			_registerVo.email = txtEmail.text;
			_registerVo.gender = gender;
			
			_registerVo.realName = txtName.text;
			_registerVo.address = txtArea.text;
			_registerVo.school = txtSchool.text;
			_registerVo.grade = txtClass.text;
			_registerVo.QQ = txtQQ.text;
			
			return _registerVo;
		}
		
		override protected function get skinName():String
		{
			return "ui_SkinRegisterUI";
		}
		
	}
}