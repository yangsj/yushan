package game.interfaces
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	/**
	 * 
	 * @author victor
	 * 			2014-7-1
	 */
	public interface IElement extends IDispose
	{
		
		/**
		 * 设置元素的位置
		 * @param sx
		 * @param xy
		 */
		function setPos(sx:Number, sy:Number):void;
		
		/**
		 * 更新元素的位置
		 */
		function updatePos():void;
		
		/**
		 * 是否在其周围
		 * @param element
		 */
		function isRange( element:IElement):Boolean;
		
		/**
		 * 碰撞检测对象
		 */
		function get hitTarget():DisplayObject;
		
		/**
		 * 元素当前所在行号
		 */
		function get col():int;
		
		/**
		 * 元素当前所在列号
		 */
		function get row():int;
		
		/**
		 * 是否到达边缘
		 */
		function get isEdge():Boolean;
		
		/**
		 * 未到达边缘 则 获取下一个点的行号
		 */
		function get nextCol():int;
		
		/**
		 * 未达到边缘 则 获取下一个点的列号
		 */
		function get nextRow():int;
		
		/**
		 * 模型类型
		 */
		function get modelType():int;
		
		/**
		 * 能被子弹销毁的
		 */
		function get isCanBullet():Boolean;

		/**
		 * 元素类型
		 */
		function get type():int;
		function set type(value:int):void;

		/**
		 * 当前方向
		 */
		function get direction():int;
		function set direction(value:int):void;

		/**
		 * 移动速度
		 */
		function get speed():Number;
		function set speed(value:Number):void;
		
		/**
		 * 是否需要处理的
		 */
		function get isDispose():Boolean;
		function set isDispose(value:Boolean):void;
		
		function get x():Number;
		function set x(value:Number):void;
		
		function get y():Number;
		function set y(value:Number):void;
		
		function get parent():DisplayObjectContainer;
	}
}