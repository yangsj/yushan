package app.modules.fight.view.spell
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import app.modules.fight.events.FightAloneEvent;
	import app.modules.fight.model.LetterBubbleVo;
	
	import victoryang.interfaces.IDisposable;
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-9-27
	 */
	public class SpellItem implements IDisposable
	{
		private const FRAME_OPEN:String = "frame_open";
		private const FRAME_CLOSE:String = "frame_close";
		
		private var skin:MovieClip;
		public var txtLetter:TextField;
		
		private var _data:LetterBubbleVo;
		private var _index:int;
		
		public function SpellItem( skin:MovieClip, index:int = 0 )
		{
			this.skin = skin;
			this.index = index;
			this.skin.mouseChildren = false;
			this.skin.buttonMode = true;
			this.skin.stop();
			this.skin.addEventListener( MouseEvent.CLICK, onClickHandler );
			this.txtLetter = skin.getChildByName( "txtLetter" ) as TextField;
		}
		
		protected function onClickHandler(event:MouseEvent):void
		{
			if ( _data )
				this.skin.dispatchEvent( new FightAloneEvent( FightAloneEvent.REMOVED_LETTER, _data ));
		}
		
		public function initialize():void
		{
			txtLetter.text = "";
		}
		
		public function setData( itemVo:LetterBubbleVo ):void
		{
			_data = itemVo;
			if ( _data ) txtLetter.text = _data.letter;
		}
		
		public function dispose():void
		{
			if ( skin )
				skin.removeEventListener( MouseEvent.CLICK, onClickHandler );
			skin = null;
			_data = null;
		}
		
		public function get data():LetterBubbleVo
		{
			return _data;
		}
		
		public function get visible():Boolean
		{
			return skin.visible;
		}
		
		public function set visible( value:Boolean ):void
		{
			skin.visible = value;
		}

		public function get index():int
		{
			return _index;
		}

		public function set index(value:int):void
		{
			_index = value;
		}


	}
}