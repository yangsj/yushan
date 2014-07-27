package app.modules.fight.view.panel
{
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import app.modules.fight.model.FightEndVo;
	import app.modules.util.Num;
	
	import net.victoryang.framework.BasePanel;
	import net.victoryang.func.removedAllChildren;
	

	/**
	 * ……
	 * @author 	victor
	 * 			2013-9-28
	 */
	public class FightResultBasePanel extends BasePanel
	{
		/**
		 * 练习本关 按钮
		 */
		public var btnPractice:SimpleButton;
		/**
		 * 下一关 按钮
		 */
		public var btnNext:SimpleButton;
		/**
		 * 再次挑战 按钮
		 */
		public var btnAgain:SimpleButton;
		/**
		 * 答对单词数量
		 */
		public var txtNumWords:TextField;
		/**
		 * 星级评分mc， 包含3帧
		 */
		public var mcStar:MovieClip;

		public var conExpNum:Sprite;
		public var conMoneyNum:Sprite;

		public function FightResultBasePanel()
		{
			super();
		}

		override protected function onceInit():void
		{
			super.onceInit();

			if ( btnAgain )
				btnAgain.addEventListener( MouseEvent.CLICK, btnAgainHandler );
			if ( btnNext )
				btnNext.addEventListener( MouseEvent.CLICK, btnNextHandler );
			if ( btnPractice )
				btnPractice.addEventListener( MouseEvent.CLICK, btnPracticeHandler );
			if ( btnClose )
				btnClose.addEventListener( MouseEvent.CLICK, btnCloseHandler );
		}

		protected function btnCloseHandler( event:MouseEvent ):void
		{
			dispatchEvent( new FightResultEvent( FightResultEvent.CLOSE ));
		}

		protected function btnPracticeHandler( event:MouseEvent ):void
		{
			dispatchEvent( new FightResultEvent( FightResultEvent.PRACTICE ));
		}

		protected function btnNextHandler( event:MouseEvent ):void
		{
			dispatchEvent( new FightResultEvent( FightResultEvent.NEXT ));
		}

		protected function btnAgainHandler( event:MouseEvent ):void
		{
			dispatchEvent( new FightResultEvent( FightResultEvent.AGAIN ));
		}

		public function setData( endVo:FightEndVo ):void
		{
			removedAllChildren( conExpNum );
			removedAllChildren( conMoneyNum );

			var shapeNum:Shape = Num.getShape( endVo.addExp );
			shapeNum.x = -shapeNum.width * 0.5;
			shapeNum.y = -shapeNum.height * 0.5;
			conExpNum.addChild( shapeNum );

			shapeNum = Num.getShape( endVo.addMoney );
			shapeNum.x = -shapeNum.width * 0.5;
			shapeNum.y = -shapeNum.height * 0.5;
			conMoneyNum.addChild( shapeNum );

			if ( txtNumWords )
			{
				txtNumWords.text = "总计答对 " + endVo.rightNum + " 个单词";
			}
		}
	}
}
