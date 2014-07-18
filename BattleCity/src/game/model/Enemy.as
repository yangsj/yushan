package game.model
{
	import com.greensock.TweenLite;
	import game.interfaces.IEnemy;
	import game.constant.ConstType;
	
	/**
	 * 
	 * @author victor
	 * 			2014-6-30
	 */
	public class Enemy extends Model implements IEnemy
	{
		private var isStart:Boolean = true;
		
		public function Enemy( type:int, direction:int = 0 )
		{
			super( type, direction );
		}
		
		override protected function initParams():void
		{	
			uiRes = new UI_V_GameEnemySkin();
			addChild( uiRes );
			
			isStart = true;
			
			TweenLite.delayedCall( 3, shoot );
			TweenLite.delayedCall( 5, changeDirection );
		}
		
		private function shoot():void
		{
			var bullet:Bullet = new Bullet( false, 1, direction );
			if ( this.parent )
			{
				var w:Number = ConstType.WIDTH * 0.5;
				var h:Number = ConstType.HEIGHT * 0.5;
				bullet.x = isUp || isDown ? x : ( isLeft ? x - w : x + w );
				bullet.y = isLeft || isRight ? y : ( isUp ? y - h : y + h );
				this.parent.addChild( bullet );
			}
			
			TweenLite.delayedCall( Math.random() * 5 + 5, shoot );
		}
		
		public function changeDirection():void
		{
			direction = ConstType.getRandomDirection( direction );
			TweenLite.killDelayedCallsTo( changeDirection );
			TweenLite.delayedCall( Math.random() * 4 + 4, changeDirection );
		}
		
		public function startAction():void
		{
			if ( isStart == false )
			{
				isStart = true;
				TweenLite.delayedCall( Math.random() * 5 + 5, shoot );
				TweenLite.delayedCall( Math.random() * 4 + 4, changeDirection );
			}
		}
		
		public function stopAction():void
		{
			if ( isStart )
			{
				isStart = false;
				TweenLite.killDelayedCallsTo( shoot );
				TweenLite.killDelayedCallsTo( changeDirection );
			}
		}
		
		override public function updatePos():void
		{
			if ( isStart )
			{
				super.updatePos();
				if ( uiRes )
					uiRes.rotation = 90 * direction;
			}
		}
		
		override public function dispose():void
		{
			TweenLite.killDelayedCallsTo( changeDirection );
			TweenLite.killDelayedCallsTo( shoot );
			super.dispose();
		}
		
		override public function set direction(value:int):void
		{
			_direction = value;
		}
		
		override public function set type(value:int):void
		{
			_type = value;
			_totalHp = value;
			if ( uiRes ) uiRes.gotoAndStop( type );
		}
		
		override public function get modelType():int
		{
			return ConstType.ENEMY;
		}
		
		override public function get attackHp():int
		{
			return 1;
		}
		
		public function get score():int
		{
			return 500 * type;
		}

		
	}
}