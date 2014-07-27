package app.modules.login.login
{
	import flash.display.InteractiveObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	
	import app.Language;
	import app.modules.login.login.event.LoginEvent;
	import app.modules.login.login.vo.LoginVo;
	
	import net.victoryang.components.Tips;
	import net.victoryang.framework.BasePanel;
	import net.victoryang.func.apps;
	
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-9-6
	 */
	public class LoginView extends BasePanel
	{
		public var txtAccountNumber:TextField;
		public var txtPassword:TextField;
		public var txtTips1:TextField;
		public var txtTips2:TextField;
		public var btnLogin:InteractiveObject;
		public var btnRegister:InteractiveObject;
		public var radioRememberName:MovieClip;
		public var radioRememberPwd:MovieClip;
		
		private var _loginVo:LoginVo;
		
		public function LoginView()
		{
			super();
		}
		
		override protected function transitionIn():void
		{
			apps.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler );
			openComplete();
		}
		
		override public function hide():void
		{
			transitionOut( 0 );
			apps.removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler );
		}
		
		private function check():void
		{
			txtAccountNumber.text = loginVo.accountName;
			txtPassword.text = loginVo.password;
			txtTips1.visible = !txtAccountNumber.text;
			txtTips2.visible = !txtPassword.text;
			checkRememberStatus();
			// 自动登陆
//			if ( loginVo.isAutoLogin )
//				btnLoginHandler( null );
		}
		
		private function checkRememberStatus():void
		{
			radioRememberName.gotoAndStop( loginVo.isRememberName ? 2 : 1 );
			radioRememberPwd.gotoAndStop( loginVo.isRememberPwd ? 2 : 1 );
		}
		
		override protected function onceInit():void
		{
			super.onceInit();
			
			txtAccountNumber.tabEnabled = true;
			txtPassword.tabEnabled = true;
			txtAccountNumber.tabIndex = 0;
			txtPassword.tabIndex = 1;
			
			radioRememberName.buttonMode = true
			radioRememberPwd.buttonMode = true
			
			btnLogin.addEventListener(MouseEvent.CLICK, btnLoginHandler );
			btnRegister.addEventListener(MouseEvent.CLICK, btnRegisterHandler );
			txtAccountNumber.addEventListener(FocusEvent.FOCUS_IN, focusInOutHandler );
			txtAccountNumber.addEventListener(FocusEvent.FOCUS_OUT, focusInOutHandler );
			txtPassword.addEventListener(FocusEvent.FOCUS_IN, focusInOutHandler );
			txtPassword.addEventListener(FocusEvent.FOCUS_OUT, focusInOutHandler );
			radioRememberName.addEventListener(MouseEvent.CLICK, checkBoxForRememberNameHandler );
			radioRememberPwd.addEventListener(MouseEvent.CLICK, checkBoxForRememberPwdHandler );
			
			check();
		}
		
		override public function dispose():void
		{
			super.dispose();
			
			btnLogin.removeEventListener(MouseEvent.CLICK, btnLoginHandler );
			btnRegister.removeEventListener(MouseEvent.CLICK, btnRegisterHandler );
			txtAccountNumber.removeEventListener(FocusEvent.FOCUS_IN, focusInOutHandler );
			txtAccountNumber.removeEventListener(FocusEvent.FOCUS_OUT, focusInOutHandler );
			txtPassword.removeEventListener(FocusEvent.FOCUS_IN, focusInOutHandler );
			txtPassword.removeEventListener(FocusEvent.FOCUS_OUT, focusInOutHandler );
			radioRememberName.removeEventListener(MouseEvent.CLICK, checkBoxForRememberNameHandler );
			radioRememberPwd.removeEventListener(MouseEvent.CLICK, checkBoxForRememberPwdHandler );
		}
		
		protected function checkBoxForRememberPwdHandler(event:MouseEvent):void
		{
			loginVo.isRememberPwd = !loginVo.isRememberPwd;
			if ( loginVo.isRememberPwd )
				loginVo.isRememberName = true;
			checkRememberStatus();
		}
		
		protected function checkBoxForRememberNameHandler(event:MouseEvent):void
		{
			loginVo.isRememberName = !loginVo.isRememberName;
			if ( loginVo.isRememberName == false )
				loginVo.isRememberPwd = false;
			checkRememberStatus();
		}
		
		protected function focusInOutHandler(event:FocusEvent):void
		{
			var type:String = event.type;
			var target:TextField = event.target as TextField;
			if ( type == FocusEvent.FOCUS_IN )
			{
				if ( target == txtAccountNumber )
					txtTips1.visible = false;
				else txtTips2.visible = false;
			}
			else if ( type == FocusEvent.FOCUS_OUT )
			{
				if ( target == txtAccountNumber )
					txtTips1.visible = !target.text;
				else txtTips2.visible = !target.text;
			}
		}
		
		protected function btnRegisterHandler(event:MouseEvent):void
		{
			dispatchEvent( new LoginEvent( LoginEvent.ACTION_REGISTER ));
		}
		
		protected function keyDownHandler( event:KeyboardEvent ):void
		{
			if ( event.keyCode == Keyboard.ENTER )
				btnLoginHandler( event );
		}
		
		protected function btnLoginHandler( event:Event ):void
		{
			if ( txtAccountNumber.text && txtPassword.text )
			{
				_loginVo.accountName = txtAccountNumber.text;
				_loginVo.password = txtPassword.text;
				
				dispatchEvent( new LoginEvent( LoginEvent.ACTION_LOGIN ));
			}
			else if ( event)
			{
				Tips.showMouse( Language.lang( Language.LoginView_0 ) );
			}
		}
		
		public function get loginVo():LoginVo
		{
			_loginVo ||= new LoginVo();
			return _loginVo;
		}
		
		override protected function get skinName():String
		{
			return "ui_SkinLoginUI";
		}
		
	}
}