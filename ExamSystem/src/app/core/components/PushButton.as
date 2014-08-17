package app.core.components
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import victoryang.interfaces.IDisposable;
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-9-25
	 */
	public class PushButton implements IDisposable
	{
		private var skin:MovieClip;
		
		public function PushButton( skin:MovieClip )
		{
			this.skin = skin;
			this.skin.mouseChildren = false;
			this.skin.buttonMode = true;
			this.skin.addEventListener( MouseEvent.ROLL_OVER, rollHandler );
			this.skin.addEventListener( MouseEvent.ROLL_OUT,  rollHandler );
			this.skin.dispatchEvent( new MouseEvent( MouseEvent.ROLL_OUT ));
		}
		
		protected function rollHandler(event:MouseEvent):void
		{
			this.skin.gotoAndStop( event.type == MouseEvent.ROLL_OVER ? "frame_over" : "frame_out" );
		}
		
		public function dispose():void
		{
			if ( this.skin )
			{
				this.skin.removeEventListener( MouseEvent.ROLL_OVER, rollHandler );
				this.skin.removeEventListener( MouseEvent.ROLL_OUT,  rollHandler );
			}
			this.skin = null;
		}
	}
}