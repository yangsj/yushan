package app.modules.main.view
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import app.data.BaseConfig;
	import app.data.vo.LevelExpItemVo;
	import app.modules.main.FunctionBtnConfig;
	import app.sound.SoundManager;
	import app.sound.SoundType;
	
	import net.victoryang.core.Numeric;
	import net.victoryang.events.ViewEvent;
	import net.victoryang.framework.BaseView;
	import net.victoryang.framework.ViewStruct;
	import net.victoryang.func.removedAllChildren;
	import net.victoryang.managers.LoaderManager;
	import net.victoryang.uitl.MathUtil;
	
	
	/**
	 * ……
	 * @author 	victor 
	 * 			2013-9-10
	 */
	public class MainUIView extends BaseView
	{
		// 等级数字显示容器
		public var levelContainer:Sprite;
		// 经验条
		public var expBar:MovieClip;
		// 经验值显示文本
		public var txtExp:TextField;
		
		// 上一次更新的经验值
		private var expCache:int = -1;
		// 上一次更新的等级
		private var levelCache:int = -1;
		// 缓存等级数字对象
		private var levelNumCreate:Numeric;
		// 等级资源
		private var levelNumSprite:Shape;
		// 经验值显示内容
		private var expNumString:String = "0/0";
		// 经验值百分比显示内容
		private var expPercent:String = "0%";
		// 点击对战按钮弹出的菜单
		private var fightMenu:FightButtonMenu;
		
		public var markTaskClip:ExclamatoryMarkEffect;
		
		public function MainUIView()
		{
			addedToStageHandler( null );
			txtExp ||= new TextField();
			txtExp.mouseEnabled = false;
			expBar.addEventListener(MouseEvent.ROLL_OVER, expBarMouseHandler );
			expBar.addEventListener(MouseEvent.ROLL_OUT,  expBarMouseHandler );
		}
		
		protected function expBarMouseHandler(event:MouseEvent):void
		{
			txtExp.text = event.type == MouseEvent.ROLL_OUT ? expPercent : expNumString;
		}
		
		public function displayTaskMark():void
		{
			markTaskClip ||= new ExclamatoryMarkEffect();
			addChild( markTaskClip );
			markTaskClip.visible = true;
			markTaskClip.start();
		}
		
		public function hideTaskMark():void
		{
			if ( markTaskClip )
			{
				markTaskClip.stop();
				markTaskClip.visible = false;
			}
		}
		
		public function displayFightMenu():void
		{
			fightMenu ||= new FightButtonMenu();
			addChild( fightMenu );
			fightMenu.show();
		}
		
		public function updateLevelExp( level:int, exp:int ):void
		{
			if ( expCache != exp )
			{
				var levelExpItemVo:LevelExpItemVo = BaseConfig.levelExp.getItemByExp( exp );
				var curExp:int = levelExpItemVo.curExp;
				var nextExp:int = levelExpItemVo.nextExp;
				var c:int = (exp - curExp );
				var t:int = (nextExp - curExp);
				var percent:Number;
				expCache = exp;
				expNumString = c + "/" + t;
				if ( !MathUtil.isRange( exp, curExp, nextExp ))
				{
					percent = 100;
					expPercent = "100%";
				}
				else
				{
					percent = (c/t) * 100;
					expPercent = percent.toFixed( 0 ) + "%";
				}
				expBar.gotoAndStop( int(percent) );
				txtExp.text = expPercent;
			}
			if ( level != levelCache )
			{
				levelCache = level;
				levelNumCreate ||= new Numeric(LoaderManager.getObj( "ui_Skin_LevelNumber" ) as MovieClip);
				levelNumSprite = levelNumCreate.creatNumber( level );
				levelNumSprite.x = -levelNumSprite.width >> 1;
				removedAllChildren( levelContainer );
				levelContainer.addChild( levelNumSprite );
			}
		}
		
		override protected function onceInit():void
		{
			var list:Array = FunctionBtnConfig.functionBtnsList;
			for each (var btnName:String in list )
			{
				var dis:DisplayObject = _skin[ btnName ] as DisplayObject;
				if ( dis )
				{
					if ( dis.hasOwnProperty("mouseChildren"))
						dis["mouseChildren"] = false;
					if ( dis.hasOwnProperty("buttonMode"))
						dis["buttonMode"] = true;
					
					if ( btnName == FunctionBtnConfig.EXIT ) dis.visible = false;
					
					dis.addEventListener(MouseEvent.CLICK, onClickFunsBtnHandler );
				}
			}
		}
		
		protected function onClickFunsBtnHandler(event:MouseEvent):void
		{
			SoundManager.playEffectMusic( SoundType.CLICK01 );
			dispatchEvent( new ViewEvent( ViewEvent.SHOW, event.target.name ));
		}
		
		override public function show():void
		{
			ViewStruct.addChild( this, ViewStruct.MAIN );
		}
		
		override protected function get skinName():String
		{
			return "ui_Skin_MainMenu";
		}
		
	}
}