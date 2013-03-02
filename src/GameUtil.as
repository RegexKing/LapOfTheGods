package  
{
	/**
	 * ...
	 * @author Frank Fazio
	 */
	
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import flash.media.Sound;
	import com.newgrounds.*;
	
	public class GameUtil
	{
		
		public function GameUtil() 
		{
			
		}
		
		static public function addObjectToGame(gameObject:Sprite, gameWorld:Object, xPos:int, yPos:int):void
		{
			gameWorld.addChild(gameObject);
			gameObject.x = xPos;
			gameObject.y = yPos;
		}
		
		
		static public function find_angle(player:Sprite, stage:Object):Number
		{
			//Find the angle between the center of the
			//player character and the mouse
			  return Math.atan2(player.y - stage.mouseY, player.x  - stage.mouseX);
			  
		}
		
		static public function find_angle_enemy_player(enemy:Sprite, player:Sprite):Number
		{
			//Find the angle between the center of the
			//player character and the enemy
			  return Math.atan2(enemy.y - player.y, enemy.x  - player.x);
			  
		}
		
		// 2 functions below randomize enemy spawn point (outside of stage)
		static public function randomizeSpawnPointX(background:Background):int
		{
			var spawnPoint:int;
			var isNegative:int = Math.round(Math.random());
			var negative:int;
			
			
			switch(isNegative)
			{
				case 0:
				negative = -1;
				break;
					
				case 1:
				negative = 1;
				break;
			}
			
			if (negative < 0)
			{
				spawnPoint =  negative * Math.round(Math.random() * (background.width / 4));
			}
			
			else
			{
				spawnPoint = Math.round(Math.random() * (background.width / 4)) + (background.width / 4) * 3;
			}
			
			return spawnPoint;
		}
		
		static public function randomizeSpawnPointY(background:Background):int
		{
			var spawnPoint:int;
			var isNegative:int = Math.round(Math.random());
			var negative:int;
			
			
			switch(isNegative)
			{
				case 0:
				negative = -1;
				break;
					
				case 1:
				negative = 1;
				break;
			}
			
			if (negative < 0)
			{
				spawnPoint = negative * Math.round(Math.random() * (background.height / 4));
			}
			
			else
			{
				spawnPoint = Math.round(Math.random() * (background.height / 4)) + (background.height / 4) * 3;
			}
			
			return spawnPoint;
		}
		
		static public function addExplosion(stage:Object, explosionType:String, explosions:Array, xPos:int, yPos:int):void
		{
			var enemyExplosion:Explosion = new Explosion(explosionType);
			stage.addChild(enemyExplosion);
			enemyExplosion.x = xPos - enemyExplosion.width / 2;
			enemyExplosion.y = yPos - enemyExplosion.height / 2;
			
			explosions.push(enemyExplosion);

			var _sounds:Sounds = new Sounds();
			
			if (explosionType != "player" && explosionType != "bulletExplosion" && explosionType != "lizard")
			{
				var randomExplosion:int = Math.ceil(Math.random() * 4);
				
				switch (randomExplosion)
				{
					case 1:
						_sounds.explosion1Channel = _sounds.explosion1.play();
						break;
					case 2:
						_sounds.explosion2Channel = _sounds.explosion2.play();
						break;
					case 3:
						_sounds.explosion1Channel = _sounds.explosion3.play();
						break;
					case 4:
						_sounds.explosion1Channel = _sounds.explosion4.play();
						break;
					default:
						trace("Error in choosing enemy explosion sound");
				}
			}
			
			else if ( explosionType == "lizard")
				{
					_sounds.lizardDieChannel = _sounds.lizardDie.play();
				}
			
			_sounds = null;
		}
		
		static public function addItem(stage:Object, items:Array, xPos:int, yPos:int):void
		{
			var item:Item = new Item();
			stage.addChild(item);
			item.x = xPos - item.width / 2;
			item.y = yPos - item.height / 2;
			
			items.push(item);
		}
		
		static public function findDistance(target1_x:Number, target1_y:Number, target2_x:Number, target2_y:Number):Number
		{
			var vx:Number = target2_x - target1_x;
			var vy:Number = target2_y - target1_y;
			
			return Math.sqrt(vx * vx + vy * vy);
		}
		
		static public function checkItemBoundary(itemDropPoint:Point, background:Background):Point
		{
			if (itemDropPoint.x < background.x + 64)
			{
				itemDropPoint.x = background.x + 64 + 40;
			}
			
			if (itemDropPoint.x > background.x + 1280 - 64)
			{
				itemDropPoint.x = background.x + 1280 - 64 - 74/2;
			}
			
			if (itemDropPoint.y < background.y + 64)
			{
				itemDropPoint.y = background.y + 64 + 40;
			}
			
			if (itemDropPoint.y > background.y + 960 - 64)
			{
				itemDropPoint.y = background.y + 960 - 64 - 38/2;
			}
			
			return itemDropPoint;
		}
		
		static public function checkTotalKillsForMedals(totalKills:int):void
		{
			if (totalKills >= 300)
			{
				API.unlockMedal("Genocide");
			}
			else if (totalKills >= 200)
			{
				API.unlockMedal("Annihilation");
			}
			
			else if (totalKills >= 100)
			{
				API.unlockMedal("Massacre");
			}
			
			else if (totalKills >= 50)
			{
				API.unlockMedal("Homicide");
			}
		}
		
		static public function checkComboCountForMedals(comboCount:int):void
		{
			if (comboCount >= 30)
			{
				API.unlockMedal("Faptastic!");
			}
			else if (comboCount >= 20)
			{
				API.unlockMedal("Amazing!");
			}
			
			else if (comboCount >= 10)
			{
				API.unlockMedal("Awesome!");
			}
			
			else if (comboCount >= 5)
			{
				API.unlockMedal("Cool!");
			}
		}
	}

}