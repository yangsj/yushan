package app.modules.panel.personal.view
{
	import app.modules.ViewName;
	import app.modules.panel.personal.events.PersonalEvent;
	import app.modules.panel.personal.model.PersonalModel;
	import app.modules.panel.personal.service.PersonalService;
	
	import victor.framework.core.BaseMediator;
	import victor.framework.events.PanelEvent;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-11-30
	 */
	public class ErrorListMediator extends BaseMediator
	{
		[Inject]
		public var view:ErrorListView;
		[Inject]
		public var personalModel:PersonalModel;
		[Inject]
		public var personalService:PersonalService;
		
		public function ErrorListMediator()
		{
			super();
		}
		
		override public function onRemove():void
		{
			super.onRemove();
			personalModel.clearList();
			openView( ViewName.Personal );
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			
			addContextListener( PersonalEvent.ERROR_LIST_SUCCESSED, getListNotify, PersonalEvent );
			
			addViewListener( PanelEvent.OPENED, openedPanelHandler, PanelEvent );
		}
		
		private function getListNotify( event:PersonalEvent ):void
		{
//			view.setVo( errorListModel.list );
			view.setArrayList( personalModel.englshList, personalModel.chineseList );
		}
		
		private function openedPanelHandler( event:PanelEvent ):void
		{
			personalService.getErrorList();
		}
		
	}
}