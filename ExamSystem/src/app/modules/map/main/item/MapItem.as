package app.modules.map.main.item
{
	
	import com.greensock.TweenLite;
	import com.greensock.easing.Back;
	
	import flash.display.InteractiveObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import app.modules.map.event.MapEvent;
	import app.modules.map.model.MapVo;
	
	import victoryang.components.Tips;
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-9-24
	 */
	public class MapItem extends MapItemBase
	{
		private var mapVo:MapVo;
		private var tips:MovieClip;
		private var txtTips:TextField;
		private var bgTips:Sprite;
		private var btn:InteractiveObject;
		
		public function MapItem( skin:MovieClip )
		{
			super( skin );
			skin.mouseChildren = true;
			skin.mouseEnabled = false;
			tips = skin.getChildByName( "tips" ) as MovieClip || new MovieClip();
			txtTips = tips.getChildByName( "txt" ) as TextField || new TextField();
			bgTips = tips.getChildByName( "bg" ) as Sprite || new Sprite();
			btn = skin.getChildByName( "btn" ) as InteractiveObject || new Sprite();
			tips.mouseEnabled = false;
			tips.mouseChildren = false;
			btn.addEventListener(MouseEvent.ROLL_OVER, mouseHandler );
			btn.addEventListener(MouseEvent.ROLL_OUT , mouseHandler );
			tips.visible = false;
		}
		
		protected function mouseHandler(event:MouseEvent):void
		{
			var type:String = event.type;
			if ( type == MouseEvent.ROLL_OVER ) {
				btn.addEventListener(MouseEvent.MOUSE_MOVE, mouseHandler );
				tips.visible = true;
				tips.x = skin.mouseX;
				tips.y = skin.mouseY;
			} else if ( type == MouseEvent.ROLL_OUT ) {
				tips.visible = false;
			} else if ( type == MouseEvent.MOUSE_MOVE ) {
				TweenLite.killTweensOf( tips );
				TweenLite.to( tips, 0.5, {x: skin.mouseX, y: skin.mouseY, ease: Back.easeOut });
			}
		}
		
		override protected function onClickHandler(event:MouseEvent):void
		{
			if ( event.target.name == "btn" )
			{
				super.onClickHandler( event );
				if ( isOpen )
					skin.dispatchEvent( new MapEvent( MapEvent.OPEN_SELECTED_ROUND, mapVo, true ));
				else Tips.showMouse( "当前地图还没有开启，你需要更多的星星才能开启！" );
			}
		}
		
		public function setAndUpdateData( mapVo:MapVo ):void
		{
			this.mapVo = mapVo;
			skin.gotoAndStop( isOpen ? FRAME_OPEN : FRAME_CLOSE );
			txtTips.text = mapVo.mapName;
			txtTips.width = txtTips.textWidth + 20;
			txtTips.x = -( txtTips.width >> 1 );
			bgTips.width = txtTips.width;
			tips.cacheAsBitmap = true;
		}
		
		/**
		 * 地图开启的
		 */
		public function get isOpen():Boolean
		{
			return mapVo.isOpen;
		}
		
		/**
		 * 地图未开启
		 */
		public function get isClose():Boolean
		{
			return !mapVo.isOpen;
		}
		
		
	}
}