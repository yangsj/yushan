package game.model
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import game.constant.ConstType;
	import game.interfaces.IPlayer;
	import game.uitl.calls;
	
	/**
	 * 
	 * @author victor
	 * 			2014-6-30
	 */
	public class Player extends Model implements IPlayer
	{
		private var _isKeyDown:Boolean;
		
		private var isCooling:Boolean = false;
		private var isTweening:Boolean = false;
		private var bulletType:int = 1;
		private var isInvincible:Boolean = false;
		private var dictFunc:Dictionary;
		private var isMoving:Boolean = false;
		
		public function Player()
		{	
			super();
		}
		
		override protected function initParams():void
		{
			uiRes = new UI_V_GameSelfModelSkin();
			addChild( uiRes );
			resurgence();
		}
		
		public function resurgence():void
		{
			_isDeath = false;
			_isDispose = false;
			isCooling = false;
			isTweening = false;
			isInvincible = false;
			isMoving = false;
			isKeyDown = false;
			speed = 4;
			totalHp = 1;
			bulletType  = ConstType.BULLET_1;
			direction = ConstType.UP;
			setPos( 7 * ConstType.WIDTH, 11 * ConstType.HEIGHT );
			delayCallFuncComplete( bulletType );
		}
		
		public function setPropType( propType:int, func:Function = null ):void
		{
			if ( dictFunc == null ) dictFunc = new Dictionary();
			
			var time:Number = 0;
			switch  ( propType )
			{
				case ConstType.PROP_ITEM_1: // 变钢墙
					time = ConstType.PROP_ITEM_TIME_1;
					break;
				case ConstType.PROP_ITEM_2: // 停止enemy动作
					time = ConstType.PROP_ITEM_TIME_2;
					break;
				case ConstType.PROP_ITEM_3: // 导弹
					time = ConstType.PROP_ITEM_TIME_3;
					bulletType = ConstType.BULLET_2;
					break;
				case ConstType.PROP_ITEM_4: // 炸弹
					time = ConstType.PROP_ITEM_TIME_4;
					break;
				case ConstType.PROP_ITEM_5: // 无敌
					time = ConstType.PROP_ITEM_TIME_5;
					isInvincible = true;
					break;
			}
			delete dictFunc[propType];
			if ( time > 0 )
			{
				dictFunc[propType] = func;
				TweenLite.delayedCall( time, delayCallFuncComplete, [ propType ] );
			}
		}
		
		private function delayCallFuncComplete( propType:int ):void
		{
			if ( dictFunc )
			{
				calls( dictFunc[propType], propType );			
				if ( propType == ConstType.PROP_ITEM_3 )
				{
					bulletType = ConstType.BULLET_1;
				}
				else if ( propType == ConstType.PROP_ITEM_5 )
				{
					isInvincible = false;
				}
			}
		}
		
		private function setModelAnimation( isPlay:Boolean ):void
		{
			var dis:DisplayObject;
			var mc:MovieClip;
			var index:int = 0;
			while ( mc == null && index < uiRes.numChildren )
			{
				dis = uiRes.getChildAt( index );
				if ( dis.hasOwnProperty("mc") )
				{
					mc = dis["mc"] as MovieClip;
					if ( mc ) break;
				}
				index++;
			}
			if ( mc )
			{
				if ( isPlay ) mc.gotoAndPlay( 1 );
				else mc.gotoAndStop( 1 );
			}
		}
		
		override public function dispose():void
		{
			super.dispose();
			TweenLite.killDelayedCallsTo( delayCallFuncComplete );
			dictFunc = null;
		}
		
		public function shoot():void
		{
			if ( isCooling == false )
			{
				isCooling = true;
				
				trace( bulletType + "]子弹类型：：：[" + bulletType );
				var bullet:Bullet = new Bullet( true, bulletType, direction );
				if ( this.parent )
				{
					var w:Number = ConstType.WIDTH * 0.5;
					var h:Number = ConstType.HEIGHT * 0.5;
					bullet.x = isUp || isDown ? x : ( isLeft ? x - w : x + w );
					bullet.y = isLeft || isRight ? y : ( isUp ? y - h : y + h );
					this.parent.addChild( bullet );
				}
				
				TweenLite.delayedCall( 1, shoot );
				TweenLite.delayedCall( 0.5, function():void
				{
					isCooling = false;
				});
			}
		}
		
		public function stopShoot():void
		{
			TweenLite.killDelayedCallsTo( shoot );
		}
		
		public function adjustMove():void
		{
			return ;
			var tw:Number = ConstType.WIDTH;
			var th:Number = ConstType.HEIGHT;
			var tx:Number = tw * row;
			var ty:Number = th * col;
			var time:Number = 0;
			var dist:Number = 0;
			var floatNum:Number = 0.4;
			var endPos:Point = new Point(tx, ty);
			switch ( direction )
			{
				case ConstType.UP:
					if ( ty < y )
					{
						dist = Math.abs( endPos.y - y );
						if ( dist < ConstType.HEIGHT * floatNum ) dist = 0; 
					}
					break;
				case ConstType.DOWN:
					if ( ty > y )
					{
						endPos.y = th * nextCol;
						dist = Math.abs( endPos.y - y );
						if ( dist < ConstType.HEIGHT * floatNum ) dist = 0;
					}
					break;
				case ConstType.LEFT:
					if ( tx < x ) 
					{
						dist = Math.abs( endPos.x - x );
						if ( dist < ConstType.WIDTH * floatNum ) dist = 0;
					}
					break;
				case ConstType.RIGHT:
					if ( tx < x )
					{
						endPos.x = tw * nextRow;
						dist = Math.abs( endPos.x - x );
						if ( dist < ConstType.WIDTH * floatNum ) dist = 0;
					}
					break;
			}
			isTweening = false;
			if ( dist != 0 )
			{
				isTweening = true;
				time = ( dist / 24 ) / speed;
				TweenLite.to( this, time, { x:endPos.x, y:endPos.y, onComplete:function():void
					{
						isTweening = false;
					}, ease:Linear.easeNone } );
			}
		}
		
		override public function injured(hp:int, isForce:Boolean=false):void
		{
			if ( !isInvincible )
			{
				super.injured( hp, isForce );
			}
		}
		
		override public function updatePos():void
		{
			if ( _isKeyDown && isTweening == false )
			{
				super.updatePos();
			}
		}
		
		override public function get modelType():int
		{
			return ConstType.PLAYER;
		}
		
		override public function get attackHp():int
		{
			return 2;
		}
		
		override public function set direction(value:int):void
		{
			if ( !isTweening ) 
			{
				super.direction = value;
			}
		}
		
		override public function get hitTarget():DisplayObject
		{
			if ( _hitTarget == null )
			{
				var sp:Sprite = new Sprite();
				sp.graphics.beginFill( 0, 0 );
				sp.graphics.drawCircle( 0, 0, ConstType.WIDTH * 0.4 );
				sp.graphics.endFill();
				_hitTarget = sp;
			}
			return _hitTarget;
		}

		public function get isKeyDown():Boolean
		{
			return _isKeyDown;
		}

		public function set isKeyDown(value:Boolean):void
		{
			_isKeyDown = value;
			if ( value && isMoving == false )
			{
				isMoving = true;
				setModelAnimation( true );
			}
			else if ( !value )
			{
				isMoving = false;
				setModelAnimation( false );
			}
		}

	}
}