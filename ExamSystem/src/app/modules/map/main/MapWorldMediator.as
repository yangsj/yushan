package app.modules.map.main
{
	import victor.framework.events.ViewEvent;
	import app.modules.ViewName;
	import app.modules.map.event.MapEvent;
	import app.modules.map.model.MapModel;
	
	import victor.framework.core.BaseMediator;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-6
	 */
	public class MapWorldMediator extends BaseMediator
	{
		[Inject]
		public var view:MapWorldView;
		[Inject]
		public var mapModel:MapModel;
		
		public function MapWorldMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			
			// 更新地图数据
			addContextListener( MapEvent.UPDATE_MAP_DATA, updateMapDataHandler, MapEvent );
			
			// 选择地图
			addViewListener( MapEvent.OPEN_SELECTED_ROUND, openSelectedRoundHandler, MapEvent );
			
			initData();
		}
		
		private function initData():void
		{
			updateMapDataHandler();
		}
		
		private function updateMapDataHandler( event:MapEvent = null ):void
		{
			view.setAndUpdateMap( mapModel.mapList );
		}
		
		private function openSelectedRoundHandler( event:MapEvent ):void
		{
			openView( ViewName.SelectedRoundPanel, event.data );
		}
		
		
	}
}