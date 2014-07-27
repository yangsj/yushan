package app.modules.login.login
{
	import app.managers.ExternalManager;
	import app.modules.login.login.event.LoginEvent;
	import app.modules.login.service.LoginService;
	
	import net.victoryang.framework.BaseMediator;
	
	
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-9-6
	 */
	public class LoginMediator extends BaseMediator
	{
		[Inject]
		public var view:LoginView;
		
		[Inject]
		public var loginService:LoginService;
		
		public function LoginMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			
			addViewListener( LoginEvent.ACTION_LOGIN, actionLoginHandler, LoginEvent );
			addViewListener( LoginEvent.ACTION_REGISTER, actionRegisterHandler, LoginEvent );
		}
		
		private function actionRegisterHandler( event:LoginEvent ):void
		{
//			openView( ViewName.Register );
			ExternalManager.gotoHtmlRegister();
		}
		
		private function actionLoginHandler( event:LoginEvent ):void
		{
			loginService.login( view.loginVo );
		}		
		
	}
}