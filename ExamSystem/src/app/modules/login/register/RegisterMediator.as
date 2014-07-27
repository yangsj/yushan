package app.modules.login.register
{
	import app.modules.ViewName;
	import app.modules.login.register.event.RegisterEvent;
	import app.modules.login.service.LoginService;
	
	import net.victoryang.framework.BaseMediator;
	
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-9-4
	 */
	public class RegisterMediator extends BaseMediator
	{
		[Inject]
		public var view:RegisterView;
		
		[Inject]
		public var loginService:LoginService;
		
		public function RegisterMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			
			addViewListener( RegisterEvent.LOGIN, loginHandler );
			addViewListener( RegisterEvent.REGISTER, registerHandler );
		}
		
		private function registerHandler( event:RegisterEvent ):void
		{
			loginService.register( view.registerVo );
		}
		
		private function loginHandler( event:RegisterEvent ):void
		{
			closeView( ViewName.Register );
		}
		
	}
}