package app.startup
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	import app.modules.ViewName;
	
	import victor.framework.core.BaseCommand;
	import victor.framework.core.ViewStruct;
	import victor.framework.debug.Debug;
	import victor.framework.events.ViewEvent;
	import victor.framework.interfaces.IView;
	import victor.utils.removedFromParent;


	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-8-6
	 */
	public class ShowViewCommand extends BaseCommand
	{
		[Inject]
		public var event:ViewEvent;

		public function ShowViewCommand()
		{
			super();
		}

		override public function execute():void
		{
			if ( event )
			{
				var viewName:String = event.viewName;
				var view:IView;
				if ( event.type == ViewEvent.CLOSE_ALL )
				{
					var container:DisplayObjectContainer = ViewStruct.getContainer( ViewStruct.PANEL );
					if ( container )
					{
						var dis:DisplayObject;
						while ( container.numChildren > 0 )
						{
							dis = container.getChildAt( 0 );
							view = dis as IView;
							if ( view ) {
								view.hide();
							} 
							removedFromParent( dis );
						}
					}
				}
				else if ( viewName )
				{
					var cls:Class = getViewByName( viewName ) as Class;
					if ( cls )
					{
						view = injector.getInstance( cls );
						if ( view )
						{
							if ( event.type == ViewEvent.SHOW )
							{
								view.data = event.data;
								if ( view.parent == null )
									view.show();
								
								Debug.debug( "open view name: " + viewName );
							}
							else if ( event.type == ViewEvent.HIDE )
							{
								if ( view.parent )
									view.hide();
								Debug.debug( "close view name: " + viewName );
							}
						}
					}
					else
					{
						Debug.error( "找不到[" + viewName + "]绑定的类" );
					}
				}
				else
				{
					Debug.error( "viewName不存在！" );
				}
			}
		}
	}
}
