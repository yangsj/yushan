package game.interfaces
{
	
	/**
	 * 
	 * @author victor
	 * 			2014-7-1
	 */
	public interface IBullet extends IModel
	{
		
		/**
		 * 是否是玩家发射的子弹
		 */
		function get isPlayer():Boolean;
		
		/**
		 * 通过模型类型判定是否可以移除[是否是己方]
		 * @param modelType
		 * @return 
		 */
		function isRemoveByModelType( model:int ):Boolean;
		
	}
}