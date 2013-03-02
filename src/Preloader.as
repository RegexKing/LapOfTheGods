package 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.utils.getDefinitionByName;
	import flash.display.StageQuality;
	import com.newgrounds.*;
	
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class Preloader extends MovieClip 
	{
		private var _loadBar:Sprite;
		
		public function Preloader() 
		{
			if (stage) {
				stage.scaleMode = StageScaleMode.NO_SCALE;
				stage.align = StageAlign.TOP_LEFT;
			}
			addEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.addEventListener(ProgressEvent.PROGRESS, progress);
			loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioError);
			
			// Connect to Newgrounds
			API.connect(root, "29131:SIlWUeSc", "0dT73nmOKAdR2eUI14YxjpOw1wDIfneb");
			
			//connect to kongregate
			//QuickKong.connectToKong(stage);
			
			//set swf settings
			stage.showDefaultContextMenu = false;
			stage.quality = StageQuality.MEDIUM;
			
			
			// TODO show loader
			_loadBar = new Sprite();
			_loadBar.graphics.beginFill(0x00FF00);
			_loadBar.graphics.drawRect(10, 10, stage.stageWidth - 20, 50);
			_loadBar.graphics.endFill();
			stage.addChild(_loadBar);
		}
		
		private function ioError(e:IOErrorEvent):void 
		{
			trace(e.text);
		}
		
		private function progress(e:ProgressEvent):void 
		{
			// TODO update loader
			var percent:Number = e.bytesLoaded / e.bytesTotal;
			_loadBar.scaleX = percent;
		}
		
		private function checkFrame(e:Event):void 
		{
			if (currentFrame == totalFrames) 
			{
				stop();
				loadingFinished();
			}
		}
		
		private function loadingFinished():void 
		{
			removeEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.removeEventListener(ProgressEvent.PROGRESS, progress);
			loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, ioError);
			
			// TODO hide loader
			stage.removeChild(_loadBar);
			_loadBar = null;
			
			startup();
		}
		
		private function startup():void 
		{
			var mainClass:Class = getDefinitionByName("Main") as Class;
			addChild(new mainClass() as DisplayObject);
		}
		
	}
	
}