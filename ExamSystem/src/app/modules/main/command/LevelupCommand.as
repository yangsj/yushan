package app.modules.main.command
{
	import app.data.GameData;
	
	import net.victoryang.components.Tips;
	import net.victoryang.framework.BaseCommand;
	
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-10-31
	 */
	public class LevelupCommand extends BaseCommand
	{
		public function LevelupCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			Tips.showCenter( "恭喜你升到 <font color=\"#00cc00\">"+GameData.instance.selfVo.level + "</font> 级！", 35 );
		}
		
	}
}