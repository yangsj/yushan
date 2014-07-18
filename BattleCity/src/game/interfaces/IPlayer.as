package game.interfaces
{
	
	/**
	 * 
	 * @author victor
	 * 			2014-7-1
	 */
	public interface IPlayer extends IModel
	{
		/**
		 * 校正键盘弹起需要移动的位置
		 */
		function adjustMove():void
		
		function shoot():void;
		function stopShoot():void;
		
		/**
		 * 复活
		 */
		function resurgence():void;
		
		function setPropType( propType:int, func:Function = null):void;
		
		function get isKeyDown():Boolean;
		function set isKeyDown( value:Boolean ):void;
		
	}
}