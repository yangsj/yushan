package app.modules.model
{
	import org.robotlegs.mvcs.Actor;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-24
	 */
	public class CommonModel extends Actor
	{
		public function CommonModel()
		{
			super();
		}
		
		/**
		 * 是否正在加载资源
		 */
		public var isLoading:Boolean = true;
		
	}
}