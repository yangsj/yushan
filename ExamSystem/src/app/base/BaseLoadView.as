package app.base
{
	import app.modules.panel.PanelLoading;
	
	import victor.framework.events.PanelEvent;
	import victor.framework.manager.LoaderManager;
	import victor.framework.core.BaseView;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-27
	 */
	public class BaseLoadView extends BaseView
	{
		public function BaseLoadView()
		{
			super();
		}
		
		override final protected function firstRun():void
		{
		}
		
		override final public function show():void
		{
			if ( resNames && resNames.length == 0 )
				addDisplayList();
			else startLoadResource();
		}
		
		private function startLoadResource():void
		{
			dispatchEvent( new PanelEvent( PanelEvent.LOAD_START ));
			PanelLoading.instance.show();
			LoaderManager.instance.load( resNames, addDisplayList, loadProgress, domainName );
		}
		
		private function loadProgress( perent:Number ):void
		{
			PanelLoading.instance.setProgressValue( perent );
		}
		
		private function addDisplayList():void
		{
			PanelLoading.instance.hide();
			
			dispatchEvent( new PanelEvent( PanelEvent.LOAD_END ));
			
			createSkin();
			
			beforeRender();
			
			addToParent();
			
			afterRender();
		}
		
		/**
		 * 添加到显示列表前
		 */
		protected function beforeRender():void
		{
		}
		
		/**
		 * 添加到显示列表
		 */
		protected function addToParent():void
		{
		}
		
		/**
		 * 添加到显示列表后
		 */
		protected function afterRender():void
		{
		}
		
		/**
		 * 需要加载的资源在配置文件中名称清单，若是该数组的长度是0，则默认不加载
		 */
		protected function get resNames():Array
		{
			return [];
		}
	}
}