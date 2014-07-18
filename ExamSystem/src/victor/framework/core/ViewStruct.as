package victor.framework.core
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	import victor.framework.interfaces.IBasePanel;
	import victor.utils.apps;
	import victor.utils.removedFromParent;

	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-8-1
	 */
	public class ViewStruct
	{
		private static var numCount:uint = 0;

		public static const BACKGROUND:uint = numCount++;//背景层
		public static const SCENE:uint = numCount++;//场景层
		public static const MAIN:uint = numCount++;//主ui层
		public static const SCENE2:uint = numCount++;//场景层2
		public static const CHAT:uint = numCount++;//聊天层
		public static const PANEL:uint = numCount++;//面板弹出层
		public static const CHAT2:uint = numCount++;//聊天层
		public static const EFFECT:uint = numCount++;//特效播放层
		public static const DRAG:uint = numCount++;//对象拖拽层
		public static const ALERT:uint = numCount++;//警告提示层
		public static const TIPS:int = numCount++;//tips显示层
		public static const LOADING:uint = numCount++;//loading层

		private static var container:Sprite;
		private static var maskSprite:Sprite;

		public function ViewStruct()
		{
		}

		public static function initialize( displayObjectContainer:DisplayObjectContainer ):void
		{
			if ( container == null )
			{
				var sprite:Sprite;
				displayObjectContainer.addChild( container = new Sprite());
				container.mouseEnabled = false;
				for ( var i:uint = 0; i < numCount; i++ )
				{
					sprite = new Sprite();
					sprite.mouseEnabled = false;
					container.addChild( sprite );
				}
				getContainer( TIPS ).mouseChildren = false;
				getContainer( BACKGROUND ).mouseChildren = false;
				getContainer( EFFECT ).mouseChildren = false;
				getContainer( DRAG ).mouseChildren = false;
				
				maskSprite = new Sprite();
				maskSprite.graphics.beginFill( 0, 1.0 );
				maskSprite.graphics.drawRect( 0, 0, apps.stageWidth, apps.stageHeight );
				maskSprite.graphics.endFill();
				maskSprite.mouseChildren = false;
			}
		}

		/**
		 * 添加到场景图层显示列表，只能存在一个场景
		 * @param scene
		 */
		public static function addScene( scene:DisplayObject ):void
		{
			removeAll( SCENE );
			addChild( scene, SCENE );
		}

		/**
		 * 添加到面板图层显示列表
		 * @param panel
		 */
		public static function addPanel( panel:IBasePanel ):void
		{
			if ( panel )
			{
				var con:Sprite = getContainer( PANEL ) as Sprite;
				if ( con != panel.parent )
				{
					maskSprite.mouseEnabled = !panel.isPenetrate;
					maskSprite.alpha = panel.isPenetrate ? 0 : panel.maskAlpha;
					con.addChild( maskSprite );
					con.addChild( panel as DisplayObject );
				}
			}
		}
		
		/**
		 * 从显示列表移除面板
		 * @param panel
		 */
		public static function removePanel( panel:IBasePanel ):void
		{
			if ( panel && panel.parent )
			{
  				var con:DisplayObjectContainer = panelContainer;
				var isSet:Boolean = panel == con.getChildAt(con.numChildren - 1);
				removedFromParent( panel as DisplayObject );
				if ( isSet )
				{
					removedFromParent( maskSprite );
					if ( con.numChildren > 0 )
					{
						var temp:IBasePanel = con.getChildAt( con.numChildren - 1 ) as IBasePanel;
						if ( temp )
						{
							maskSprite.mouseEnabled = !temp.isPenetrate;
							maskSprite.alpha = temp.isPenetrate ? 0 : temp.maskAlpha;
							con.addChildAt( maskSprite, con.numChildren - 1 );
						}
					}
				}
			}
		}

		/**
		 * 添加到指定的图层显示列表
		 * @param child
		 * @param containerType
		 * 
		 */
		public static function addChild( child:DisplayObject, containerType:uint ):void
		{
			if ( child )
			{
				if ( containerType == PANEL )
				{
					addPanel( child as IBasePanel );
				}
				else
				{
					try
					{
						var spr:Sprite = container.getChildAt( containerType ) as Sprite;
					}
					catch ( e:Error )
					{
						throw e;
					}
					if ( spr )
					{
						if ( child.parent != spr )
							spr.addChild( child );
					}
				}
			}
		}

		/**
		 * 从显示列表移除显示对象
		 * @param child
		 */
		public static function removeChild( child:DisplayObject ):void
		{
			if ( child )
			{
				if ( child.parent == getContainer( PANEL ) )
					removePanel( child as IBasePanel );
				else removedFromParent( child );
			}
		}

		/**
		 * 将指定图层子对象全部移除显示列表
		 * @param containerType
		 */
		public static function removeAll( containerType:uint ):void
		{
			try
			{
				var sprite:Sprite = container.getChildAt( containerType ) as Sprite;
			}
			catch ( e:Error )
			{
			}
			if ( sprite )
			{
				sprite.removeChildren();
			}
			if ( containerType == PANEL )
			{
				sprite.graphics.clear();
			}
		}
		
		/**
		 * 获取指定图层显示容器
		 * @param containerType
		 * @return 
		 */
		public static function getContainer( containerType:uint ):DisplayObjectContainer
		{
			return container.getChildAt( containerType ) as DisplayObjectContainer;
		}
		
		public static function get panelContainer():DisplayObjectContainer
		{
			return getContainer( PANEL );
		}


	}
}
