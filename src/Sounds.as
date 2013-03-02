 //Example, to play any sound
  //_sounds.chirpChannel = _sounds.chirp.play();
package
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	public class Sounds
	{
		[Embed(source = "../lib/sounds/bgm_1.mp3")]
		private var Bgm_1:Class;
		
		[Embed(source = "../lib/sounds/enemyHurt.mp3")]
		private var EnemyHurt:Class;
		
		[Embed(source = "../lib/sounds/playerHurt.mp3")]
		private var PlayerHurt:Class;
		
		[Embed(source = "../lib/sounds/playerdie.mp3")]
		private var PlayerDie:Class;
		
		[Embed(source = "../lib/sounds/explosion1.mp3")]
		private var Explosion1:Class;
		
		[Embed(source = "../lib/sounds/explosion2.mp3")]
		private var Explosion2:Class;
		
		[Embed(source = "../lib/sounds/explosion3.mp3")]
		private var Explosion3:Class;
		
		[Embed(source = "../lib/sounds/explosion4.mp3")]
		private var Explosion4:Class;
		
		[Embed(source = "../lib/sounds/homing.mp3")]
		private var Homing:Class;
		
		[Embed(source = "../lib/sounds/machineGun.mp3")]
		private var MachineGun:Class;
		
		[Embed(source = "../lib/sounds/shotgun.mp3")]
		private var ShotGun:Class;
		
		[Embed(source = "../lib/sounds/sniper.mp3")]
		private var Sniper:Class;
		
		[Embed(source = "../lib/sounds/itemPickup.mp3")]
		private var ItemPickup:Class;
		
		[Embed(source = "../lib/sounds/scoreCount.mp3")]
		private var ScoreCount:Class;
		
		[Embed(source = "../lib/sounds/tankCollision.mp3")]
		private var TankCollision:Class;
		
		[Embed(source = "../lib/sounds/lizardDie.mp3")]
		private var LizardDie:Class;
		
		[Embed(source = "../lib/sounds/startGame.mp3")]
		private var StartGame:Class;
		
		//Create the Sound and Sound channel objects
		// bgm 1
		public var bgm_1:Sound = new Bgm_1();
		public var bgm_1Channel:SoundChannel = new SoundChannel();
		
		public var explosion1:Sound = new Explosion1();
		public var explosion1Channel:SoundChannel = new SoundChannel();
		
		public var explosion2:Sound = new Explosion2();
		public var explosion2Channel:SoundChannel = new SoundChannel();
		
		public var explosion3:Sound = new Explosion3();
		public var explosion3Channel:SoundChannel = new SoundChannel();
		
		public var explosion4:Sound = new Explosion4();
		public var explosion4Channel:SoundChannel = new SoundChannel();
		
		public var itemPickup:Sound = new ItemPickup();
		public var itemPickupChannel:SoundChannel = new SoundChannel();
		
		public var enemyHurt:Sound = new EnemyHurt();
		public var enemyHurtChannel:SoundChannel = new SoundChannel();
		
		public var playerHurt:Sound = new PlayerHurt();
		public var playerHurtChannel:SoundChannel = new SoundChannel();
		
		public var homing:Sound = new Homing();
		public var homingChannel:SoundChannel = new SoundChannel();
		
		public var machineGun:Sound = new MachineGun();
		public var machineGunChannel:SoundChannel = new SoundChannel();
		
		public var playerDie:Sound = new PlayerDie();
		public var playerDieChannel:SoundChannel = new SoundChannel();
		
		public var shotGun:Sound = new ShotGun();
		public var shotGunChannel:SoundChannel = new SoundChannel();
		
		public var sniper:Sound = new Sniper();
		public var sniperChannel:SoundChannel = new SoundChannel();
		
		public var scoreCount:Sound = new ScoreCount();
		public var scoreCountChannel:SoundChannel = new SoundChannel();
		
		public var tankCollision:Sound = new TankCollision();
		public var tankCollisionChannel:SoundChannel = new SoundChannel();
		
		public var lizardDie:Sound = new LizardDie();
		public var lizardDieChannel:SoundChannel = new SoundChannel();
		
		public var startGame:Sound = new StartGame();
		public var startGameChannel:SoundChannel = new SoundChannel();
		
		
		public function Sounds()
		{
		}
	}
}