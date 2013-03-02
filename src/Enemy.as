package  
{
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	
	public class Enemy extends Graphics
	{	
		private var _stage:Object;
		public var vx:Number = 0;
		public var vy:Number = 0;
		public var speed:Number = 0;
		public var timesHit:int = 0;
		public var hitPoints:int = 0;
		public var scorePoints:Number = 0;
		public var _enemyName:String;
		public var explosionType:String;
		public var physDamage:int = 0;
		private var _enemy:Sprite = new Sprite();
		public var legs:MovieClip = new PlayerLegs() as MovieClip;
		public var hitBox:Sprite = new Sprite();
		public var withinStage:Boolean = false;
		//
		private var _red:ColorTransform = new ColorTransform();
		public var range:int = 0;
		
		private var _timer:Timer;
		public var bulletTimer:int = 0;
		
		public function Enemy(stage:Object, enemyName:String, enemyBullets:Array) 
		{
			_stage = stage;
			
			_stage.addEventListener("killEvent", killEventHandler);
			
			_enemyName = enemyName;
			determineEnemy(enemyName);
			
			_red.color = 0xFFFFFF;
		}
		
		private function killEventHandler(event:Event):void
		{
			_timer.removeEventListener(TimerEvent.TIMER, damageTimeHandler);
			_stage.removeEventListener("killEvent", killEventHandler);
		}
		
		//chooses which enemy based on string
		private function determineEnemy(enemyName:String):void
		{
			if (enemyName == "kamikaze")
			{
				_enemy.addChild(legs);
				legs.x -= legs.width / 2;
				legs.y -= legs.height / 2;
				
				var _enemyImg:MovieClip = new EnemyType2() as MovieClip;
				_enemy.addChild(_enemyImg);
				_enemyImg.x -= _enemyImg.width / 2;
				_enemyImg.y -= _enemyImg.height / 2;
			
				this.addChild(_enemy);
				
				speed = 3;
				range = 0;
				hitPoints = 1;
				scorePoints = 100;
				physDamage = 15;
				explosionType = "kamikaze";
			}
			
			 else if (enemyName == "lizard")
			{
				_enemy.addChild(legs);
				legs.x -= legs.width / 2;
				legs.y -= legs.height / 2;
				
				var _enemyImg2:MovieClip = new EnemyType1() as MovieClip;
				_enemy.addChild(_enemyImg2);
				_enemyImg2.x -= _enemyImg2.width / 2;
				_enemyImg2.y -= _enemyImg2.height / 2;
			
				this.addChild(_enemy);
				
				speed = 2;
				range = 200;
				hitPoints = 30;
				scorePoints = 125;
				physDamage = 50;
				explosionType = "lizard";
			}
			
			else if (enemyName == "tank")
			{
				
				var _enemyImg4:MovieClip = new EnemyType3() as MovieClip;
				var tankBattery:MovieClip = new TankBattery() as MovieClip;
				hitBox.addChild(tankBattery);
				
				_enemy.addChild(_enemyImg4);
				_enemy.addChild(hitBox);
				
				_enemyImg4.x -= _enemyImg4.width / 2;
				_enemyImg4.y -= _enemyImg4.height / 2;
				
				hitBox.x -= _enemyImg4.width / 2 - 6.5;
				hitBox.y -= _enemyImg4.height / 2 - 26;
				
				this.addChild(_enemy);
				
				speed = 1;
				range = 175;
				hitPoints = 120;
				scorePoints = 200;
				physDamage = 100;
				explosionType = "tank";
			}
			
			else if (enemyName == "strike")
			{
				var _enemyImg3:MovieClip = new EnemyType4() as MovieClip;
				_enemy.addChild(_enemyImg3);
				_enemyImg3.x -= _enemyImg3.width / 2;
				_enemyImg3.y -= _enemyImg3.height / 2;
				
				this.addChild(_enemy);
				
				speed = 12;
				range = 0;
				hitPoints = 1;
				scorePoints = 150;
				physDamage = 3;
				explosionType = "strike";
			}
			
			_timer = new Timer(20);
		}
		
		public function recieveDamage():void
		{
			_enemy.transform.colorTransform = _red;
			_timer.addEventListener(TimerEvent.TIMER, damageTimeHandler);
			_timer.start();
		}
		
		private function damageTimeHandler(event:TimerEvent):void
		{
			_enemy.transform.colorTransform = new ColorTransform();
			_timer.reset();
			_timer.removeEventListener(TimerEvent.TIMER, damageTimeHandler);
		}
		
	}

}