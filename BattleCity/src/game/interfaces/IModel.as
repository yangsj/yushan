package game.interfaces
{
	
	/**
	 * 
	 * @author victor
	 * 			2014-7-1
	 */
	public interface IModel extends IElement
	{
		
		/**
		 * 获取敌方被击中受到的伤害
		 */
		function get attackHp():int;
		
		/**
		 * 是否是死亡的
		 */
		function get isDeath():Boolean;
		function set isDeath(value:Boolean):void;
		
		/**
		 * 受攻击的
		 * @param hp
		 */
		function injured( hp:int, isForce:Boolean = false ):void;
		
	}
}