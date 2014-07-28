package app.modules.login.register
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import victoryang.core.TabButtons;
	import victoryang.framework.BaseSprite;
	import victoryang.func.apps;
	import victoryang.func.calls;
	import victoryang.func.removedFromParent;
	import victoryang.interfaces.IDisposable;
	import victoryang.uitl.MathUtil;
	
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-10-9
	 */
	public class CheckboxPanel extends BaseSprite implements IDisposable
	{
		public var mcBg:MovieClip;
		
		public var callBackFun:Function;
		
		private var tabControl:TabButtons;
		private var _isOpen:Boolean;
		
		public function CheckboxPanel()
		{
			setSkinWithName( "ui_Skin_CheckBoxPanel" );
			onCloseComplete();
			
//			addEventListener( MouseEvent.CLICK, onClickHandler );
		}
		
		override public function dispose():void
		{
			removeEventListener( MouseEvent.CLICK, onClickHandler );
			apps.removeEventListener(MouseEvent.CLICK, onStageClickHandler );
			if ( tabControl )
				tabControl.dispose();
			tabControl = null;
			callBackFun = null;
		}
		
		public function tweenOpen():void
		{
			_isOpen = true;
			visible = true;
			scaleX = scaleY = 0.01;
			TweenLite.killTweensOf( this );
			TweenLite.to( this, 0.2, {scaleX:1, scaleY:1, ease:Linear.easeNone, onComplete: onOpenComplete} );
		}
		
		public function tweenClose():void
		{
			_isOpen = false;
			apps.removeEventListener(MouseEvent.CLICK, onStageClickHandler );
			TweenLite.killTweensOf( this );
			TweenLite.to( this, 0.2, {scaleX:0.01, scaleY:0.01, ease:Linear.easeNone, onComplete:onCloseComplete} );
		}
		
		public function selectedForItem( index:int ):void
		{
			index = MathUtil.range( index - 1, 0, index );
			tabControl.setTargetByIndex(index);
		}
		
		public function setData( array:Array, isArea:Boolean = true ):void
		{
			var leng:int = array.length;
			tabControl ||= new TabButtons( tabControlHandler );
			for ( var i:int = 0; i < 20; i++ )
			{
				var mc:MovieClip = _skin.getChildByName("item" + i ) as MovieClip;
				if ( i < leng )
				{
					var ary:Array = array[ i ];
					mc.txtLabel.text = ary[ 0 ] + "";
					tabControl.addTarget( mc, ary );
				}
				else
				{
					removedFromParent( mc );
				}
			}
			tabControl.setTargetByIndex(0);
			mcBg.gotoAndStop( isArea ? 1 : 2 );
		}
		
		private function tabControlHandler( clickTarget:MovieClip, data:Object ):void
		{
			if ( data )
			{
				calls( callBackFun, data );
			}
		}
		
		protected function onStageClickHandler(event:MouseEvent):void
		{
			tweenClose();
		}
		
		protected function onClickHandler(event:MouseEvent):void
		{
			event.stopPropagation();
		}
		
		private function onOpenComplete():void
		{
			_isOpen = true;
			apps.addEventListener(MouseEvent.CLICK, onStageClickHandler );
		}
		
		private function onCloseComplete():void
		{
			_isOpen = false;
			visible = false;
			scaleX = scaleY = 0.01;
		}

		public function get isOpen():Boolean
		{
			return _isOpen;
		}

	}
}