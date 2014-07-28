package app.modules.panel.personal.command
{
	import app.modules.ViewName;
	import app.modules.panel.personal.model.PersonalModel;
	import app.modules.panel.personal.service.PersonalService;
	import app.modules.panel.personal.view.ErrorListMediator;
	import app.modules.panel.personal.view.ErrorListView;
	import app.modules.panel.personal.view.InformationMediator;
	import app.modules.panel.personal.view.InformationPanel;
	import app.modules.panel.personal.view.PersonalMediator;
	import app.modules.panel.personal.view.PersonalPanel;
	
	import victoryang.framework.BaseCommand;
	
	
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-9-12
	 */
	public class PersonalInitCommand extends BaseCommand
	{
		public function PersonalInitCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			addView( ViewName.Personal, PersonalPanel, PersonalMediator );
			addView( ViewName.InformationPanel, InformationPanel, InformationMediator );
			addView( ViewName.ErrorListPanel, ErrorListView, ErrorListMediator );
			
			injectActor( PersonalModel );
			injectActor( PersonalService );
		}
		
	}
}