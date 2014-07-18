package app.modules.panel
{
	import flash.display.MovieClip;
	import flash.text.TextField;
	
	import victor.framework.core.BaseView;
	import victor.framework.core.ViewStruct;
	import victor.utils.apps;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-8-28
	 */
	public class PanelLoading extends BaseView
	{
		private var _callStartFun:Function;
		private var _callEndFun:Function;
		
		public var mcProgressBar:MovieClip;
		public var txtProgressValue:TextField;
		
		public function PanelLoading()
		{
			this.graphics.beginFill( 0, 0 );
			this.graphics.drawRoundRect( 0, 0, apps.stageWidth, apps.stageHeight, 0 );
			this.graphics.endFill();
			
			setSkinWithName( "ui_Skin_Preloader" );
			mcProgressBar.gotoAndStop( 1 );
		}
		
		public function setFun( startFun:Function, endFun:Function ):void
		{
			_callStartFun = startFun;
			_callEndFun = endFun;
		}
		
		public function setProgressValue( perent:Number ):void
		{
			txtProgressValue.text = (perent * 100).toFixed( 2 ) + "%";
			mcProgressBar.gotoAndStop( int(perent * 100) );
		}
		
		override public function show():void
		{
			ViewStruct.addChild( this, ViewStruct.LOADING );
			
			apps.mouseChildren = false;
			
			if ( _callStartFun ) _callStartFun();
		}

		override public function hide():void
		{
			super.hide();
			
			apps.mouseChildren = true;
			
			if ( _callEndFun ) _callEndFun();
		}
		
		
		
		private static var _instance:PanelLoading;
		
		public static function get instance():PanelLoading
		{
			return _instance ||= new PanelLoading();
		}
		
		
	}
}