package app.core.components.controls.combo
{
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-9-7
	 */
	public class ComboData
	{
		public function ComboData()
		{
		}
		
		public var list:Vector.<ComboItemVo> = new Vector.<ComboItemVo>();
		
		public function addItem( itemVo:ComboItemVo ):void
		{
			list.push( itemVo );
		}
		
	}
}