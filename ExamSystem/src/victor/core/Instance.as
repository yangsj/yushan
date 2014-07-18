package victor.core
{
	import flash.utils.Dictionary;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2014-6-29
	 */
	public class Instance
	{
		private static const dict:Dictionary = new Dictionary();
		
		/**
		 * 获取指定的实例
		 * @param cls
		 * @return 
		 */
		public static function getInstance( cls:Class ):*
		{
			if ( cls )
			{
				var obj:Object = dict[ cls ];
				if ( obj == null )
				{
					obj = new cls();
					dict[ cls ] = obj;
				}
				return obj;
			}
			return {};
		}
		
		/**
		 * 从池中清除单例
		 * @param cls
		 */
		public static function disposeInstance( cls:Class ):void
		{
			if ( cls )
			{
				delete dict[ cls ];
			}
		}
		
		/**
		 * 是否存在指定单例
		 * @param cls
		 * @return 
		 */
		public static function hasInstance( cls:Class ):Boolean
		{
			if ( cls == null ) return false;
			return dict[ cls ] != null;
		}
		
	}
}