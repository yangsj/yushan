package victor.framework.core
{
	import flash.utils.Dictionary;
	
	import victor.framework.events.ViewEvent;
	
	import org.robotlegs.mvcs.Command;
	
	
	/**
	 * ……
	 * @author yangsj
	 */
	public class BaseCommand extends Command
	{
		private static const dictViews:Dictionary = new Dictionary();
		
		public function BaseCommand()
		{
			super();
		}
		
		protected function addView( viewName:String, view:Class, mediator:Class ):void
		{
			mapView( view, mediator );
			if ( viewName )
				dictViews[ viewName ] = view;
		}
		
		protected function mapView( view:Class, mediator:Class ):void
		{
			mediatorMap.mapView( view, mediator );
			injector.mapSingleton( view );
		}
		
		protected function injectActor( clazz:Class ):void
		{
			var obj:Object = injector.instantiate( clazz );
			injector.mapValue( clazz, obj );
		}
		
		protected function getViewByName( viewName:String ):Class
		{
			return dictViews[ viewName ];
		}
		
		protected function openView( viewName:String, data:Object = null ):void
		{
			dispatch( new ViewEvent( ViewEvent.SHOW, viewName, data ));
		}
		
		protected function closeView( viewName:String ):void
		{
			dispatch( new ViewEvent( ViewEvent.HIDE, viewName ));
		}
		
	}
}