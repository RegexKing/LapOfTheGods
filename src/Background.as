package  
{
import flash.display.Sprite;
import flash.display.MovieClip;

	public class Background extends Graphics
	{
		private var _background_topLeft:MovieClip = new BackgroundImg() as MovieClip;
		private var _background_topRight:MovieClip = new BackgroundImg() as MovieClip;
		private var _background_bottomLeft:MovieClip = new BackgroundImg() as MovieClip;
		private var _background_bottomRight:MovieClip = new BackgroundImg() as MovieClip;
		private var _background:Sprite = new Sprite();
		
		public function Background() 
		{
			_background.addChild(_background_topLeft);
			_background.addChild(_background_topRight);
			_background.addChild(_background_bottomLeft);
			_background.addChild(_background_bottomRight);
			
			_background_topRight.scaleX = -1;
			_background_topRight.x = _background_topRight.width * 2;
			
			_background_bottomLeft.scaleY = -1;
			_background_bottomLeft.y = _background_bottomLeft.height * 2;
			
			_background_bottomRight.scaleX = -1;
			_background_bottomRight.x = _background_bottomRight.width * 2;
			_background_bottomRight.scaleY = -1;
			_background_bottomRight.y = _background_bottomRight.height * 2;
			
			this.addChild(_background);
		}
		
	}

}