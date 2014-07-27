package app.modules.fight.view.prop
{
	import app.data.GameData;
	import app.events.PackEvent;
	import app.modules.fight.FightType;
	import app.modules.fight.events.FightAloneEvent;
	import app.modules.fight.model.FightModel;
	import app.modules.fight.view.spell.SpellEvent;
	import app.modules.model.PackModel;
	import app.modules.model.vo.ItemType;
	import app.modules.model.vo.ItemVo;
	import app.modules.serivce.PackService;
	
	import net.victoryang.components.Tips;
	import net.victoryang.framework.BaseMediator;
	import net.victoryang.managers.TickManager;
	
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-9-27
	 */
	public class PropListMediator extends BaseMediator
	{
		[Inject]
		public var view:PropList;
		[Inject]
		public var packModel:PackModel;
		[Inject]
		public var packService:PackService;
		[Inject]
		public var fightModel:FightModel;
		
		
		public function PropListMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			
			// 使用道具
			addViewListener( PackEvent.USE_ITEM, useItemHandler, PackEvent );
			// 快捷键使用道具
			addContextListener( PackEvent.USE_ITEM, useItemHandler, PackEvent );
			
			// 物品使用成功
			addContextListener( PackEvent.USE_SUCCESS, useItemSuccessHandler, PackEvent );
			// 物品更新
			addContextListener( PackEvent.UPDATE_ITEMS, updatePackItemsHandler, PackEvent );
			// start
			addContextListener( FightAloneEvent.NOTIFY_START_ROUND, nextWordNotify, FightAloneEvent );
			
			if ( fightModel.isBattle ) {
				setData();
			}
		}
		
		private function setData():void
		{
			if ( fightModel.isBattle ) {
				view.setForBattle();
			} else if ( fightModel.isPractice ) {
				view.setFroPractice();
			} else {
				view.setForAlone();
			}
			view.setData( packModel.itemList );
		}
		
		private function nextWordNotify( event:FightAloneEvent ):void
		{
//			view.visible = !fightModel.isPractice;
			setData();
		}
		
		// 物品使用
		private function useItemHandler( event:PackEvent ):void
		{
			var itemVo:ItemVo;
			if ( isNaN(Number(event.data))){
				itemVo = event.data as ItemVo;
			} else {
				var type:int = int(event.data);
				view.keydownUseProp( type );
				return ;
			}
			
			if ( view.isPracticeMode && itemVo.type == ItemType.SKIP ) {
				fightModel.isUsePorped = true;
				dispatch( new SpellEvent( SpellEvent.SHOW_ANSWER ));
				return ;
			}
			
			if ( itemVo.num > 0 || itemVo.contMoney <= GameData.instance.selfVo.money )
			{
				switch ( itemVo.type )
				{
					case ItemType.BROOM:
						if ( fightModel.isHasDisturbForSelf == false ) {
							Tips.showMouse( "当前屏幕中没有需要清楚的干扰因素！！！" );
							return ;
						}
						break;
					case ItemType.SKIP:
						dispatch( new FightAloneEvent( FightAloneEvent.USE_SKIP_INPUT_AUTO ));
						TickManager.doTimeout( useProp, FightType.SKIP_TIME_PER_LETTER * ( fightModel.surplusLetterNum + 1 ), itemVo );
						return ;
						break;
				}
				useProp(itemVo);
			}
			else
			{
				Tips.showMouse( "钻石不足！" );
			}
		}
		
		private function useProp( itemVo:ItemVo ):void
		{
			packService.useItem( itemVo.type );
		}
		
		// 物品使用成功
		private function useItemSuccessHandler( event:PackEvent ):void
		{
			var itemVo:ItemVo = event.data as ItemVo;
			view.refreshItem( itemVo );
		}
		
		private function updatePackItemsHandler( event:PackEvent ):void
		{
			setData();
		}
		
	}
}