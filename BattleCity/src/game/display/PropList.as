package game.display
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import game.interfaces.IDispose;
	import game.uitl.removeFromParent;
	
	/**
	 * 
	 * @author victor
	 * 			2014-7-2
	 */
	public class PropList extends Sprite implements IDispose
	{
		private var uiRes:UI_V_GamePropList;
		private var types:Vector.<int> = new Vector.<int>();
		
		public function PropList()
		{
			x = 835.80;
			y = 348.45;
			
			uiRes = new UI_V_GamePropList();
			addChild( uiRes );
		}
		
		public function dispose():void
		{
			clear();
			removeFromParent( this );
		}
		
		public function clear():void
		{
			types.length = 0;
			refreshDisplay();
		}
		
		private function refreshDisplay():void
		{
			var item:MovieClip;
			for ( var i:int = 0; i < 5; i++ )
			{
				item = uiRes["item_" + i];
				item.visible = i < types.length;
				item.icon.gotoAndStop( i < types.length ? types[i] : 1 );
			}
		}
		
		public function checkExsit( type:int ):Boolean
		{
			for each ( var id:int in types )
			{
				if ( id == type ) return true;
			}
			return false;
		}
		
		public function addProp( type:int ):void
		{
			removeProp( type );
			types.push( type );
			refreshDisplay();
		}
		
		public function removeProp( type:int ):void
		{
			for ( var i:int = 0; i < types.length; i++ )
			{
				if ( type == types[i] )
				{
					types.splice( i, 1 );
					break;
				}
			}
			refreshDisplay();
		}
		
		
	}
}