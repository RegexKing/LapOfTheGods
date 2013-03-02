package  
{
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.media.Sound;
	
	public class EnemyBehavior
	{
		
		public function EnemyBehavior() 
		{
			
		}
		
		//executes list of behaviors based on enemy type
		public static function drawEnemy(enemy:Enemy, enemyBullets:Array, player:Player, stage:Object):void
		{
			var angle:Number;
			
			if (enemy._enemyName == "kamikaze")
			{
				angle = followEnemy(enemy, player);
				controlLegs(enemy);
			}
			
			else if (enemy._enemyName == "lizard")
			{
				angle = followEnemy(enemy, player);
				bulletHandler(enemy, enemyBullets, player, 120, angle, stage);
				controlLegs(enemy);
			}
			
			else if (enemy._enemyName == "tank")
			{
				angle = tankFollowEnemy(enemy, player);
				tankBulletHandler(enemy, enemyBullets, player, 240, angle, stage);
			}
			
			else if (enemy._enemyName == "strike")
			{
				if (checkEnemyWithinStage(enemy, stage) && !enemy.withinStage)
				{
					enemy.withinStage = true;
				}
				
				else if (!checkEnemyWithinStage(enemy, stage))
				{
					enemy.speed = 3
					angle = followEnemy(enemy, player);
					
					enemy.speed = 10;
					
					enemy.rotation = angle * 180 / Math.PI + 90;
						
					enemy.vx = Math.cos(angle) * -(enemy.speed);
					enemy.vy = Math.sin(angle) * -(enemy.speed);
					
					enemy.bulletTimer++;
				}
				
				else
				{
					if (enemy.bulletTimer >= 60)
					{
						strike(enemy, stage);
					}
					
					else
					{
						angle = GameUtil.find_angle_enemy_player(enemy, player);
						enemy.rotation = angle * 180 / Math.PI + 90;
						
						enemy.vx = Math.cos(angle) * -(enemy.speed);
						enemy.vy = Math.sin(angle) * -(enemy.speed);
						
						enemy.bulletTimer++;
					}
				}
				
			}
		}
		
		private static function checkEnemyWithinStage(enemy:Enemy, stage:Object):Boolean
		{
			if ((enemy.y > (enemy.height / 2)
						&& enemy.y < stage.stageHeight -  enemy.height / 2)
						&& (enemy.x > (enemy.width / 2)
						&& enemy.x < stage.stageWidth -  enemy.width / 2))
				{
					return true;
				}
				
			else
			{
				return false;
			}
		}
		
		private static function strike(enemy:Enemy, stage:Object):void
		{		
			enemy.x += enemy.vx;
			enemy.y += enemy.vy;
			
			if (!checkEnemyWithinStage(enemy, stage))
			{
				enemy.bulletTimer = 0;
			}
		}
		
		private static function followEnemy(enemy:Enemy, player:Player):Number
		{
			// start homing easing
			var angle:Number = GameUtil.find_angle_enemy_player(enemy, player);
					
			var chosenDistance:Number = GameUtil.findDistance(enemy.x, enemy.y, player.x, player.y);
			var TURN_SPEED:Number = 2;
					
			//Get the target object
			var player_X:Number = player.x;
			var player_Y:Number = player.y;
			
			//Calculate the distance between the target and the bee
			var vx:Number = player_X - enemy.x;
			var vy:Number = player_Y - enemy.y;
			

			
			//var distance:Number = Math.sqrt(vx * vx + vy * vy);
			if (chosenDistance > enemy.range)
			{
				//Find out how much to move
				var move_X:Number = TURN_SPEED * vx / chosenDistance;
				var move_Y:Number = TURN_SPEED * vy / chosenDistance;
				
				//Increase the bee's velocity 
				enemy.vx += move_X; 
				enemy.vy += move_Y;
				
				//Find the total distance to move
				var moveDistance:Number = Math.sqrt(enemy.vx * enemy.vx + enemy.vy * enemy.vy);
				
				//Apply easing
				enemy.vx = enemy.speed * enemy.vx / moveDistance;
				enemy.vy = enemy.speed * enemy.vy / moveDistance;
			}
			
			else if (chosenDistance < enemy.range - (enemy.range/6))
			{
				//Find out how much to move
				var rmove_X:Number = TURN_SPEED * vx / chosenDistance;
				var rmove_Y:Number = TURN_SPEED * vy / chosenDistance;
				
				//Increase the bee's velocity 
				enemy.vx -= rmove_X; 
				enemy.vy -= rmove_Y;
				
				//Find the total distance to move
				var rmoveDistance:Number = Math.sqrt(enemy.vx * enemy.vx + enemy.vy * enemy.vy);
				
				//Apply easing
				enemy.vx = enemy.speed * enemy.vx / rmoveDistance;
				enemy.vy = enemy.speed * enemy.vy / rmoveDistance;
				
				
				//Convert the radians to degrees to rotate
				//the bee corectly
				
			}
			
			else
			{
				enemy.vx = 0;
				enemy.vy = 0;
			}
			
			enemy.rotation = angle * 180 / Math.PI + 90;
			
			//Move the bee
			enemy.x += enemy.vx;
			enemy.y += enemy.vy;
			
			return angle;
		}
		
		private static function tankFollowEnemy(enemy:Enemy, player:Player):Number
		{
			// start homing easing
			var angle:Number = GameUtil.find_angle_enemy_player(enemy, player);
					
			var chosenDistance:Number = GameUtil.findDistance(enemy.x, enemy.y, player.x, player.y);
			var TURN_SPEED:Number = 20;
					
			//Get the target object
			var player_X:Number = player.x;
			var player_Y:Number = player.y;
			
			//Calculate the distance between the target and the bee
			var vx:Number = player_X - enemy.x;
			var vy:Number = player_Y - enemy.y;
			

			
			//var distance:Number = Math.sqrt(vx * vx + vy * vy);
			if (chosenDistance > enemy.range)
			{
				//Find out how much to move
				var move_X:Number = TURN_SPEED * vx / chosenDistance;
				var move_Y:Number = TURN_SPEED * vy / chosenDistance;
				
				//Increase the bee's velocity 
				enemy.vx += move_X; 
				enemy.vy += move_Y;
				
				//Find the total distance to move
				var moveDistance:Number = Math.sqrt(enemy.vx * enemy.vx + enemy.vy * enemy.vy);
				
				//Apply easing
				enemy.vx = enemy.speed * enemy.vx / moveDistance;
				enemy.vy = enemy.speed * enemy.vy / moveDistance;
			}
			
			else
			{
				enemy.vx = 0;
				enemy.vy = 0;
			}
			
			var vx1:Number = Math.cos(enemy.rotation/180*Math.PI);
			var vy1:Number = Math.sin(enemy.rotation/180*Math.PI); 
			//vector to target point
			var vx2:Number  = player.x - enemy.x;
			var vy2:Number = player.y - enemy.y;
			//dot product between target vector and left hand normal of current vector
			var dp:Number = vy1 * vx2 - vx1 * vy2;
			var rotAmount:Number = 0.5;
			
			if (dp > rotAmount)
			{
				enemy.rotation -= rotAmount;
			}
			else if (dp < -rotAmount)
			{
				enemy.rotation += rotAmount;
			}
			else if (vx1 * vx2 + vy1 * vy2 > 0)
			{
				//snap into taget angle if we are facing in correct direction
				enemy.rotation = Math.atan2(vy2, vx2) / Math.PI * 180;
			}
			
			//Move the bee
			enemy.x += enemy.vx;
			enemy.y += enemy.vy;
			
			return angle;
		}
		
		private static function bulletHandler(enemy:Enemy, enemyBullets:Array, player:Player, bulletRate:int, angle:Number, stage:Object):void
		{
			enemy.bulletTimer++;
			
			if ( enemy.bulletTimer >= bulletRate)
			{
				var angleDeg:Number = (angle * 180 / Math.PI - 90);
			
				//Create a star and add it to the stage
				var enemyBullet:Bullet = new Bullet("lizard");
				stage.addChild(enemyBullet);
			
				//Set the bullet's starting position
				var radius:int = -(enemy.height / 2); 
				enemyBullet.x = enemy.x + (radius * Math.cos(angle));
				enemyBullet.y = enemy.y + (radius * Math.sin(angle));
				enemyBullet.rotation = angleDeg;
			
				//Set the star's velocity based
				//on the angle between the center of
				//the fairy and the mouse
				enemyBullet.vx = Math.cos(angle) * -(enemyBullet.speed);
				enemyBullet.vy = Math.sin(angle) * -(enemyBullet.speed);
			
				//push bullet onto arrray
				enemyBullets.push(enemyBullet);
				
				enemy.bulletTimer = 0;
			}
		}
		
		private static function tankBulletHandler(enemy:Enemy, enemyBullets:Array, player:Player, bulletRate:int, angle:Number, stage:Object):void
		{
			enemy.bulletTimer++;
			
			if ( enemy.bulletTimer >= bulletRate)
			{
				var angleDeg:Number = (angle * 180 / Math.PI - 90);
			
				//Create a star and add it to the stage
				var enemyBullet:Bullet = new Bullet("tank");
				var enemyBullet2:Bullet = new Bullet("tank");
				var enemyBullet3:Bullet = new Bullet("tank");
				var enemyBullet4:Bullet = new Bullet("tank");
				var enemyBullet5:Bullet = new Bullet("tank");
				stage.addChild(enemyBullet);
				stage.addChild(enemyBullet2);
				stage.addChild(enemyBullet3);
				stage.addChild(enemyBullet4);
				stage.addChild(enemyBullet5);
			
				//Set the bullet's starting position
				enemyBullet.x = enemy.x + Math.cos(angle);
				enemyBullet.y = enemy.y + Math.sin(angle);
				enemyBullet.rotation = angleDeg;
				
				//Set the bullet's starting position
				enemyBullet2.x = enemy.x + Math.cos(angle);
				enemyBullet2.y = enemy.y + Math.sin(angle);
				enemyBullet2.rotation = angleDeg - 30;
				
				//Set the bullet's starting position
				enemyBullet4.x = enemy.x + Math.cos(angle);
				enemyBullet4.y = enemy.y + Math.sin(angle);
				enemyBullet4.rotation = angleDeg - 60;
				
				//Set the bullet's starting position
				enemyBullet3.x = enemy.x + Math.cos(angle);
				enemyBullet3.y = enemy.y + Math.sin(angle);
				enemyBullet3.rotation = angleDeg + 30;
				
				//Set the bullet's starting position
				enemyBullet5.x = enemy.x + Math.cos(angle);
				enemyBullet5.y = enemy.y + Math.sin(angle);
				enemyBullet5.rotation = angleDeg + 60;
			
				//Set the star's velocity based
				enemyBullet.vx = Math.cos(angle) * -(enemyBullet.speed);
				enemyBullet.vy = Math.sin(angle) * -(enemyBullet.speed);
				
				//Set the star's velocity based
				enemyBullet2.vx = Math.cos(angle - .4) * -(enemyBullet2.speed);
				enemyBullet2.vy = Math.sin(angle - .4) * -(enemyBullet2.speed);
				
				//Set the star's velocity based
				enemyBullet4.vx = Math.cos(angle - .8) * -(enemyBullet4.speed);
				enemyBullet4.vy = Math.sin(angle - .8) * -(enemyBullet4.speed);
				
				//Set the star's velocity based
				enemyBullet3.vx = Math.cos(angle + .4) * -(enemyBullet3.speed);
				enemyBullet3.vy = Math.sin(angle + .4) * -(enemyBullet3.speed);
				
				//Set the star's velocity based
				enemyBullet5.vx = Math.cos(angle + .8) * -(enemyBullet5.speed);
				enemyBullet5.vy = Math.sin(angle + .8) * -(enemyBullet5.speed);
			
				//push bullet onto arrray
				enemyBullets.push(enemyBullet);
				enemyBullets.push(enemyBullet2);
				enemyBullets.push(enemyBullet3);
				enemyBullets.push(enemyBullet4);
				enemyBullets.push(enemyBullet5);
				
				enemy.bulletTimer = 0;
			}
		}
		
		private static function controlLegs(enemy:Enemy):void
		{
			if (enemy.vx == 0 && enemy.vy == 0)
			{
				
				enemy.legs.gotoAndStop(1);
			}
			
			else
			{
				enemy.legs.play();
			}
		}
		
	}

}