package app.modules.panel.rank.command
{
	import app.modules.ViewName;
	import app.modules.panel.rank.model.RankModel;
	import app.modules.panel.rank.service.RankService;
	import app.modules.panel.rank.view.RankMediator;
	import app.modules.panel.rank.view.RankView;
	
	import victor.framework.core.BaseCommand;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-28
	 */
	public class RankInitCommand extends BaseCommand
	{
		public function RankInitCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			addView( ViewName.Rank, RankView, RankMediator );
			
			injectActor( RankModel );
			injectActor( RankService );
			
		}
		
	}
}