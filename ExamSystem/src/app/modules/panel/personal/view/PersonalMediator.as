package app.modules.panel.personal.view
{
	import app.modules.model.PackModel;
	
	import victor.framework.core.BaseMediator;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-12
	 */
	public class PersonalMediator extends BaseMediator
	{
		[Inject]
		public var packModel:PackModel;
		[Inject]
		public var view:PersonalPanel;
		
		public function PersonalMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			
			view.propList.setData( packModel.itemList );
		}
		
		
	}
}