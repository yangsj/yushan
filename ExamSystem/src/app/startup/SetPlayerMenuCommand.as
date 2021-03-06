package app.startup
{
	import app.GameConfig;
	
	import victoryang.core.ContextMenuDefine;
	import victoryang.core.SystemInfo;
	import victoryang.deubg.Debug;
	import victoryang.framework.BaseCommand;
	
	
	/**
	 * …… 设置菜单
	 * @author 	victor 
	 * 			2013-12-23
	 */
	public class SetPlayerMenuCommand extends BaseCommand
	{
		/*============================================================================*/
		/* private variables                                                          */
		/*============================================================================*/
		
		
		
		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/
		public function SetPlayerMenuCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			if ( SystemInfo.isPc )
			{
				Debug.debug( "to set flash player system menu" );
				var vec:Vector.<Array> = new Vector.<Array>();
				vec.push( ["您的客户端版本：" + GameConfig.VERSION, null, false] );
				new ContextMenuDefine( contextView, vec, true );
			}
		}
		
		
	}
}