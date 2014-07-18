package app.modules.map.panel
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.utils.Dictionary;
	
	import app.base.BasePanel;
	import app.core.ButtonSkin;
	import app.modules.map.model.ChapterVo;
	import app.modules.map.model.MapVo;
	import app.modules.map.panel.item.GroupItem;
	
	import victor.core.Reflection;
	import victor.utils.DisplayUtil;
	import victor.utils.removeAllChildren;
	import victor.utils.removedFromParent;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-22
	 */
	public class SelectedRoundView extends BasePanel
	{
		private var skinDict:Dictionary = new Dictionary();
		private var vecList:Vector.<GroupItem>;
		private var bgSkin:Sprite;
		
		public var mapVo:MapVo;
		public var mcTitleName:MovieClip;
		public var tipsTxt:TextField;
		
		public function SelectedRoundView()
		{
		}
		
		override protected function onceInit():void
		{
			removedFromParent( btnClose );
			btnClose = ButtonSkin.buttonExit;
			_skin.addChild( btnClose );
		}
		
		override protected function addedToStageHandler(event:Event):void
		{
			super.addedToStageHandler( event );
			mcTitleName.gotoAndStop( mapVo.mapId + 1 );
		}
		
		override protected function removedFromStageHandler(event:Event):void
		{
			super.removedFromStageHandler( event );
			clearGroupItems();
		}
		
		override protected function createSkin():void
		{
			removeAllChildren( this );
			// 
			_skin = skinDict[ skinName ];
			if ( _skin == null )
			{
				_isInit = false;
				super.createSkin();
				skinDict[ skinName ] = _skin;
			}
			else 
			{
				addChild( _skin );
				Reflection.reflection( this, _skin );
			}
			createGroupItems();
			
			// 创建背景
			bgSkin = skinDict[ bgSkinName ];
			if ( bgSkin == null )
			{
				bgSkin = getObj( bgSkinName ) as Sprite;
				skinDict[ bgSkinName ] = bgSkin;
			}
			addChildAt( bgSkin, 0 );
		}
		
		override protected function transitionIn():void
		{
		}
		
		override protected function transitionOut( delay:Number = 0.3 ):void
		{
			super.transitionOut( 0 );
		}
		
		private function clearGroupItems():void
		{
			if ( vecList )
			{
				while ( vecList.length > 0 )
					vecList.pop().dispose();
				vecList = null;
			}
		}
		
		private function createGroupItems():void
		{
			clearGroupItems();
			vecList = new Vector.<GroupItem>();
			var mcGroup:MovieClip;
			var groupItem:GroupItem;
			for (var i:int = 0; i < 10; i++ )
			{
				mcGroup = _skin.getChildByName( "c" + i ) as MovieClip;
				groupItem = new GroupItem( mcGroup, i );
				vecList.push( groupItem );
			}
		}
		
		private function setListData(list:Vector.<ChapterVo> ):void
		{
			mapVo.chapterList = list;
			var groupItem:GroupItem;
			for ( var i:int = 0; i < 10; i++ )
			{
				groupItem = vecList[ i ];
				groupItem.setData( list[ i ] );
			}
		}
		
		private function setTipsText(curNum:int, totalNum:int ):void
		{
			if ( tipsTxt )
			{
				var tipsStr:String = "";
				tipsTxt.visible = totalNum != 0;
				if ( curNum < totalNum ) 
				{
					tipsStr = "当前已获得 "+curNum+" 颗星, 还需 "+(totalNum - curNum)+" 颗星开启下一章节";
					//tipsTxt.htmlText = HtmlText.color( "当前已获得 "+curNum+" 颗星, 还需 "+(totalNum - curNum)+" 颗星开启下一章节", HtmlText.Red);
				} 
				else 
				{
					tipsStr = "当前已获得 "+curNum+" 颗星";
					//tipsTxt.htmlText = HtmlText.color( "当前已获得 "+curNum+" 颗星", HtmlText.Green);
				}
				tipsTxt.text = tipsStr;
			}
		}
		
		public function setData( mapvo:MapVo ):void
		{
			setListData( mapvo.chapterList );
			setTipsText( mapvo.currentStarNum, mapvo.totalStarNum );
		}
		
		override public function set data(value:Object):void
		{
			super.data = value;
			mapVo = value as MapVo;
		}
		
		override protected function get resNames():Array
		{
			return ["map_chapter_bg", "map_chapter_list" ];
		}
		
		override protected function get skinName():String
		{
			return "ui_Skin_MapChapterRoundList";
		}
		
		protected function get bgSkinName():String
		{
			return "ui_Skin_MapChapterBg_" + mapVo.mapId;
		}
		
	}
}