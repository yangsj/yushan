package victor.framework.interfaces
{
	import flash.display.Stage;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-12-1
	 */
	public interface IDebug
	{
		
		function warn( ... args ):void;
		
		function debug( ... args ):void;
		
		function error( ... args ):void;
		
		function printServer( ... args ):void;
		
		function initStage( stage:Stage, pass:String = " " ):void;
		
	}
}