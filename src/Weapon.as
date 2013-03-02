package  
{
	import flash.display.Sprite;
	import flash.utils.Timer;
	
	public class Weapon extends Sprite
	{
		private var _stage:Object;
		
		private var _weaponType:String;
		private var _rateOfFire:int = 12;
		
		private var _player:Player;
		private var _weaponUi:WeaponUi;
		private var _angle:Number = 0;
		private var _angleDeg:Number = 0;
		private var _playerBullets:Array;
		private var _enemies:Array;
		private var _cTime:int = 0;
		private var _isMouseDown:Boolean = false;
		private var _weaponSounds:Sounds;
		private var _weaponAmmo:int = 0;
		private var _weaponCapacity:int = 0;
		
		public const MACHINEGUN_CAPACITY:int = 26;
		public const SHOTGUN_CAPACITY:int = 6;
		public const SNIPER_CAPACITY:int = 8;
		public const HOMING_CAPACITY:int = 12;
		
		public var machineGunAmmo:int = MACHINEGUN_CAPACITY;
		public var shotGunAmmo:int = SHOTGUN_CAPACITY;
		public var sniperAmmo:int = SNIPER_CAPACITY;
		public var homingAmmo:int = HOMING_CAPACITY;
		
		public function Weapon(stage:Object, weaponUi:WeaponUi, player:Player, playerBullets:Array, enemies:Array)
		{
			_weaponUi = weaponUi;
			_playerBullets = playerBullets;
			_enemies = enemies;
			_player = player;
			_stage = stage;
			
			_weaponSounds = new Sounds();
		}
		
		public function changeWeaponType(weaponType:String = "repeaterGun"):void
		{
			_weaponType = weaponType;
			
			if (_weaponType == "repeaterGun")
			{
				_rateOfFire = 10;
				_weaponUi.update(0, 0, true);
				
				_player.repeater();
			}
			
			else if (_weaponType == "machineGun")
			{
				_rateOfFire = 6;
				_weaponCapacity = MACHINEGUN_CAPACITY;
				_weaponAmmo = MACHINEGUN_CAPACITY;
				
				_player.machineGun();
			}
			
			else if (_weaponType == "shotGun")
			{
				_rateOfFire = 36;
				_weaponCapacity = SHOTGUN_CAPACITY;
				_weaponAmmo = SHOTGUN_CAPACITY;
				
				_player.shotGun();
				
			}
			
			else if (_weaponType == "sniper")
			{
				_rateOfFire = 36;
				_weaponCapacity = SNIPER_CAPACITY;
				_weaponAmmo = SNIPER_CAPACITY;
				
				_player.sniper();
			}
			
			else if (_weaponType == "homing")
			{
				_rateOfFire = 8;
				_weaponCapacity = HOMING_CAPACITY;
				_weaponAmmo = HOMING_CAPACITY;
				
				_player.homing();
			}
		}
		
		public function createBullet():void
		{
			if (_weaponType == "repeaterGun" || _weaponType == "machineGun" || _weaponType == "sniper")
			{
				create_straightBullet();
			}
			
			else if (_weaponType == "shotGun")
			{
				create_spreadBullet();
			}
			
			else if (_weaponType == "homing")
			{
				create_homingBullet();
			}
		}
		
		public function controlPlayerFire():void
		{
			_angle = GameUtil.find_angle(_player, _stage);
			  
			_angleDeg = (_angle * 180 / Math.PI - 90);
			
			if (_isMouseDown == true && _cTime > _rateOfFire)
			{	
				if (_weaponAmmo > 0 && _weaponType != "repeaterGun")
				{
					_weaponAmmo--;
					_weaponUi.update(_weaponAmmo, _weaponCapacity);
					
					_cTime = 0;
					createBullet();
					
					switch(_weaponType)
					{
						case "machineGun":
							_weaponSounds.machineGunChannel = _weaponSounds.machineGun.play();
							break;
						case  "shotGun":
							_weaponSounds.shotGunChannel = _weaponSounds.shotGun.play();
							break;
						case "sniper":
							_weaponSounds.sniperChannel = _weaponSounds.sniper.play();
							break;
						case "homing":
							_weaponSounds.homingChannel = _weaponSounds.homing.play();
							break;
						default:
							trace("error choosing weapon sound");
					}
				}
				
				else if (_weaponType == "repeaterGun")
				{
					_cTime = 0;
					createBullet();
					
					_weaponSounds.machineGunChannel = _weaponSounds.machineGun.play();
				}
				else
				{
					changeWeaponType();
				}
			}
			
			else if (_cTime <= _rateOfFire)
			{
				_cTime++;
			} 
			
		}
		
		public function fireWeapon():void
		{
			_isMouseDown = true;
		}
		
		public function stopFire():void
		{
			_isMouseDown = false;
		}
		
		public function create_straightBullet():void 
		{
			//Create a star and add it to the stage
			var playerBullet:Bullet = new Bullet(_weaponType);
			_stage.addChild(playerBullet);
			
			//Set the bullet's starting position
			var radius:int = -(_player.height / 3); 
			playerBullet.x = _player.x + (radius * Math.cos(_angle));
			playerBullet.y = _player.y + (radius * Math.sin(_angle));
			playerBullet.rotation = _angleDeg;
			
			//Set the star's velocity based
			//on the angle between the center of
			//the fairy and the mouse
			playerBullet.vx = Math.cos(_angle) * -(playerBullet.speed);
			playerBullet.vy = Math.sin(_angle) * -(playerBullet.speed);
			
			//push bullet onto arrray
			_playerBullets.push(playerBullet);
			
		}
		
		public function create_spreadBullet():void
		{
			//Create a star and add it to the stage
			var playerBullet:Bullet = new Bullet(_weaponType);
			_stage.addChild(playerBullet);
			var playerBullet2:Bullet = new Bullet(_weaponType);
			_stage.addChild(playerBullet2);
			var playerBullet3:Bullet = new Bullet(_weaponType);
			_stage.addChild(playerBullet3);
			var playerBullet4:Bullet = new Bullet(_weaponType);
			_stage.addChild(playerBullet4);
			
			//Set the bullet's starting position
			var radius:int = -(_player.height / 3);
			
			playerBullet.x = _player.x + (radius * Math.cos(_angle));
			playerBullet.y = _player.y + (radius * Math.sin(_angle));
			playerBullet.rotation = _angleDeg;
			
			playerBullet2.x = _player.x + ((radius + 10) * Math.cos(_angle));
			playerBullet2.y = _player.y + ((radius + 10) * Math.sin(_angle)) - 3;
			playerBullet2.rotation = _angleDeg;
			
			playerBullet3.x = _player.x + (radius * Math.cos(_angle));
			playerBullet3.y = _player.y + (radius * Math.sin(_angle));
			playerBullet3.rotation = _angleDeg;
			
			playerBullet4.x = _player.x + ((radius + 10) * Math.cos(_angle));
			playerBullet4.y = _player.y + ((radius + 10) * Math.sin(_angle)) - 3;
			playerBullet4.rotation = _angleDeg;
			
			//Set the star's velocity based
			//on the angle between the center of
			//the fairy and the mouse
			playerBullet.vx = Math.cos(_angle + .1) * -(playerBullet.speed);
			playerBullet.vy = Math.sin(_angle +.1) * -(playerBullet.speed);
			
			playerBullet2.vx = Math.cos(_angle + .2) * -(playerBullet.speed);
			playerBullet2.vy = Math.sin(_angle + .2) * -(playerBullet.speed);
			
			playerBullet3.vx = Math.cos(_angle -.1) * -(playerBullet.speed);
			playerBullet3.vy = Math.sin(_angle -.1) * -(playerBullet.speed);
			
			playerBullet4.vx = Math.cos(_angle -.2) * -(playerBullet.speed);
			playerBullet4.vy = Math.sin(_angle -.2) * -(playerBullet.speed);
			
			//push bullet onto arrray
			_playerBullets.push(playerBullet);
			_playerBullets.push(playerBullet2);
			_playerBullets.push(playerBullet3);
			_playerBullets.push(playerBullet4);
			
		}
		
		public function create_homingBullet():void
		{
			//Create a star and add it to the stage
			var playerBullet:Bullet = new Bullet(_weaponType);
			_stage.addChild(playerBullet);
			
			//Set the bullet's starting position
			var radius:int = -(_player.height / 3); 
			playerBullet.x = _player.x + (radius * Math.cos(_angle));
			playerBullet.y = _player.y + (radius * Math.sin(_angle));
			playerBullet.rotation = _angleDeg;
			
			//Set the star's velocity based
			//on the angle between the center of
			//the fairy and the mouse
			playerBullet.vx = Math.cos(_angle) * -(playerBullet.speed);
			playerBullet.vy = Math.sin(_angle) * -(playerBullet.speed);
			
			//push bullet onto arrray
			_playerBullets.push(playerBullet);
		}
		
		public function getWeaponType():String
		{
			return _weaponType;
		}
	
	
	}
}