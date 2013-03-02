package  
{
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.media.Sound;
	import flash.text.*;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	public class StartMenu extends Sprite
	{
		private var _stage:Object;
		
		private var _startMenuImg:MovieClip = new StartMenuImg() as MovieClip;
		private var _credits:MovieClip = new Credits() as MovieClip;
		private var _pressAnyKey:MovieClip = new PressAnyKey() as MovieClip;
		private var _sound:Sounds = new Sounds();
		private var _timer:Timer;
		
		private var _isCinemaDone:Boolean = false;
		private var _isMenuSetupDone:Boolean = false;
		
		public function StartMenu(stage:Object) 
		{
			_stage = stage;
			
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		private function addedToStageHandler(event:Event):void
		{
			init();
			this.removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		private function init():void
		{
			_stage.addChild(_startMenuImg);
			
			this.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		private function enterFrameHandler(event:Event):void
		{
			if (!_isCinemaDone)
			{
				_isCinemaDone = checkCinemaDone();
			}
			
			else if (!_isMenuSetupDone)
			{
				_isMenuSetupDone = setupMenu();
			}
		}
		
		private function startGame():void
		{
			
			_stage.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			_stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			this.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
			
			_stage.removeChild(_pressAnyKey);
			_pressAnyKey = null;
			
			_sound.startGameChannel = _sound.startGame.play();
			_timer = new Timer(2000);
			_timer.addEventListener(TimerEvent.TIMER, timeHandler);
			_timer.start();
		}
		
		private function timeHandler(event:TimerEvent):void
		{
			_stage.removeChild(_startMenuImg);
			_startMenuImg = null;
			_stage.removeChild(_credits);
			_credits = null;
			_sound = null;
			
			dispatchEvent(new Event("startGame", true));
			_timer.removeEventListener(TimerEvent.TIMER, timeHandler);
		}
		
		private function setupMenu():Boolean
		{
			_stage.addChild(_credits);
			_credits.y = stage.stageHeight - _credits.height;
			
			_stage.addChild(_pressAnyKey);
			_pressAnyKey.x = _stage.stageWidth / 2 - _pressAnyKey.width / 2;
			_pressAnyKey.y = _stage.stageHeight / 2 - _pressAnyKey.height / 2;
			
			_stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			_stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			
			return true;
		}
		
		private function checkCinemaDone():Boolean
		{
			if (_startMenuImg.currentFrame == _startMenuImg.totalFrames)
			{
				return true;
			}
			
			else
			{
				return false;
			}
			
		}
		
		public function mouseDownHandler(event:MouseEvent):void
		{
			startGame();
		}
		
		private function keyDownHandler(event:KeyboardEvent):void
		{
			startGame();
		}
		
	}

}