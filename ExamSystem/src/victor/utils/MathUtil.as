package victor.utils
{
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-4
	 */
	public class MathUtil
	{
		public function MathUtil()
		{
		}
		
		/**
		 * 获取指定值在指定区间内
		 * @param value
		 * @param min
		 * @param max
		 * @return 
		 */
		public static function range(value : Number, min : int, max : int) : Number
		{
			if (value < min)
				value = min;
			
			else if (value > max)
				value = max;
			
			return value;
		}
		
		/**
		 * 指定的值是否在指定范围内
		 * @param value
		 * @param min
		 * @param max
		 * @return 
		 */
		public static function isRange(value : Number, min : int, max : int) : Boolean
		{
			if ( value < min || value > max )
				return false;
			
			return true;
		}
		
		/**
		 * 计算距离
		 * @param x1
		 * @param y1
		 * @param x2
		 * @param y2
		 * @return 
		 */
		public static function distance( x1:Number, y1:Number, x2:Number, y2:Number ):Number
		{
			var x:Number = x1 - x2;
			var y:Number = y1 - y2;
			return Math.sqrt( x * x + y * y );
		}
		
	}
}