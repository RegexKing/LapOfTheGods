package  
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.ui.Mouse;
	import flash.events.MouseEvent;
	import com.newgrounds.*;
	import com.newgrounds.components.*;
	
	public class Game extends Sprite
	{
		private var _stage:Object;
		private var _cursor:MovieClip;
		public var popup:MedalPopup;
		private var _scoreNum:int;
		private var _player:Player;
		private var _enemy:Enemy;
		private var _enemies:Array;
		private var _background:Background;
		private var _controls:Controls;
		private var _playerBullets:Array;
		private var _enemyBullets:Array;
		private var _scrolling:Scrolling;
		private var _weapon:Weapon;
		private var _explosions:Array;
		private var _score:ScoreTally;
		private var _battery:Battery;
		private var _batteryUi:BatteryUi;
		private var _deathTimer:int = 0;
		private var _sounds:Sounds;
		private var _bgmEnabled:Boolean = true;
		private var _weaponUi:WeaponUi;
		private var _items:Array;
		private var _combo:Combo;
		private var _totalKills:int = 0;
		private var _itemRate:int = 0;
		private var _enemyRange:int = 6;
		private var _enemyRangeCompleted:Boolean = false;
		private var _enemySpawnRate:int = 60;
		private var _enemySpawnTimer:int = 0;
		private var _playerDead:Boolean = false;
	
		public function Game(stage:Object) 
		{
			_stage = stage;
			
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		private function addedToStageHandler(event:Event):void
		{
			startGame();
			this.removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		private function startGame():void
		{
			_stage.addEventListener("killEvent", killEventHandler);
			_stage.addEventListener("playerDie", playerDieHandler);
			
			initializeGraphics();
			
			//start background music
			_sounds = new Sounds();
			_sounds.bgm_1Channel = _sounds.bgm_1.play(0, int.MAX_VALUE);
			
			_weapon = new Weapon(_stage, _weaponUi, _player, _playerBullets, _enemies);
			_weapon.changeWeaponType(); //sets weapon to default (repetaterGun)
			_weaponUi.update(0, 0, true);
			
			_controls = new Controls(_stage, _player, _weapon);
			_scrolling = new Scrolling(_stage);
			
			_itemRate = generateWeaponRate();
			
			this.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		private function enableBgm(bgmEnabled:Boolean):void
		{
			_sounds = new Sounds();
			
			switch(bgmEnabled)
			{
				//case true:
					//_sounds.bgm_1Channel.
				//	break;
				case false:
					_sounds.bgm_1Channel.stop();
					break;
			}
		}
		
		private function killEventHandler(event:Event):void
		{
			this.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
			_stage.removeEventListener("killEvent", killEventHandler);
		}
		
		private function initializeGraphics():void
		{
			_cursor = new Cursor();
			_stage.addChild(_cursor);
			Mouse.hide();
			
			_background = new Background();
			GameUtil.addObjectToGame(_background, _stage, -(_background.width - _stage.stageWidth) / 2, -(_background.height - _stage.stageHeight) / 2);
			
			popup = new MedalPopup();
			GameUtil.addObjectToGame(popup, _stage, _stage.stageWidth - popup.width - 10, 10); 
			
			_score = new ScoreTally();
			GameUtil.addObjectToGame(_score, _stage, 10, 10);
			
			_combo = new Combo(_score);
			GameUtil.addObjectToGame(_combo, _stage, 0, 0);
	
			_batteryUi = new BatteryUi();
			GameUtil.addObjectToGame(_batteryUi, _stage, _stage.stageWidth - _batteryUi.width - 10, _stage.stageHeight - _batteryUi.height / 2 - 21);
			
			_battery = new Battery(_batteryUi);
			GameUtil.addObjectToGame(_battery, _stage, _stage.stageWidth - 140 - _battery.width / 2, _stage.stageHeight - 45);
			
			_weaponUi = new WeaponUi();
			GameUtil.addObjectToGame(_weaponUi, _stage, 9, stage.stageHeight - _weaponUi.height * 4 - 15);
			
			_player = new Player(_stage);
			GameUtil.addObjectToGame(_player, _stage, _stage.stageWidth / 2, _stage.stageHeight / 2);
			
			_enemies = new Array();
			
			_playerBullets = new Array();
			
			_enemyBullets = new Array();
			
			_explosions = new Array();
			
			_items = new Array();
		}
		
		private function sortObjects():void
		{
			/* objects order
			_background
			_items
			_player
			_enemies
			_explosions
			_playerBullets
			todo:enemybullets
			
			_score
			_battery
			_batteryUi
			_weaponUi
			combo
			*/ 
			
			_stage.setChildIndex(_background, 0);
			_stage.setChildIndex(popup, _stage.numChildren - 1);
			
			for (var i:int = 0; i < _items.length; i++)
			{
				_stage.setChildIndex(_items[i], _stage.numChildren - 1);
			}
			
			_stage.setChildIndex(_player, _stage.numChildren - 1);
			
			for (var j:int = 0; j < _enemies.length; j++)
			{
				_stage.setChildIndex(_enemies[j], _stage.numChildren - 1);
			}
			
			for (var k:int = 0; k < _explosions.length; k++)
			{
				_stage.setChildIndex(_explosions[k], _stage.numChildren - 1);
			}
			
			_stage.setChildIndex(_combo, _stage.numChildren - 1);
			
			for (var n:int = 0; n < _enemyBullets.length; n++)
			{
				_stage.setChildIndex(_enemyBullets[n], _stage.numChildren - 1);
			}
			
			for (var m:int = 0; m < _playerBullets.length; m++)
			{
				_stage.setChildIndex(_playerBullets[m], _stage.numChildren - 1);
			}
			
			//UI objects
			_stage.setChildIndex(_score, _stage.numChildren - 1);
			_stage.setChildIndex(_battery, _stage.numChildren - 1);
			_stage.setChildIndex(_batteryUi, _stage.numChildren - 1);
			_stage.setChildIndex(_weaponUi, _stage.numChildren - 1);
			
			_stage.setChildIndex(_cursor, _stage.numChildren - 1);
		}
		
		private function clearGraphics():void
		{
			_stage.removeChild(_background);
			_background = null;
			_stage.removeChild(_score);
			_score = null;
			_stage.removeChild(_batteryUi);
			_batteryUi = null;
			_stage.removeChild(_battery);
			_battery = null;
			_stage.removeChild(_player);
			_player = null;
			_stage.removeChild(_weaponUi);
			_weaponUi = null;
			_stage.removeChild(_combo);
			_combo = null;
			_stage.removeChild(popup);
			popup = null;
			
			_stage.removeChild(_cursor);
			_cursor = null;
			Mouse.show();
			
			for (var i:int; i < _enemies.length; i++)
			{
				_stage.removeChild(_enemies[i]);
				_enemies[i] = null;
				
				_enemies.splice(i, 1);
							
				i--;
			}
			
			for (var j:int; j < _playerBullets.length; j++)
			{
				_stage.removeChild(_playerBullets[j]);
				_playerBullets[j] = null;
				
				_playerBullets.splice(j, 1);
							
				j--;
			}
			
			for (var k:int; k < _explosions.length; k++)
			{
				_stage.removeChild(_explosions[k]);
				_explosions[k] = null;
				
				_explosions.splice(k, 1);
							
				k--;
			}
			
			for (var m:int; m < _items.length; m++)
			{
				_stage.removeChild(_items[m]);
				_items[m] = null;
				
				_items.splice(m, 1);
							
				m--;
			}
			
			for (var n:int; n < _enemyBullets.length; n++)
			{
				_stage.removeChild(_enemyBullets[n]);
				_enemyBullets[n] = null;
				
				_enemyBullets.splice(n, 1);
							
				n--;
			}
		}
		
		private function enterFrameHandler(event:Event):void
		{
			moveCursor();
			_controls.readKeyInput();
			
			enemyRespawnTimer();
			
			sortObjects();
			
			drawEnemies();
			
			_weapon.controlPlayerFire(); // controls rate of player fire
			movePlayerBullets();
			
			moveEnemyBullets();
			
			scrollObjects();
			
			interactObjects();
			
			_combo.resetCombo();
			
			removeArtifacts();
			
			if (_playerDead)
			{
				endGameTimer();
			}
			
		}
		
		private function endGameTimer():void
		{
			if (_deathTimer < 180)
				{
					_deathTimer++;
				}
				
			else 
				{
					endGame();
				}
		}
		
		private function playerDieHandler(event:Event):void
		{
					_scoreNum = _score.score;
					API.postScore("Highscores", _scoreNum);
					QuickKong.stats.submit("HighScore", _scoreNum);
					
					_player.visible = false;
					_controls.freezeControls();
					_controls.stopPlayerMovement();
					_weapon.stopFire();
					_battery.killTimer();
					_battery.freezeBattery();
					
					GameUtil.addExplosion(_stage, "player", _explosions, _player.x, _player.y);
					
					//turn off background music
					_sounds.bgm_1Channel.stop();
					
					//play player expolsion sound
					_sounds.playerDieChannel = _sounds.playerDie.play();
				
				
				_playerDead = true;
			
		}
		/*
		private function checkIfPlayerDead():void
		{
			if (_battery.checkPlayerDead())
			{
				if (_player.visible)
				{
					_controls.freezeControls();
					_controls.stopPlayerMovement();
					_weapon.stopFire();
					_battery.freezeBattery();
					
					GameUtil.addExplosion(_stage, "player", _explosions, _player.x, _player.y);
					_player.visible = false;
					
					//turn off background music
					_sounds.bgm_1Channel.stop();
					
					//play player expolsion sound
					_sounds.playerDieChannel = _sounds.playerDie.play();
				}
				
				
				if (_deathTimer != 180)
				{
					_deathTimer++;
				}
				
				else 
				{
					endGame();
				}
					
			}
		}
		*/
		
		private function endGame():void
		{
			_stage.removeEventListener("playerDie", playerDieHandler);
			dispatchEvent(new Event("killEvent", true));
				
			clearGraphics();
			dispatchEvent(new Event("gameOver", true));
		}
		
		private function enemyRespawnTimer():void
		{
			if (_enemyRange == 6 && _enemies.length > 4)
			{
				_enemySpawnTimer = 0;
			}
			
			else if (_enemySpawnTimer % _enemySpawnRate == 0)
			{
				var random:int = Math.ceil(Math.random() * _enemyRange);
			
				if (random <= 6)
						_enemy = new Enemy(_stage, "kamikaze", _enemyBullets);
				else if (random <= 10)
						_enemy = new Enemy(_stage, "lizard", _enemyBullets);
				else if (random <= 12)
						_enemy = new Enemy(_stage, "strike", _enemyBullets);
				else
						_enemy = new Enemy(_stage, "tank", _enemyBullets);
					
				GameUtil.addObjectToGame(_enemy, _stage, GameUtil.randomizeSpawnPointX(_background), GameUtil.randomizeSpawnPointY(_background));
				_enemies.push(_enemy);
				
				_enemySpawnTimer = 0;
			}
			
			
			if (!_enemyRangeCompleted)
			{
				if (_totalKills >= 40)
				{
					_enemyRange = 13;
					_enemyRangeCompleted = true;
				}
				else if (_totalKills >= 20)
				{
					_enemyRange = 12;
				}
				else if (_totalKills >= 5)
				{
					_enemyRange = 10;
				}
			}
			
			_enemySpawnTimer++;
		}
		
		
		private function drawEnemies():void
		{
			if (_player.visible)
			{
				for (var i:int = 0; i < _enemies.length; i++)
				{
					EnemyBehavior.drawEnemy(_enemies[i], _enemyBullets, _player, _stage);
				}
			}
		}
		
		private function interactObjects():void
		{
			var point:Point
			
			for (var i:int = 0; i < _playerBullets.length; i++)
			{
				for (var j:int = 0; j < _enemies.length; j++)
				{
					
					if (PixelPerfectCollisionDetection.isColliding(_playerBullets[i], _enemies[j], this, true))
					{
						_enemies[j].recieveDamage();
						_enemies[j].hitPoints -= _playerBullets[i].damagePnts;
						
						if (_enemies[j]._enemyName != "tank")
						{
							_sounds.enemyHurtChannel = _sounds.enemyHurt.play();
						}
						else
						{
							_sounds.tankCollisionChannel = _sounds.tankCollision.play();
						}
			
						
						//gets point of collision for small damage explososion
						point = PixelPerfectCollisionDetection.getCollisionPoint(_playerBullets[i], _enemies[j], this, true);
						GameUtil.addExplosion(stage, "bulletExplosion", _explosions, point.x, point.y);
						
						
						if (_enemies[j].hitPoints <= 0 || (_enemies[j]._enemyName == "tank" && PixelPerfectCollisionDetection.isColliding(_playerBullets[i], _enemies[j].hitBox, this, true)))
						{
							if ((_enemies[j]._enemyName == "tank" && PixelPerfectCollisionDetection.isColliding(_playerBullets[i], _enemies[j].hitBox, this, true)))
							{
								API.unlockMedal("Massive damage");
							}
							
							_score.addScore(_enemies[j].scorePoints);
							_combo.addCombo(_enemies[j].scorePoints);
							_combo.x = _enemies[j].x;
							_combo.y = _enemies[j].y;
							_totalKills++;
							if (_totalKills % 10 == 0)
							{
								_enemySpawnRate--;
							}
							trace(_totalKills + " timer delay " + _enemySpawnRate);
							
							GameUtil.checkTotalKillsForMedals(_totalKills);
							
							if (_enemies[j]._enemyName == "kamikaze")
							{
								_battery.recoverPlayerEnergy(1);
							}
							else if (_enemies[j]._enemyName == "lizard")
							{
								_battery.recoverPlayerEnergy(3);
							}
							else if (_enemies[j]._enemyName == "strike")
							{
								_battery.recoverPlayerEnergy(3);
							}
							else if (_enemies[j]._enemyName == "tank")
							{
								_battery.recoverPlayerEnergy(6);
							}
							
							
							_player.changeColor("green");
							
							//random item drop rate
							if (_totalKills % _itemRate == 0)
							{
								var itemDropPoint:Point = new Point(_enemies[j].x,  _enemies[j].y);
								itemDropPoint = GameUtil.checkItemBoundary(itemDropPoint, _background)
								
								GameUtil.addItem(_stage, _items, itemDropPoint.x, itemDropPoint.y);
								
								_itemRate = generateWeaponRate();
							}
							
							GameUtil.addExplosion(stage, _enemies[j].explosionType, _explosions, _enemies[j].x, _enemies[j].y);
							
							_stage.removeChild(_enemies[j]);
							_enemies[j] = null;
						
							_enemies.splice(j, 1);
							
							j--;
							
						}
						
						if (!_playerBullets[i].isPiercing)
						{
							_stage.removeChild(_playerBullets[i]);
							_playerBullets[i] = null;
						
							_playerBullets.splice(i, 1);
						
							i--;
						
							break;
						}
					}
				}
			}
			
			for (var n:int = 0; n < _enemyBullets.length; n++)
			{
				if (PixelPerfectCollisionDetection.isColliding(_enemyBullets[n], _player, this, true) && _player.visible)
				{
					_battery.takePlayerDamage(_enemyBullets[n].damagePnts);
						
					_player.changeColor("red");
						
					//gets point of collision for small damage explososion
					point = PixelPerfectCollisionDetection.getCollisionPoint(_enemyBullets[n], _player, this, true);
					GameUtil.addExplosion(_stage, "bulletExplosion", _explosions, point.x, point.y);
						
					_sounds.playerHurtChannel = _sounds.playerHurt.play();
						
					_stage.removeChild(_enemyBullets[n]);
					_enemyBullets[n] = null;
						
					_enemyBullets.splice(n, 1);
						
					n--;
				}
			}
			
			//if enemy physically hits the player
			for (var k:int = 0; k < _enemies.length; k++)
			{
				
				if (PixelPerfectCollisionDetection.isColliding(_enemies[k], _player.hitBox, this, true) && _player.visible)
				{
					
					_battery.takePlayerDamage(_enemies[k].physDamage);
					_player.changeColor("red");
					_sounds.playerHurtChannel = _sounds.playerHurt.play();
					
					if (_enemies[k]._enemyName == "kamikaze")
					{
						GameUtil.addExplosion(stage, _enemies[k].explosionType, _explosions, _enemies[k].x, _enemies[k].y);
						_stage.removeChild(_enemies[k]);
						_enemies[k] = null;
						
						_enemies.splice(k, 1);
							
						k--;
					}
					
					else if (_enemies[k]._enemyName == "strike")
					{
						API.unlockMedal("I now pronounce you man and knife");
					}
				}
			}
			
			//itempickup
			for (var m:int = _items.length - 1; m >= 0; m--)
			{
				if (_items[m].hitTestObject(_player.itemBox))
				{
					if (_controls.isSpacePressed && _controls.spaceCount < 2)
					{
						if (_items[m].itemType == "machineGunItem")
						{
							_weapon.changeWeaponType("machineGun");
							_weaponUi.update(_weapon.MACHINEGUN_CAPACITY, _weapon.MACHINEGUN_CAPACITY);
						}	
					
						else if (_items[m].itemType == "shotGunItem")
						{
							_weapon.changeWeaponType("shotGun");
							_weaponUi.update(_weapon.SHOTGUN_CAPACITY, _weapon.SHOTGUN_CAPACITY);
						}
					
						else if (_items[m].itemType == "sniperItem")
						{
							_weapon.changeWeaponType("sniper");
							_weaponUi.update(_weapon.SNIPER_CAPACITY, _weapon.SNIPER_CAPACITY);
						}
					
						else if (_items[m].itemType == "homingItem")
						{
							_weapon.changeWeaponType("homing");
							_weaponUi.update(_weapon.HOMING_CAPACITY, _weapon.HOMING_CAPACITY);
						}
						
						_stage.removeChild(_items[m]);
						_items[m] = null;
						
						_items.splice(m, 1);
									
						m--;
						
						//pickup item sound effect
						_sounds.itemPickupChannel = _sounds.itemPickup.play();
						break;
					}
					
				}
			}	
		}
		
		private function scrollObjects():void
		{
			_scrolling.scrollBackground(_player, _background);
			
			_scrolling.scrollArray(_playerBullets);
			_scrolling.scrollArray(_enemyBullets);
			_scrolling.scrollArray(_enemies);
			_scrolling.scrollArray(_explosions);
			_scrolling.scrollArray(_items);
		}
		
		private function movePlayerBullets():void
		{
			//Move the stars
			for(var i:int = 0; i < _playerBullets.length; i++)
			{
				if (_playerBullets[i].weaponType == "homing" && _enemies.length != 0)
				{
					var enemyNumber:int;
					var distance:Number;
					
					for (var j:int = 0; j < _enemies.length; j++)
					{
						var temp_distance:Number = GameUtil.findDistance(_playerBullets[i].x, _playerBullets[i].y, _enemies[j].x, _enemies[j].y)
						
						if (j == 0)
						{
							distance = temp_distance;
							enemyNumber = j;
						}
						
						else 
						{
							if (temp_distance < distance)
							{
								distance = temp_distance;
								enemyNumber = j;
							}
						}
					}
					
					// start homing easing
					var chosenDistance:Number = GameUtil.findDistance(_playerBullets[i].x, _playerBullets[i].y, _enemies[enemyNumber].x, _enemies[enemyNumber].y);
					var TURN_SPEED:Number = 3;
					
					//Get the target object
					var enemy_X:Number = _enemies[enemyNumber].x;
					var enemy_Y:Number = _enemies[enemyNumber].y;
			
					//Calculate the distance between the target and the bee
					var vx:Number = enemy_X - _playerBullets[i].x;
					var vy:Number = enemy_Y - _playerBullets[i].y;
			
					// homing missle follows enemy if enemy is within stage
					if ((_enemies[enemyNumber].y > (_enemies[enemyNumber].height / 2)
						&& _enemies[enemyNumber].y < _stage.stageHeight -  _enemies[enemyNumber].height / 2)
						&& (_enemies[enemyNumber].x > (_enemies[enemyNumber].width / 2)
						&& _enemies[enemyNumber].x < _stage.stageWidth -  _enemies[enemyNumber].width / 2))
					{
						//Find out how much to move
						var move_X:Number = TURN_SPEED * vx / chosenDistance;
						var move_Y:Number = TURN_SPEED * vy / chosenDistance;
				
						//Increase the bee's velocity 
						_playerBullets[i].vx += move_X; 
						_playerBullets[i].vy += move_Y;
				
						//Find the total distance to move
						var moveDistance:Number = Math.sqrt(_playerBullets[i].vx * _playerBullets[i].vx + _playerBullets[i].vy * _playerBullets[i].vy);
				
						//Apply easing
						_playerBullets[i].vx = _playerBullets[i].speed * _playerBullets[i].vx / moveDistance;
						_playerBullets[i].vy = _playerBullets[i].speed * _playerBullets[i].vy / moveDistance;
				
				
						//Convert the radians to degrees to rotate
						//the bee corectly
						
						var bulletRotation:Number = Math.atan2(_playerBullets[i].vy, _playerBullets[i].vx);
						_playerBullets[i].rotation = bulletRotation * 180 / Math.PI + 90;
					}
			
					//Move the bee
					_playerBullets[i].x += _playerBullets[i].vx;
					_playerBullets[i].y += _playerBullets[i].vy;
				}
				
				else
				{
					_playerBullets[i].x += _playerBullets[i].vx;
					_playerBullets[i].y += _playerBullets[i].vy;
				}
				
				//check the star's stage boundariessd
				if (_playerBullets[i].y < -(_playerBullets[i].width)
				|| _playerBullets[i].x < -(_playerBullets[i].height)
				|| _playerBullets[i].x > stage.stageWidth +  _playerBullets[i].width
				|| _playerBullets[i].y > stage.stageHeight +  _playerBullets[i].height)
				{
					//Remove the star from the stage
					_stage.removeChild(_playerBullets[i]);
					_playerBullets[i] = null;
					
					//Remove the star from the _stars
					//array
					_playerBullets.splice(i,1);
					
					//Reduce the loop counter 
					//by one to compensate
					//for the removed star
					i--;
				}
			}
		}
		
		private function moveEnemyBullets():void
		{	
			for (var i:int = 0; i < _enemyBullets.length; i++)
			{
				_enemyBullets[i].x += _enemyBullets[i].vx;
				_enemyBullets[i].y += _enemyBullets[i].vy;
		
				
				//check the star's stage boundariessd
				if (_enemyBullets[i].y < -(_enemyBullets[i].width)
				|| _enemyBullets[i].x < -(_enemyBullets[i].height)
				|| _enemyBullets[i].x > stage.stageWidth +  _enemyBullets[i].width
				|| _enemyBullets[i].y > stage.stageHeight +  _enemyBullets[i].height)
				{
				//Remove the star from the stage
				_stage.removeChild(_enemyBullets[i]);
				_enemyBullets[i] = null;
					
				//Remove the star from the _stars
				//array
				_enemyBullets.splice(i,1);
					
				//Reduce the loop counter 
				//by one to compensate
				//for the removed star
				i--;
				}
			}
		}
		
		private function removeArtifacts():void
		{
			for (var i:int = 0; i < _explosions.length; i++)
			{
				_explosions[i].stopExplosion()
				
				if (_explosions[i].isExplosionPlaying())
				{
					//Remove the star from the stage
					_stage.removeChild(_explosions[i]);
					_explosions[i] = null;
					
					//Remove the star from the _stars
					//array
					_explosions.splice(i,1);
					
					//Reduce the loop counter 
					//by one to compensate
					//for the removed star
					i--;
				}
				
			}
			
			for (var j:int = 0; j < _items.length; j++)
			{
				if (_items[j].timerComplete)
				{
					_stage.removeChild(_items[j]);
					_items[j] = null;
					
					_items.splice(j, 1);
					j--;
				}
			}
		}
		
		private function generateWeaponRate():int
		{
			var randomPrime:int;
			
			do
			{
				randomPrime= Math.ceil(Math.random() * 4) + 1;
			} while (randomPrime == 4);
			
			return randomPrime;
		}
		
		public function getScore():int
		{
			return _scoreNum;
		}
		
		private function moveCursor():void
		{
			_cursor.x = _stage.mouseX - (_cursor.width / 2);
			_cursor.y = _stage.mouseY - (_cursor.height / 2);
		}
	}
}