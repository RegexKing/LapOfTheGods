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
	import com.newgrounds.components.*;
	/**
	 * ...
	 * @author Frank Fazio
	 */
	public class HighScores extends Sprite
	{
		private var scoreBrowser:ScoreBrowser = new ScoreBrowser();
		private var _sounds:Sounds = new Sounds();
		
		private var _score:int;
		private var _stage:Object;
		private var format:TextFormat = new TextFormat();
		private var scoreText:TextField = new TextField();
		private var totalScore:TextField = new TextField();
		//private var _scorePosted:MovieClip = new ScorePosted();
		private var _timer:Timer;
		private var _scoreCounter:int = 0;
		private var _scoreCountInc:int = 1;
		private var _continueText:TextField = new TextField();
		
		public function HighScores(stage:Object, score:int) 
		{
			_stage = stage;
			_score = score;
			
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		private function addedToStageHandler(event:Event):void
		{
			loadScreen();
			this.removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		private function loadScreen():void
		{
			createScoreText();
			
			_timer = new Timer(60);
			_timer.addEventListener(TimerEvent.TIMER, timeHandler);
			_timer.start();
			
			_stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
		}
		
		private function showGameOver():void
		{
			_stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			
			scoreBrowser.scoreBoardName = "Highscores";
			scoreBrowser.loadScores();
			_stage.addChild(scoreBrowser);
			//for kongregate
			//scoreBrowser.visible = false;
			
			scoreBrowser.y = stage.stageHeight - scoreBrowser.height - 10;
			scoreBrowser.x = 10;
			
			//_stage.addChild(_scorePosted);
			//_scorePosted.x = _stage.stageWidth / 2 - _scorePosted.width / 2;
			//_scorePosted.y = _stage.stageHeight / 2 - _scorePosted.height / 2;
			
			createContinueText();
		}
		
		private function createContinueText():void
		{
			_continueText.defaultTextFormat = format;
			_continueText.embedFonts = true;
			_continueText.autoSize = TextFieldAutoSize.CENTER;
			_continueText.antiAliasType = flash.text.AntiAliasType.ADVANCED;
			_continueText.border = false;
			_continueText.selectable = false;
			_continueText.text = "Press Any Key\nTo Continue";
			
			_stage.addChild(_continueText);
			_continueText.x = stage.stageWidth - _continueText.width - 50;
			_continueText.y = stage.stageHeight - _continueText.height - 10;
		}
		
		private function keyDownHandler(event:KeyboardEvent):void
		{
				exit();
		}
		
		
		private function exit():void
		{
			_stage.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			_stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			
			clearGraphics();
			
			dispatchEvent(new Event("continue", true));
		}
		
		private function clearGraphics():void
		{	
			_stage.removeChild(scoreText);
			scoreText = null;
			
			_stage.removeChild(totalScore);
			totalScore = null;
			
			_stage.removeChild(scoreBrowser);
			scoreBrowser = null;
			
			_stage.removeChild(_continueText);
			_continueText = null;
			
			//_stage.removeChild(_scorePosted);
			//_scorePosted = null;
		}
		
		private function endScoreCount():void
		{
			totalScore.text = String(_score);
			_timer.stop();
			_timer.removeEventListener(TimerEvent.TIMER, timeHandler);
			
			showGameOver();
		}
		
		private function timeHandler(event:TimerEvent):void
		{
			if (_scoreCounter < _score)
			{
				_scoreCounter += _scoreCountInc;
				totalScore.text = String(_scoreCounter);
				
				if (_timer.currentCount % 5 == 0)
				{
					_scoreCountInc *= 2;
				}
			}
			
			else
			{
				endScoreCount();
			}
			
			_sounds.scoreCountChannel = _sounds.scoreCount.play();
		}
		
		public function mouseDownHandler(event:MouseEvent):void
		{
			if (_timer.running)
			{
				endScoreCount();
			}
		}
		
		private function createScoreText():void
		{
			//1. Configure the format
			format.size = 18;
			format.color = 0xFFFF00;
			//The name of the font should match
			//the "name" parameter in the Embed tag
			format.font = "arcade";
			format.align = "center";
			//2. Configure the text field
			totalScore.defaultTextFormat = format;
			totalScore.embedFonts = true;
			totalScore.autoSize = TextFieldAutoSize.CENTER;
			totalScore.antiAliasType = flash.text.AntiAliasType.ADVANCED;
			totalScore.border = false;
			totalScore.selectable = false;
			totalScore.text = String(_scoreCounter);
			
			format.color = 0xFFFFFF;
			scoreText.defaultTextFormat = format;
			scoreText.embedFonts = true;
			scoreText.autoSize = TextFieldAutoSize.CENTER;
			scoreText.antiAliasType = flash.text.AntiAliasType.ADVANCED;
			scoreText.border = false;
			scoreText.selectable = false;
			scoreText.text = "Total Score";
			
			_stage.addChild(scoreText);
			scoreText.x = _stage.stageWidth / 2 - scoreText.width / 2;
			scoreText.y += totalScore.height;
			
			_stage.addChild(totalScore);
			totalScore.x = _stage.stageWidth / 2 - totalScore.width / 2;
			totalScore.y += totalScore.height * 3;
		}
		
	}

}