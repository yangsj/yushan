package app.modules.fight.view.alone
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	import app.core.Tips;
	import app.modules.fight.model.LetterBubbleVo;
	import app.modules.fight.view.FightBaseView;
	import app.modules.fight.view.item.LetterBubble;
	
	import victor.utils.removeAllChildren;
	
	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-9-27
	 */
	public class FightAloneView extends FightBaseView
	{
		protected var bgContainer:Sprite;
		
		public function FightAloneView()
		{
			super();
		}
		
		protected function resetText():void
		{
		}

		override protected function onceInit():void
		{
			super.onceInit();
			resetText();
			bgContainer = new Sprite();
			addChildAt( bgContainer, 0 );
		}
		
		override public function initialize( isPractice:Boolean = false ):void
		{
			selfCurrentTime = 120;
			super.initialize( isPractice );
		}

		override public function delLetterFromDict( letter:String, isSelf:Boolean = true ):void
		{
			var ary:Array = dictLetterSelf[ letter.toLocaleLowerCase()];
			if ( ary && ary.length > 0 )
			{
				ary.shift();
				dictLetterSelf[ letter.toLocaleLowerCase()] = ary;
			}
			else
			{
				delete dictLetterSelf[ letter.toLocaleLowerCase()];
			}
		}
		
		public function setBg(mapId:int):void
		{
			if ( bgContainer.numChildren != 1 || this.mapId != mapId )
			{
				removeAllChildren( bgContainer );
				bgContainer.addChild( getObj( "ui_Skin_MapChapterBg_" + mapId ) as DisplayObject );
			}
			this.mapId = mapId;
		}

		override public function setLettersPool( list:Vector.<LetterBubbleVo>, isSelf:Boolean = true ):void
		{
			points=[[69.3, 48.4],[150.1, 48.4],[230.9, 48.4],[311.7, 48.4],[392.5, 48.4],[473.3, 48.4],[554.1, 48.4],[634.9, 48.4],[715.7, 48.4],[69.3, 240],[150.1, 240],[230.9, 240],[311.7, 240],[392.5, 240],[473.3, 240],[554.1, 240],[634.9, 240],[715.7, 240],[69.3, 144.2],[150.1, 144.2],[230.9, 144.2],[311.7, 144.2],[392.5, 144.2],[473.3, 144.2],[554.1, 144.2],[634.9, 144.2],[715.7, 144.2],[69.3, 335.8],[150.1, 335.8],[230.9, 335.8],[311.7, 335.8],[392.5, 335.8],[473.3, 335.8],[554.1, 335.8],[634.9, 335.8],[715.7, 335.8],[69.3, 431.6],[150.1, 431.6],[230.9, 431.6],[311.7, 431.6],[392.5, 431.6],[473.3, 431.6],[554.1, 431.6],[634.9, 431.6],[715.7, 431.6]];
			dictLetterSelf = new Dictionary();
			removeAllChildren( container, false );
			var key:String;
			var bubble:LetterBubble;
			var point:Array;
			for each ( var vo:LetterBubbleVo in list )
			{
				point = points.splice(int(Math.random() * points.length), 1)[0];
				key = vo.letter.toLocaleLowerCase();
				bubble = LetterBubble.itemInstance;
				bubble.scaleX = 1;
				bubble.scaleY = 1;
				bubble.setMoveArea( isAlone );
				bubble.setData( vo );
				bubble.x = point[0];
				bubble.y = point[1];
				container.addChild( bubble );
				dictLetterSelf[ key ] ||= [];
				dictLetterSelf[ key ].push( bubble );
			}
		}
		
		/**
		 * 使用时间道具
		 */
		override public function useExtraTimeProp( isSelf:Boolean = true ):void
		{
			if ( isSelf )
			{
				selfCurrentTime += 5;
				Tips.showCenter( "时间 +5s" );
			}
		}

		override public function setRoundName( roundName:String ):void
		{
			txtName.htmlText = roundName;
		}
		
		override protected function enterFrameHandler( event:Event = null ):void
		{
			hitTestCheck( container );
		}
		
		override protected function get resNames():Array
		{
			return[ 
					"map_chapter_bg", 
					"ui_fight", 
					"ui_prop_list"
				];
		}

		override protected function get skinName():String
		{
			return "ui_Skin_Round_MainPanel";
		}
	}
}
