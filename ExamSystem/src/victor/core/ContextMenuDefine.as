package victor.core
{
	import flash.display.InteractiveObject;
	import flash.events.ContextMenuEvent;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import flash.utils.Dictionary;
	
	import victor.framework.debug.Debug;
	import victor.utils.calls;

	/**
	 * ……player 右键菜单设置
	 * @author 	yangsj
	 * 			2013-12-23
	 */
	public class ContextMenuDefine
	{
		/*============================================================================*/
		/* private variables                                                          */
		/*============================================================================*/

		private static var myContextMenu:ContextMenu;
		private var dictLabels:Dictionary;

		private const defaultName:String = "http://blog.163.com/acsh_ysj/";

		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/
		/**
		 *
		 * @param interactive
		 * @param labels labels[0]=[label display name, callback function, separatorBefore]
		 */
		public function ContextMenuDefine( interactive:InteractiveObject, labels:Vector.<Array> = null, isDefaultDisplay:Boolean = false )
		{
			if ( isDefaultDisplay )
			{
				if ( labels == null )
				{
					labels = new Vector.<Array>();
				}
				labels.unshift([ defaultName, defaultCallback, true ]);
			}
			if ( !myContextMenu )
			{
				myContextMenu = new ContextMenu();
				removeDefaultItems();
			}
			initLabelsData( labels );
			if ( interactive )
			{
				interactive.contextMenu = myContextMenu;
			}
		}

		private function initLabelsData( labels:Vector.<Array> ):void
		{
			dictLabels = new Dictionary();
			if ( labels )
			{
				for each ( var ary:Array in labels )
				{
					if ( ary.length < 3 )
					{
						ary.length = 3;
					}
					var key:String = ary[ 0 ];
					dictLabels[ key ] = ary[ 1 ] as Function;
					addCustomMenuItems( key, Boolean( ary[ 2 ]));
					Debug.debug( "player menu:" + key );
				}
			}
		}

		private function removeDefaultItems():void
		{
			myContextMenu.hideBuiltInItems();
			myContextMenu.builtInItems.print = true;
		}

		private function addCustomMenuItems( label:String = defaultName, separatorBefore:Boolean = false ):void
		{
			var item:ContextMenuItem = new ContextMenuItem( label );
			myContextMenu.customItems.push( item );
			item.separatorBefore = separatorBefore;
			item.addEventListener( ContextMenuEvent.MENU_ITEM_SELECT, selectedHandler );
		}

		protected function selectedHandler( event:Event ):void
		{
			var caption:String = event.currentTarget.caption;
			calls( dictLabels[ caption ] as Function );
			Debug.debug( caption );
		}

		private function defaultCallback():void
		{
			navigateToURL( new URLRequest( "http://blog.163.com/acsh_ysj/" ), "_blank" );
		}

	}
}
