package app.modules.main.command
{
	import app.events.GameEvent;
	import app.modules.ViewName;
	import app.modules.main.view.MainUIMediator;
	import app.modules.main.view.MainUIView;
	
	import victor.framework.core.BaseCommand;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-10
	 */
	public class MainUIInitCommand extends BaseCommand
	{
		public function MainUIInitCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			addView( ViewName.MainUI, MainUIView, MainUIMediator );
			
			commandMap.mapEvent( GameEvent.LEVEL_UP, LevelupCommand, GameEvent );
		}
		
	}
}