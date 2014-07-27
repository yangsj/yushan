package app.modules.map.command
{
	import app.modules.ViewName;
	import app.modules.map.main.MapWorldMediator;
	import app.modules.map.main.MapWorldView;
	import app.modules.map.model.MapModel;
	import app.modules.map.panel.SelectedRoundMediator;
	import app.modules.map.panel.SelectedRoundView;
	import app.modules.map.service.MapService;
	
	import net.victoryang.framework.BaseCommand;
	
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-9-22
	 */
	public class MapInitCommand extends BaseCommand
	{
		public function MapInitCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			
			//地图
			addView( ViewName.MapWorld, MapWorldView, MapWorldMediator );
			
			//关卡选择面板
			addView( ViewName.SelectedRoundPanel, SelectedRoundView, SelectedRoundMediator );
			
			injectActor( MapModel );
			injectActor( MapService );
			
		}
		
	}
}