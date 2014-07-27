package app.data
{
	import app.data.item.LevelExpCollection;
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-9-24
	 */
	public class BaseConfig
	{
		private static var _levelExp:LevelExpCollection;
		
		public function BaseConfig()
		{
		}
		
		public static function get levelExp():LevelExpCollection
		{
			return _levelExp ||= new LevelExpCollection();
		}
		
	}
}