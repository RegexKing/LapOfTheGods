/* NOTES:
	 * 
		//-Every graphic must be removable in this class so it can be cleared when transitioning
		//-Every event listener must have a kill handler that fires off when transitioning or just removed
*/

package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import com.newgrounds.components.*;
	
	[SWF(width="640", height="480", backgroundColor="#000000", frameRate="60")]
	[Frame(factoryClass = "Preloader")]
	
	public class Main extends Sprite
	{
		private var _startMenu:StartMenu;
		private var _game:Game;
		private var _highScores:HighScores;
		
		private var _score:int;
		
		public function Main()
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			startGame()
		}
		
		private function startGame():void
		{	
			_startMenu = new StartMenu(stage);
			stage.addChild(_startMenu);
			
			stage.addEventListener("startGame", startGameHandler);
			stage.addEventListener("gameOver", gameOverHandler);
			stage.addEventListener("continue", continueHandler);
		}
		
		private function startGameHandler(event:Event):void
		{
			stage.removeChild(_startMenu);
			_startMenu = null;
			
			_game = new Game(stage);
			stage.addChild(_game);
		}
		
		private function gameOverHandler(event:Event):void
		{
			trace("Player has died");
			_score = _game.getScore();
			stage.removeChild(_game);
			_game = null;
			
			if (_game == null)
			{
				trace("game has been removed");
			}
			
			_highScores = new HighScores(stage, _score);
			stage.addChild(_highScores);
			
		}
		
		private function continueHandler(event:Event):void
		{
			stage.removeChild(_highScores);
			_highScores = null;
			
			if (_highScores == null)
			{
				trace("highscores has been removed");
			}
			
			_game = new Game(stage);
			stage.addChild(_game);
		}
		
	}
}
	