package game
{
	import com.greensock.TweenLite;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import game.data.LevelInfo;
	import game.data.LevelVo;
	import game.skin.DefendFailedEffect;
	import game.uitl.apps;
	import game.uitl.calls;
	import game.interfaces.IBullet;
	import game.interfaces.IElement;
	import game.interfaces.IEnemy;
	import game.interfaces.IModel;
	import game.interfaces.IPlayer;
	import game.interfaces.IPropItem;
	import game.interfaces.IWall;
	import game.model.Enemy;
	import game.model.Player;
	import game.model.PropItem;
	import game.model.Wall;
	import game.constant.ConstType;
	import game.display.BulletEffect;
	import game.display.EnemyList;
	import game.display.PropList;
	import game.model.Host;
	import game.uitl.removeAllChildren;
	import game.uitl.removeFromParent;
	
	/**
	 * 
	 * @author victor
	 * 			2014-6-30
	 */
	public class LogicController
	{
		private var effectContainer:Sprite;
		private var modelContainer:Sprite;
		
		private var curMapArray:Array;
		
		private var player:IPlayer;
		private var playerHost:IElement;
		
		private var failedFunc:Function;
		private var passRoundFunc:Function;
		private var refreshScore:Function;
		private var refreshEnemy:Function;
		private var propList:PropList;
		private var enemyList:EnemyList;
		
		private var levelConfig:LevelVo;
		
		private var createEnemyNum:int = 0;
		private var needKillEnemyNum:int = 0;
		private var isInitPropTimer:Boolean = true;
		private var isOvered:Boolean = false;
		private var initEnemyPos:Array = [];
		private var totalScore:int;
		
		public function LogicController( effectContainer:Sprite, modelContainer:Sprite, failedFunc:Function, passRoundFunc:Function, refreshScore:Function, refreshEnemy:Function )
		{
			this.effectContainer = effectContainer;
			this.modelContainer  = modelContainer;
			this.failedFunc 	 = failedFunc;
			this.passRoundFunc	 = passRoundFunc;
			this.refreshScore	 = refreshScore;
			this.refreshEnemy	 = refreshEnemy;
			
			propList = new PropList();
			enemyList = new EnemyList();
			modelContainer.parent.addChild( propList );
			modelContainer.parent.addChild( enemyList );
			
			clear();
		}
		
		public function clear():void
		{	
			apps.removeEventListener(Event.ENTER_FRAME, enterFrameHandler );
			apps.removeEventListener( KeyboardEvent.KEY_DOWN, keyboardHandler );
			apps.removeEventListener( KeyboardEvent.KEY_UP  , keyboardHandler );
			
			TweenLite.killDelayedCallsTo( startDelayCreateProp );
			
			effectContainer.graphics.clear();
			removeAllChildren( effectContainer );
			removeAllChildren( modelContainer );
			if ( curMapArray )
			{
				for ( var col:int = 0; col < ConstType.COL; col++ )
				{
					if ( curMapArray[col] )
					{
						for ( var row:int = 0; row < ConstType.ROW; row++ )
						{
							curMapArray[col][row] = null;
						}
					}
					curMapArray[col] = null;
				}
			}
			if ( player )
			{
				player.dispose();
			}
			if ( playerHost )
			{
				playerHost.dispose();
			}
			if ( propList )
			{
				propList.clear();
			}
			if ( enemyList )
			{
				enemyList.clear();
			}
			curMapArray = null;
		}
		
		public function destroy():void
		{
			clear();
		}
		
		public function setData( level:int ):void
		{
			clear();
			
			isInitPropTimer = true;
			isOvered = false;
			
			levelConfig = LevelInfo.getLevelInfoByLevel( level );
			curMapArray = levelConfig.curMapArray;
			
			var wall:Wall;
			var arr:Array = curMapArray[0];
			for ( var i:int = 0; i < arr.length; i++ )
			{
				if ( arr[i] == 0 )
				{
					initEnemyPos.push( i );
				}
			}
			
			for ( var col:int = 0; col < ConstType.COL; col++ )
			{	
				for ( var row:int = 0; row < ConstType.ROW; row++ )
				{	
					var id:int = curMapArray[col][row];
					if ( id > 0 )
					{
						wall = Wall.create( id, ConstType.WIDTH * row, ConstType.HEIGHT * col );
						modelContainer.addChild( wall );
						curMapArray[col][row] = wall;
					}
				}
			}
			
			playerHost = new Host();
			modelContainer.addChild( playerHost as DisplayObject );
			
			player = new Player();
			modelContainer.addChild( player as DisplayObject );
			
			needKillEnemyNum = levelConfig.enemyList.length;
			enemyList.setData( levelConfig.enemyList );
			
			updateEnemyNum();
		}
		
		private function startDelayCreateProp():void
		{
//			return ;
			if ( !isInitPropTimer )
			{
				var index:int = Math.random() * levelConfig.propList.length;
				var propId:int = levelConfig.propList[index];
				if ( !propList.checkExsit( propId ) )
				{
					var item:PropItem = new PropItem( propId );
					var boo:Boolean = true;
					while ( boo || ( !checkTargetPointIsEmpty( item ) && curMapArray[rc][rr] ) )
					{
						var rc:int = int( Math.random() * (ConstType.COL - 6) + 3 );
						var rr:int = int( Math.random() * ConstType.ROW );
						var sx:Number = rr * ConstType.WIDTH;
						var sy:Number = rc * ConstType.HEIGHT;
						item.setPos( sx, sy );
						boo = false;
					}
					modelContainer.addChildAt( item, modelContainer.numChildren - 2 );
				}
			}
			TweenLite.delayedCall( Math.random() * 10 + 15, startDelayCreateProp );
			isInitPropTimer = false;
		}

		private function checkTargetPointIsEmpty( target:IElement ):Boolean
		{
			if ( target )
			{
				var leng:int = modelContainer.numChildren;
				var element:IElement;
				var tx:Number = target.x;
				var ty:Number = target.y;
				var dw:Number = ConstType.WIDTH;
				var dh:Number = ConstType.HEIGHT;
				for ( var i:int = 0; i < leng; i++ )
				{
					element = modelContainer.getChildAt( i ) as IElement;
					if ( element && element != target )
					{
						if ( !isAtRange( element.x, tx - dw, tx + dw ) && !isAtRange( element.y, ty - dh, ty + dh ))
						{
							return true;
						}
					}
				}
			}
			return false;
		}
		
		private function isAtRange( a:Number, min:Number, max:Number ):Boolean
		{
			return a > min && a < max;
		}
		
		public function startGame():void
		{
			startTimer();
			addKeyboardEvent();
			
			for ( var i:int = 0; i < 4; i++ )
			{
				createRandomEnemy();
			}
			
			if (levelConfig.propList && levelConfig.propList.length > 0 )
			{
				trace( "创建道具计时器" );
				startDelayCreateProp();
			}
		}
		
		private function createRandomEnemy():void
		{
			if ( initEnemyPos.length > 0 )
			{
				var enemy:Enemy = new Enemy( enemyList.enemyId, ConstType.DOWN );
				var rRow:int = initEnemyPos[createEnemyNum % initEnemyPos.length ];
				enemy.setPos( rRow * ConstType.WIDTH, 0 );
				modelContainer.addChildAt( enemy, modelContainer.numChildren - 2 );
				createEnemyNum++;
			}
		}
		
		private function updateEnemyNum():void
		{
			calls( refreshEnemy, needKillEnemyNum );
		}
		
		private function passRound():void
		{
			if ( isOvered == false )
			{
				isOvered = true;
				
				totalScore += ConstType.PASS_ROUND_REWARD_SCORE;
				calls( passRoundFunc, totalScore );
			}
		}
		
		private function gameEndResult():void
		{
			trace( "你的老家被敌方端掉了1111111111111111111111111" );
			effectContainer.addChild( new DefendFailedEffect( failedFunc ) );
		}
		
		private function getElementByPos( target:IElement ):IElement
		{
			var element:IElement;
			if ( target )
			{
				var px:Number = target.x;
				var py:Number = target.y;
				var leng:int = modelContainer.numChildren;
				for ( var i:int = 0; i < leng; i++ )
				{
					element = modelContainer.getChildAt( i ) as IElement;
					if ( element && element.modelType != ConstType.BULLET && target != element && target.isRange( element ) )
					{
						return element;
					}
				}
			}
			return null;
		}
		
		private function startTimer():void
		{
			apps.addEventListener(Event.ENTER_FRAME, enterFrameHandler );
		}
		
		private function addKeyboardEvent():void
		{
			apps.addEventListener( KeyboardEvent.KEY_DOWN, keyboardHandler );
			apps.addEventListener( KeyboardEvent.KEY_UP  , keyboardHandler );
		}
		
		protected function keyboardHandler(event:KeyboardEvent):void
		{
			var keyCode:uint = event.keyCode;
			var dire:int = -1;
			var isShoot:Boolean = false;
			var isDire:Boolean = false;
			switch ( event.keyCode )
			{
				case Keyboard.W:
				case Keyboard.UP:
					dire = ConstType.UP;
					break;
				case Keyboard.S:
				case Keyboard.DOWN:
					dire = ConstType.DOWN;
					break;
				case Keyboard.D:
				case Keyboard.RIGHT:
					dire = ConstType.RIGHT;
					break;
				case Keyboard.A:
				case Keyboard.LEFT:
					dire = ConstType.LEFT;
					break;
				case Keyboard.SPACE:
					isShoot = true;
					break;
			}
			isDire = dire != -1;
			if ( event.type == KeyboardEvent.KEY_DOWN )
			{
				if ( isShoot )
				{
					player.shoot();
				}
				else if ( isDire )
				{
					player.isKeyDown = false;
					player.direction = dire;
					if ( player.isEdge == false )
					{
						var temp:IElement = getElementByPos( player );
						var bullet:IBullet = temp as IBullet;
						var prop:IPropItem = temp as IPropItem;
						if ( !temp || bullet || prop )
						{
							player.isKeyDown = true;
						}
					}
				}
			}
			else 
			{
				if ( isShoot )
				{
					player.stopShoot();
				}
				else if ( isDire ) 
				{
					player.adjustMove();
					player.isKeyDown = false;
				}
			}
		}		
		
		protected function enterFrameHandler(event:Event):void
		{
			var dis:IElement;
			var enemy:IEnemy;
			var bullet:IBullet;
			var wall:IWall;
			var leng:int = modelContainer.numChildren;
			for ( var i:int = 0; i < leng; i++ )
			{
				dis = modelContainer.getChildAt( i ) as IElement;
				enemy = ( dis as IEnemy );
				bullet = ( dis as IBullet );
				wall = ( dis as IWall );
				if ( dis )
				{
					if ( enemy )
					{
						if ( enemy.isEdge || getElementByPos( enemy ))
						{
							enemy.changeDirection();
						}
						else
						{
							enemy.updatePos();
						}
					}
					else
					{
						if ( bullet && bullet.isDispose == false )
						{
							var element:IModel = getElementByPos( dis ) as IModel;
							if ( element && element.isCanBullet )
							{
								if ( bullet.isRemoveByModelType( element.modelType ) )
								{
									if ( element.hitTarget.hitTestObject( bullet.hitTarget ) )
									{
										element.injured( bullet.attackHp, ( ( element is IWall ) && bullet.type == ConstType.BULLET_2 ) );
										bullet.isDispose = true;
										
										var sx:Number = bullet.x;
										var sy:Number = bullet.y;
										var rw:Number = ConstType.WIDTH * 0.5;
										var rh:Number = ConstType.HEIGHT* 0.5;
										switch ( bullet.direction )
										{
											case ConstType.UP:
												sy -= rh;
												break;
											case ConstType.DOWN:
												sy += rh;
												break;
											case ConstType.LEFT:
												sx -= rw;
												break;
											case ConstType.RIGHT:
												sx += rw;
												break;
										}
										
										var effect:BulletEffect = new BulletEffect( bullet.type );
										effect.setPos( sx, sy );
										effectContainer.addChild( effect );
									}
								}
							}
						}
						
						if ( dis != player )
						{
							dis.updatePos();
						}
					}
					
					if ( dis.isDispose )
					{
						if ( dis.modelType == ConstType.HOST )
						{
							gameEndResult();
						}
						else if ( enemy && enemy.isDeath )
						{
							totalScore += enemy.score;
							calls( refreshScore, totalScore );
							needKillEnemyNum--;
							updateEnemyNum();
						}
						else if ( wall )
						{
							curMapArray[dis.col][dis.row] = 0;
						}
						removeFromParent( dis as DisplayObject );
						dis.dispose();
						leng--;
						i--;
					}
				}
			}
			
			if ( player.isDeath )
			{
				player.resurgence();
			}
			else if ( player.isKeyDown )
			{
				var pTemp:IElement = getElementByPos( player ) as IElement;
				var prop:IPropItem = pTemp as IPropItem;
				if ( 	
						player.isEdge || 
						!pTemp || 
						prop || 
						pTemp.modelType == ConstType.BULLET )
				{
					player.updatePos();
				}
				// 检查是否是道具
				if ( prop )
				{
					// 是否和道具发生碰撞
					if ( player.hitTarget.hitTestObject( prop.hitTarget ) )
					{
						prop.isDispose = true;
						if ( prop.type != ConstType.PROP_ITEM_4 )
						{
							propList.addProp( prop.type );
						}
						player.setPropType( prop.type, callBackForUseProp );
						switch  ( prop.type )
						{
							case ConstType.PROP_ITEM_1: // 变钢墙
								setHostWallStatus( 2 );
								break;
							case ConstType.PROP_ITEM_2: // 停止enemy动作
								startAndStopAllEnemy( false );
								break;
							case ConstType.PROP_ITEM_3: // 导弹
								break;
							case ConstType.PROP_ITEM_4: // 炸弹
								killAllEnemy();
								break;
							case ConstType.PROP_ITEM_5: // 无敌
								break;
						}
					}
				}
			}
			
			var enemyNum:int = curEnemyNum;
			if ( !enemyList.isOvered && enemyNum < 4 )
			{
				createRandomEnemy();
			}
			else 
			{
				if ( enemyList.isOvered && enemyNum== 0 )
				{
					passRound();
				}
			}
		}
		
		///////////////////////////// 
		
		private function callBackForUseProp( propType:int ):void
		{
			switch  ( propType )
			{
				case ConstType.PROP_ITEM_1: // 变钢墙
					setHostWallStatus( 1 );
					break;
				case ConstType.PROP_ITEM_2: // 停止enemy动作
					startAndStopAllEnemy( true );
					break;
				case ConstType.PROP_ITEM_3: // 导弹
					break;
				case ConstType.PROP_ITEM_4: // 炸弹
					return ;
				case ConstType.PROP_ITEM_5: // 无敌
					break;
			}
			propList.removeProp( propType );
		}
		
		/**
		 * 更改为钢铁墙
		 */
		private function setHostWallStatus( type:int ):void
		{
			var col:int = ConstType.COL;
			var row:int = ConstType.ROW;
			var sr:int  = (row - 4) * 0.5 - 1;
			var er:int  = sr + 5;
			var element:IElement;
			for ( var c:int = col - 4; c < col; c++ )
			{
				for ( var r:int = sr; r < er; r++ )
				{
					element = curMapArray[c][r] as IElement;
					if ( element )
					{
						element.type = type;
					}
				}
			}
		}
		
		/**
		 * 定身道具使用 和 恢复
		 */
		private function startAndStopAllEnemy( isStart:Boolean = true ):void
		{
			var leng:int = modelContainer.numChildren;
			var element:IEnemy;
			for ( var i:int = 0; i < leng; i++ )
			{
				element = modelContainer.getChildAt( i ) as IEnemy;
				if ( element )
				{
					if ( isStart ) element.startAction();
					else element.stopAction();
				}
			}
		}
		
		/**
		 * 炸弹道具
		 */
		private function killAllEnemy():void
		{
			var leng:int = modelContainer.numChildren;
			var element:IEnemy;
			for ( var i:int = 0; i < leng; i++ )
			{
				element = modelContainer.getChildAt( i ) as IEnemy;
				if ( element )
				{
					element.isDeath = true;
					element.isDispose = true;
				}
			}
		}
		
		/////////////////////////////////////////
		private function get curEnemyNum():int
		{
			var leng:int = modelContainer.numChildren;
			var element:IElement;
			var num:int = 0;
			for ( var i:int = 0; i < leng; i++ )
			{
				element = modelContainer.getChildAt( i ) as IElement;
				if ( element && element.modelType == ConstType.ENEMY && !element.isDispose )
				{
					num++;
				}
			}
			return num;
		}
		
	}
}