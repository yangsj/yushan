package app.startup
{
	import app.data.GameData;
	import app.modules.ViewName;
	import app.modules.main.model.MainModel;
	import app.modules.map.model.MapModel;
	
	import net.victoryang.framework.BaseCommand;
	
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-8-28
	 */
	public class EnterGameCommand extends BaseCommand
	{
		[Inject]
		public var mapModel:MapModel;
		[Inject]
		public var gameDb:GameData;
		[Inject]
		public var mainModel:MainModel;
		
		public function EnterGameCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			if　( mainModel.hasEnterGame )
				return ;
			
			// 主资源是否加载完成|是否有地图数据|是否有好友数据|是否有任务数据|是否有背包数据
			if ( mainModel.hasLoadCompleted && mapModel.hasMapList )
			{
				mainModel.hasEnterGame = true;
				enterGame();
			}
		}
		
		private function enterGame():void
		{
			var displayView:Array = [ ViewName.MainUI, ViewName.MapWorld, ViewName.Chat ];
			
			for each (var viewName:String in displayView ) {
				openView( viewName );
			}
			
			// 关闭Preloader
			closeView( ViewName.Preloader );
		}
		
	}
}