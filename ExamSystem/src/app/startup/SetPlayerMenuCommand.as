package app.startup
{
	import app.GameConfig;
	
	import victor.core.ContextMenuDefine;
	import victor.framework.core.BaseCommand;
	import victor.framework.debug.Debug;
	
	
	/**
	 * …… 设置菜单
	 * @author 	yangsj 
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
			Debug.debug( "to set flash player system menu" );
			var vec:Vector.<Array> = new Vector.<Array>();
			vec.push( ["您的客户端版本：" + GameConfig.VERSION, null, false] );
			new ContextMenuDefine( contextView, vec, true );
		}
		
		
	}
}