package app.modules.panel.rank.view
{
	import app.modules.panel.rank.events.RankEvent;
	import app.modules.panel.rank.model.RankModel;
	import app.modules.panel.rank.model.RankVo;
	import app.modules.panel.rank.service.RankService;
	
	import victoryang.framework.BaseMediator;
	
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-9-28
	 */
	public class RankMediator extends BaseMediator
	{
		[Inject]
		public var view:RankView;
		[Inject]
		public var rankModel:RankModel;
		[Inject]
		public var rankService:RankService;
		
		public function RankMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			
			// 拉取到数据
			addContextListener( RankEvent.COMPLETE_NOTITY, completeDataNotify, RankEvent );
			
			// tab标签切换
			addViewListener( RankEvent.CHANGE_TAB, changeTabHandler, RankEvent );
			
			rankModel.clearDictList();
			view.defaultSelected();
		}
		
		private function changeTabHandler( event:RankEvent ):void
		{
			var tabType:int = view.currentTabType;
			var list:Vector.<RankVo> = rankModel.getListByType( tabType );
			if ( list ) {
				setList( list );
			} else {
				rankService.getListByType( tabType );
			}
		}
		
		private function completeDataNotify( event:RankEvent ):void
		{
			var list:Vector.<RankVo> = event.data as Vector.<RankVo>;
			setList( list );
		}
		
		private function setList( list:Vector.<RankVo> ):void
		{
			list ||= new Vector.<RankVo>();
			view.createList( list );
		}
		
		
	}
}