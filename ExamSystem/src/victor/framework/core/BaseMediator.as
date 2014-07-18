package victor.framework.core
{
	import victor.framework.events.ViewEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-8-5
	 */
	public class BaseMediator extends Mediator
	{
		public function BaseMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			// 打开view
			addViewListener( ViewEvent.SHOW, showViewHandler, ViewEvent );
			// 关闭view
			addViewListener( ViewEvent.HIDE, hideViewHandler, ViewEvent );
		}
		
		protected function hideViewHandler( event:ViewEvent ):void
		{
			closeView( event.viewName );
		}
		
		protected function showViewHandler( event:ViewEvent ):void
		{
			openView( event.viewName, event.data );
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