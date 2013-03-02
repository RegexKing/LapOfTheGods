package  
{
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	
	public class Player extends Graphics
	{
		private var _playerRepeater:MovieClip = new Player_Repeater() as MovieClip;	
		private var _playerMachineGun:MovieClip = new Player_MachineGun() as MovieClip;
		private var _playerShotGun:MovieClip = new Player_ShotGun() as MovieClip;
		private var _playerSniper:MovieClip = new Player_Sniper() as MovieClip;
		private var _playerHoming:MovieClip = new Player_Homing() as MovieClip;
		
		public var legs:MovieClip = new PlayerLegs() as MovieClip;
		public var legsRotational:Sprite = new Sprite();
		
		private var _playerContainer:Sprite = new Sprite();
		private var _playerColor:Sprite = new Sprite();
		
		public var rotational:Sprite = new Sprite();
		private var _player:Sprite = new Sprite();
		public var hitBox:Shape = new Shape();
		public var itemBox:Shape = new Shape();
		private var _filler:Shape = new Shape();
		private var _dTimer:Timer;
		private var deathFlash:Boolean = false;
		private var _red:ColorTransform = new ColorTransform();
		private var _green:ColorTransform = new ColorTransform();
		
		//public vars
		public var vx:Number = 0;
		public var vy:Number = 0;
		public var speed:Number = 3;
		
		public function Player(stage:Object) 
		{
			_playerColor.addChild(_playerContainer);
			rotational.addChild(_playerColor);
			
			legsRotational.addChild(legs);
			legs.stop();
			legs.x -= legs.width / 2;
			legs.y -= legs.height / 2;
			legsRotational.visible = false;
			
			_player.addChild(legsRotational);
			_player.addChild(rotational);
			
			hitBox.graphics.beginFill(0xFFFFFF);
			hitBox.graphics.drawRect(-(15 / 2), -(15 / 2), 15, 15);
			hitBox.graphics.endFill();
			hitBox.visible = false;
			_player.addChild(hitBox);
			
			itemBox.graphics.beginFill(0xFFFFFF);
			itemBox.graphics.drawRect(-(40 / 2), -(40 / 2), 40, 40);
			itemBox.graphics.endFill();
			itemBox.visible = false;
			_player.addChild(itemBox);
			
			_filler.graphics.beginFill(0xFFFFFF);
			_filler.graphics.drawRect(-(150 / 2), -(150 / 2), 150, 150);
			_filler.graphics.endFill();
			_filler.visible = false;
			_player.addChild(_filler);
			
			adjustSpritePos();
			
			repeater();
			
			this.addChild(_player);
			
			_red.color = 0xFF0000;
			_red.redMultiplier = 1;
			_red.redOffset = 0;
			
			_green.color = 0x00FF00;
			_green.greenMultiplier = 1;
			_green.greenOffset = 0;
			
			_dTimer = new Timer(20);
		}
		
		private function adjustSpritePos():void
		{
			_playerRepeater.x -= _playerRepeater.width / 2;
			_playerRepeater.y -= _playerRepeater.height / 2;
			
			_playerMachineGun.x -= _playerMachineGun.width / 2;
			_playerMachineGun.y -= _playerMachineGun.height / 2;
			
			_playerShotGun.x -= _playerShotGun.width / 2;
			_playerShotGun.y -= _playerShotGun.height / 2;
			
			_playerSniper.x -= _playerSniper.width / 2;
			_playerSniper.y -= _playerSniper.height / 2;
			
			_playerHoming.x -= _playerHoming.width / 2;
			_playerHoming.y -= _playerHoming.height / 2;
		}
		
		public function repeater():void
		{
			while (_playerContainer.numChildren > 0) 
			{
				_playerContainer.removeChildAt(0);
			}
			
			_playerContainer.addChild(_playerRepeater);
		}
		
		public function machineGun():void
		{
			while (_playerContainer.numChildren > 0) 
			{
				_playerContainer.removeChildAt(0);
			}
			
			_playerContainer.addChild(_playerMachineGun);
		
		}
		
		public function shotGun():void
		{
			while (_playerContainer.numChildren > 0) 
			{
				_playerContainer.removeChildAt(0);
			}
			
			_playerContainer.addChild(_playerShotGun);
		}
		
		public function sniper():void
		{
			while (_playerContainer.numChildren > 0) 
			{
				_playerContainer.removeChildAt(0);
			}
			
			_playerContainer.addChild(_playerSniper);
		}
		
		public function homing():void
		{
			while (_playerContainer.numChildren > 0) 
			{
				_playerContainer.removeChildAt(0);
			}
			
			_playerContainer.addChild(_playerHoming);
		}
		
		public function changeColor(color:String):void
		{
			if (color == "red")
			{
				_playerColor .transform.colorTransform = _red;
				_dTimer.addEventListener(TimerEvent.TIMER, damageTimeHandler);
				_dTimer.start();
			}
			
			else if (color == "green")
			{
				_playerColor.transform.colorTransform = _green;
				_dTimer.addEventListener(TimerEvent.TIMER, damageTimeHandler);
				_dTimer.start();
			}
		}
		
		private function damageTimeHandler(event:TimerEvent):void
		{
			_playerColor.transform.colorTransform = new ColorTransform();
			_dTimer.reset();
			_dTimer.removeEventListener(TimerEvent.TIMER, damageTimeHandler);
		}
		
	}
}