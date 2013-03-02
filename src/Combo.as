package  
{
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.text.*;
	
	public class Combo extends Sprite
	{
		[Embed
			(
				source = "../fonts/megaman.ttf",
				embedAsCFF="false",
				fontName="arcade",
				fontWeight="normal",
				advancedAntiAliasing="true",
				mimeType="application/x-font"
			)
		]
		private var ComboFontClass:Class;
		
		private var _score:ScoreTally;
		
		public var format:TextFormat = new TextFormat();
		public var outputWhite:TextField = new TextField();
		private var _outputObject:Sprite = new Sprite();
		private var _comboCount:Number = 0;
		private var _scoreCount:Number = 0;
		private var _cTime:int = 0;
		private const COMBO_RATE:int = 90;
		private var _resetPos:int = 0;
		
		public function Combo(score:ScoreTally) 
		{
			_score = score;
			
			//1. Configure the format
			format.font = "arcade";
			format.size = 18;
			format.color = 0xFFFF00;
			outputWhite.defaultTextFormat = format;
			outputWhite.embedFonts = true;
			outputWhite.autoSize = TextFieldAutoSize.RIGHT;
			outputWhite.antiAliasType = flash.text.AntiAliasType.ADVANCED;
			outputWhite.border = false;
			outputWhite.selectable = false;
			
			outputWhite.text = "";
			outputWhite.x -= outputWhite.width * 20;
			outputWhite.y -= outputWhite.height * 3;
			
			_resetPos = outputWhite.y;
			
			_outputObject.addChild(outputWhite);
			this.addChild(_outputObject);
		}
		
		public function resetCombo():void
		{
			_cTime++;
			
			outputWhite.y -= 1;
			_outputObject.alpha -= 1 / COMBO_RATE;
			
			if(_cTime > COMBO_RATE)
			{
				if (_comboCount > 1)
				{
					var totalComboScore:int = Math.round(_scoreCount * (_comboCount * 0.1));
					_score.addScore(totalComboScore);
				}
				
				outputWhite.text = "";
				
				_cTime = 0;
				_comboCount = 0;
				_scoreCount = 0;
				
				outputWhite.y = _resetPos;
				_outputObject.alpha = 1;
			}
				
		}
		
		public function addCombo(scorePoints:Number):void
		{
			_cTime = 0;
			_comboCount++;
			_scoreCount += scorePoints;
			
			outputWhite.y = _resetPos;
			_outputObject.alpha = 1;
			
			if (_comboCount > 1)
			{
				outputWhite.text = "x" + String(Math.round(_comboCount));
			}
			
			GameUtil.checkComboCountForMedals(_comboCount);
		}
	}

}