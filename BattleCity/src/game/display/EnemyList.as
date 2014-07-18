package game.display
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import game.interfaces.IDispose;
	import game.constant.ConstType;
	import game.uitl.removeFromParent;
	
	/**
	 * 
	 * @author victor
	 * 			2014-7-2
	 */
	public class EnemyList extends Sprite implements IDispose
	{
		private var uiRes:UI_V_GameMonsterList;
		private var list:Array;
		
		public function EnemyList()
		{
			x = 854.80;
			y = 61.50;
			
			uiRes = new UI_V_GameMonsterList();
			addChild( uiRes );
			
			refreshDisplay();
		}
		
		private function refreshDisplay():void
		{
			var item:MovieClip;
			for ( var i:int = 0; i < ConstType.MONSTER_MAX_NUM; i++ )
			{
				item = uiRes["monster_" + i];
				item.visible = list && i < list.length ? true : false;
				item.gotoAndStop(list && i < list.length ? list[i] : 1 );
			}
		}
		
		public function dispose():void
		{
			clear();
			removeFromParent( this );
		}
		
		public function clear():void
		{
			list = [];
			refreshDisplay();
		}
		
		public function setData( list:Array ):void
		{
			this.list = list;
			refreshDisplay();
		}
		
		public function get enemyId():int
		{
			var index:int = Math.random() * list.length;
			var id:int = list.splice( index, 1 );
			refreshDisplay();
			return id;
		}
		
		public function get isOvered():Boolean
		{
			return list.length == 0;
		}
		
	}
}