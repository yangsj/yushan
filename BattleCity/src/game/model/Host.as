package game.model
{
	import game.interfaces.IElement;
	import game.constant.ConstType;
	
	/**
	 * 
	 * @author victor
	 * 			2014-7-1
	 */
	public class Host extends Model implements IElement
	{
		public function Host()
		{
			uiRes = new UI_V_GamePlayerHostSkin();
			addChild( uiRes );
			
			setPos( ( ConstType.ROW - 1 ) * 0.5 * ConstType.WIDTH, (ConstType.COL - 1.5 ) * ConstType.HEIGHT );
		}
		
		override public function updatePos():void { }
		
		override public function get isEdge():Boolean
		{
			return true;
		}
		
		override public function get modelType():int
		{
			return ConstType.HOST;
		}
		
	}
}