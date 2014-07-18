package app.modules.map.panel.item
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import app.core.Tips;
	import app.modules.map.main.item.MapItemBase;
	import app.modules.map.model.RoundVo;
	import app.modules.map.panel.event.SelectedRoundEvent;
	
	import victor.core.Reflection;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-25
	 */
	public class RoundItem extends MapItemBase
	{
		private var roundVo:RoundVo;
		
		public var mcStar:MovieClip;
		public var mcTarget:MovieClip;
		public var txtIndex:TextField;
		private var index:int;
		
		public function RoundItem( skin:MovieClip, index:int )
		{
			super( skin );
			Reflection.reflection( this, skin );
			this.index = index;
			txtIndex.text = index.toString();
			mcStar.stop();
			mcTarget.stop();
		}
		
		override protected function onClickHandler(event:MouseEvent):void
		{
			super.onClickHandler( event );
			if ( roundVo )
			{
				if ( roundVo.isOpen )
					skin.dispatchEvent( new SelectedRoundEvent( SelectedRoundEvent.SELECTED_ROUND, roundVo, true ));
				else Tips.showMouse( "你还没有开启当前关卡，继续积累更多星星吧！" );
			}
			else
			{
				Tips.showMouse( "没有地图数据！可能未初始化" );
			}
		}
		
		public function setData( roundVo:RoundVo ):void
		{
			this.roundVo = roundVo;
			
			if ( roundVo.starNum == 0 || !roundVo.isOpen)
				mcStar.visible = false;
			else
			{
				mcStar.visible = true;
				mcStar.gotoAndStop( roundVo.starNum );
			}
			
			mcTarget.gotoAndStop( roundVo.isOpen ? 1 : 2 );
			
		}
		
		override public function dispose():void
		{
			super.dispose();
			roundVo = null;
			mcStar = null;
			mcTarget = null;
		}
		
	}
}