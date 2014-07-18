package app.managers
{
	import flash.net.SharedObject;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-22
	 */
	public class SharedObjectManager
	{
		private static var _shareObject:SharedObject;
		
		public function SharedObjectManager()
		{
		}
		
		public static function getData(key:String):Object
		{
			return shareObject.data[key];
		}
		
		public static function setData( key:String, data:Object ):void
		{
			shareObject.data[key] = data;
			shareObject.flush();
		}

		private static function get shareObject():SharedObject
		{
			return _shareObject ||= SharedObject.getLocal("local_cache_data","/");
		}

		
	}
}