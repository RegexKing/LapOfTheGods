package  
{
	import flash.display.Sprite;
	import flash.display.MovieClip;
	
	public class Bullet extends Graphics
	{
		private var _playerBullet:Sprite = new Sprite();
		
		public var vx:Number = 0;
		public var vy:Number = 0;
		public var speed:int;
		public var damagePnts:int = 0;
		public var isPiercing:Boolean = false;
		public var weaponType:String;
		
		public function Bullet(_weaponType:String) 
		{
			weaponType = _weaponType;
			
			if (weaponType == "repeaterGun")
			{
				repeaterGun();
			}
			
			else if (weaponType == "machineGun")
			{
				machineGun();
			}
			
			else if (weaponType == "shotGun")
			{
				shotGun();
			}
			
			else if (weaponType == "sniper")
			{
				sniper();
			}
			
			else if (weaponType == "homing")
			{
				homing();
			}
			
			if (_weaponType == "lizard")
			{
				lizard();
			}
			
			if (_weaponType == "tank")
			{
				tank();
			}
		}
		
		private function repeaterGun():void
		{
			damagePnts = 6;
			speed = 18;
			
			var _playerBulletImg:MovieClip = new RepeaterBullet() as MovieClip;
			_playerBullet.addChild(_playerBulletImg);
			_playerBulletImg.x = -(_playerBulletImg.width / 2);
			this.addChild(_playerBullet);
		}
		
		private function machineGun():void
		{
			damagePnts = 8;
			speed = 18;
			
			var _playerBulletImg:MovieClip = new MachineGunBullet() as MovieClip;
			_playerBullet.addChild(_playerBulletImg);
			_playerBulletImg.x = -(_playerBulletImg.width / 2);
			this.addChild(_playerBullet);
		}
		
		private function shotGun():void
		{
			damagePnts = 10;
			speed = 18;
			
			var _playerBulletImg:MovieClip = new ShotGunBullet() as MovieClip;
			_playerBullet.addChild(_playerBulletImg);
			_playerBulletImg.x = -(_playerBulletImg.width / 2);
			this.addChild(_playerBullet);
		}
		
		private function sniper():void
		{
			damagePnts = 10;
			speed = 25;
			isPiercing = true;
			
			var _playerBulletImg:MovieClip = new SniperBullet() as MovieClip;
			_playerBullet.addChild(_playerBulletImg);
			_playerBulletImg.x = -(_playerBulletImg.width / 2);
			this.addChild(_playerBullet);
		}
		
		private function homing():void
		{
			damagePnts = 12;
			speed = 8;
			
			var _playerBulletImg:MovieClip = new HomingBullet() as MovieClip;
			_playerBullet.addChild(_playerBulletImg);
			_playerBulletImg.x = -(_playerBulletImg.width / 2);
			this.addChild(_playerBullet);
		}
		
		private function lizard():void
		{
			damagePnts = 15;
			speed = 4;
			
			var _playerBulletImg:MovieClip = new LizardBullet() as MovieClip;
			_playerBullet.addChild(_playerBulletImg);
			_playerBulletImg.x = -(_playerBulletImg.width / 2);
			this.addChild(_playerBullet);
		}
		
		private function tank():void
		{
			damagePnts = 15;
			speed = 3;
			
			var _playerBulletImg:MovieClip = new TankBullet() as MovieClip;
			_playerBullet.addChild(_playerBulletImg);
			_playerBulletImg.x = -(_playerBulletImg.width / 2);
			this.addChild(_playerBullet);
		}
		
	}

}