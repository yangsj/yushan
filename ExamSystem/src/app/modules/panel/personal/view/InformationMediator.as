package app.modules.panel.personal.view
{
	import app.data.GameData;
	import app.data.PlayerSelfVo;
	import app.modules.ViewName;
	import app.modules.login.register.vo.RegisterVo;
	import app.modules.panel.personal.events.PersonalEvent;
	import app.modules.panel.personal.service.PersonalService;
	
	import victor.framework.core.BaseMediator;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-12-3
	 */
	public class InformationMediator extends BaseMediator
	{
		/*============================================================================*/
		/* private variables                                                          */
		/*============================================================================*/
		
		[Inject]
		public var view:InformationPanel;
		[Inject]
		public var personalService:PersonalService;
		
		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/
		public function InformationMediator()
		{
			super();
		}
		
		/*============================================================================*/
		/* events handlers                                                            */
		/*============================================================================*/
		
		private function changeInfoHandler( event:PersonalEvent ):void
		{
			personalService.changeInfo( view.registerVo );
		}
		
		private function changeInfoSuccessNotify( event:PersonalEvent ):void
		{
			var data:RegisterVo = view.registerVo;
			var selfVo:PlayerSelfVo = GameData.instance.selfVo;
			selfVo.address = data.address;
			selfVo.email = data.email;
			selfVo.grade = data.grade;
			selfVo.name = data.name;
			selfVo.phone = data.phone;
			selfVo.qq = data.QQ;
			selfVo.realName = data.realName;
			selfVo.school = data.school;
			selfVo.gender = data.gender;
			
			GameData.instance.selfVo = selfVo;
		}
		
		/*============================================================================*/
		/* override functions                                                         */
		/*============================================================================*/
		
		override public function onRemove():void
		{
			super.onRemove();
			openView( ViewName.Personal );
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			
			addViewListener( PersonalEvent.CHANGE_INFO, changeInfoHandler, PersonalEvent );
			
			addContextListener( PersonalEvent.CHANGE_INFO_SUCCESS, changeInfoSuccessNotify, PersonalEvent );
			
			view.setBaseData();
		}
		
	}
}