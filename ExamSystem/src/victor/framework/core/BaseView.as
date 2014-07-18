package victor.framework.core
{
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import victor.framework.interfaces.IView;
	import victor.utils.removedFromParent;

	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-8-5
	 */
	public class BaseView extends BaseSprite implements IView
	{
		protected var _data:Object;
		protected var rectangle:Rectangle;
		protected var _isInit:Boolean = false;

		public function BaseView()
		{
			super();

			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler, false, int.MAX_VALUE );
			addEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler );
			
			firstRun();
		}
		
		protected function firstRun():void
		{
			createSkin();
		}
		
		protected function removedFromStageHandler( event:Event ):void
		{
		}

		protected function addedToStageHandler( event:Event ):void
		{
		}
		
		/**
		 * 创建资源
		 */
		protected function createSkin():void
		{
			if ( _isInit == false )
			{
				setSkinWithName( skinName, domainName );
				rectangle = this.getBounds( this );
				rectangle = new Rectangle( rectangle.x, rectangle.y, rectangle.width, rectangle.height );
				onceInit();
				_isInit = true;
			}
		}

		protected function onceInit():void
		{
		}

		override public function dispose():void
		{
			removedFromParent( _skin );
			removeEventListener( Event.ADDED_TO_STAGE, addedToStageHandler );
			removeEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler );
			_skin = null;
			_data = null;
		}

		public function hide():void
		{
			ViewStruct.removeChild( this );
		}

		public function show():void
		{
			throw new Error( "重写show" );
		}

		public function get data():Object
		{
			return _data;
		}

		public function set data( value:Object ):void
		{
			_data = value;
		}

		/**
		 * 皮肤名称
		 */
		protected function get skinName():String
		{
			return "";
		}

		/**
		 * 指定资源加载的域名称（默认当前域）
		 */
		protected function get domainName():String
		{
			return "";
		}


	}
}
