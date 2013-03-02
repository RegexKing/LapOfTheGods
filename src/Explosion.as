package  
{
	import flash.display.MovieClip;
	
	public class Explosion extends Graphics
	{
		private var _explosion:MovieClip;
		public var isExplosionStopped:Boolean = false;
		private var _sounds:Sounds = new Sounds();
		
		public function Explosion(explosionType:String) 
		{
			if (explosionType == "bulletExplosion")
			{
				_explosion = new BulletExplosion() as MovieClip;
				
				this.addChild(_explosion);
			}
			
			else if (explosionType == "player")
			{
				_explosion = new PlayerExplosion() as MovieClip;
				
				this.addChild(_explosion);
			}
			
			else if (explosionType == "kamikaze")
			{
				_explosion = new KamikazeExplosion() as MovieClip;
				
				this.addChild(_explosion);
			}
			
			else if (explosionType == "lizard")
			{
				_explosion = new LizardExplosion() as MovieClip;
				
				this.addChild(_explosion);
			}
			
			else if (explosionType == "strike")
			{
				_explosion = new StrikeExplosion() as MovieClip;
				
				this.addChild(_explosion);
			}
			
			else if (explosionType == "tank")
			{
				_explosion = new TankExplosion() as MovieClip;
				
				this.addChild(_explosion);
			}
		}
		
		public function stopExplosion():void
		{
			if (_explosion.currentFrame == _explosion.totalFrames)
			{
				_explosion.stop();
				isExplosionStopped = true;
			}
		}
		
		public function isExplosionPlaying():Boolean
		{
			if (isExplosionStopped)
			{
				return isExplosionStopped;
			}
			
			else
			{
				return isExplosionStopped;
			}
		}
		
	}

}