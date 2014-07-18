package game.interfaces
{
	
	/**
	 * 
	 * @author victor
	 * 			2014-7-1
	 */
	public interface IEnemy extends IModel
	{
		/**
		 * 改变方向
		 */
		function changeDirection():void;
		
		function startAction():void;
		function stopAction():void;
		
		/**
		 * 获得的分数
		 */
		function get score():int;
	}
}