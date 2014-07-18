package victor.core
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;

	import victor.framework.debug.Debug;


	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-8-27
	 */
	public class Reflection
	{

		/**
		 * 映射
		 * @param target
		 * @param skin
		 */
		public static function reflection( target:Object, skin:DisplayObject ):void
		{
			var skinContainer:DisplayObjectContainer = skin as DisplayObjectContainer;
			if ( target == null || skinContainer == null )
				return;

			var xml:XML = describeType( target );
			var variables:XMLList = xml.child( "variable" );
			var name:String;
			var tmp:DisplayObject;
			for each ( var item:XML in variables )
			{
				name = item.@name.toString();
				try
				{
					tmp = skinContainer.getChildByName( name );
					if ( tmp )
					{
						target[ name ] = tmp;
					}
				}
				catch ( e:Error )
				{
					Debug.error( "[Reflection.reflection]" + name + ":" + e );
					continue;
				}
			}
		}

		/**
		 * 销毁映射
		 * @param target
		 */
		public static function disposeReflection( target:Object ):void
		{
			if ( target == null )
			{
				return;
			}

			var xml:XML = describeType( target );
			var variables:XMLList = xml.child( "variable" );
			var name:String;
			for each ( var item:XML in variables )
			{
				name = item.@name.toString();
				try
				{
					target[ name ] = null;
				}
				catch ( e:Error )
				{
					Debug.error( "[Reflection.reflection]" + name + ":" + e );
					continue;
				}
			}
		}

	}
}
