package app.startup
{
	import flash.events.Event;
	
	import app.sound.SoundManager;
	
	import net.victoryang.framework.BaseCommand;
	import net.victoryang.func.apps;
	
	
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2014-1-4
	 */
	public class BackgroundSoundActivateCommand extends BaseCommand
	{
		/*============================================================================*/
		/* private variables                                                          */
		/*============================================================================*/
		
		
		
		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/
		public function BackgroundSoundActivateCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			apps.addEventListener(Event.ACTIVATE, activateHandler );
			apps.addEventListener(Event.DEACTIVATE, deActivateHandler );
		}
		
		protected function activateHandler(event:Event):void
		{
			SoundManager.start();
		}
		
		protected function deActivateHandler(event:Event):void
		{
			SoundManager.pause();
		}
		
		/*============================================================================*/
		/* private functions                                                          */
		/*============================================================================*/
		
		
		
		/*============================================================================*/
		/* protected functions                                                        */
		/*============================================================================*/
		
		
		
		/*============================================================================*/
		/* events handlers                                                            */
		/*============================================================================*/
		
		
		
		/*============================================================================*/
		/* override functions                                                         */
		/*============================================================================*/
		
		
		
		/*============================================================================*/
		/* public functions                                                           */
		/*============================================================================*/
		
		
		
		/*============================================================================*/
		/* public variables                                                           */
		/*============================================================================*/
		
		
		
	}
}