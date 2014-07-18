package victor.framework.interfaces
{
	import flash.display.DisplayObjectContainer;

	/**
	 * ……
	 * @author 	yangsj
	 * 			2014-1-4
	 */
	public interface IBasePanel
	{
		function show():void;
		function hide():void;

		function get parent():DisplayObjectContainer;

		/**
		 * 当前面板是否可点透的
		 * @return
		 */
		function get isPenetrate():Boolean;
		function set isPenetrate( value:Boolean ):void;

		/**
		 * 面板增加的黑底的透明度  0~1
		 * @return
		 */
		function get maskAlpha():Number;
		function set maskAlpha( value:Number ):void;
	}
}
