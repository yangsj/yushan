package app.modules.panel.rank.view
{
	import flash.events.Event;
	import flash.text.TextField;
	
	import app.modules.panel.rank.model.RankVo;
	
	import net.victoryang.framework.BaseSprite;
	import net.victoryang.uitl.HtmlText;
	
	
	/**
	 * ……0xFF8B31
	 * @author 	victor 
	 * 			2013-11-25
	 */
	public class RankItem extends BaseSprite
	{
		public var txtRank:TextField;  // 名次
		public var txtName:TextField;  // 昵称
		public var txtLevel:TextField; // 等级
		public var txtValidity:TextField;  // 有效期
		public var txtHonor:TextField;// 荣誉
		
		private static const pool:Vector.<RankItem> = new Vector.<RankItem>();
		public static function get instance():RankItem
		{
			if ( pool && pool.length > 0 )
				return pool.pop();
			return new RankItem();
		}
		
		public function RankItem()
		{
			setSkinWithName( "ui_Skin_RankItem" );
			mouseEnabled = false;
			mouseChildren = false;
			cacheAsBitmap = true;
		}
		
		protected function removedFromParentHandler(event:Event):void
		{
			removeEventListener( Event.REMOVED, removedFromParentHandler );
			if ( pool )
				pool.push( this );
		}
		
		public function setData( data:RankVo ):void
		{
			addEventListener( Event.REMOVED, removedFromParentHandler );
			
			txtRank.htmlText = getTextColorResult(data.rank.toString(), data.isSelf);
			txtName.htmlText = getTextColorResult(data.name, data.isSelf);
			txtLevel.htmlText = getTextColorResult("Lv." + data.level, data.isSelf);
			txtValidity.htmlText = getTextColorResult(data.validity, data.isSelf);
			txtHonor.htmlText = getTextColorResult(data.honor.toString(), data.isSelf);
		}
		
		private function getTextColorResult(msg:String, isSelf:Boolean ):String
		{
			return isSelf ? HtmlText.color(msg, 0xFF8B31) : msg;
		}
		
	}
}