package  
{
	import flash.display.Sprite;
	import flash.text.*;
	
	public class ScoreTally extends Sprite
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
		private var ScoreFontClass:Class;
		
		//Create the format and text field objects
		public var format:TextFormat = new TextFormat();
		public var output:TextField = new TextField();
		public var outputWhite:TextField = new TextField();
		private var _outputObject:Sprite = new Sprite();
		
		
		public var score:int = 0;
		
		public function ScoreTally() 
		{
			
			//1. Configure the format
			format.size = 18;
			format.color = 0x000000;
			//The name of the font should match
			//the "name" parameter in the Embed tag
			format.font = "arcade";
			//2. Configure the text field
			output.defaultTextFormat = format;
			output.embedFonts = true;
			output.autoSize = TextFieldAutoSize.LEFT;
			output.antiAliasType = flash.text.AntiAliasType.ADVANCED;
			output.border = false;
			output.selectable = false;
			
			format.color = 0xFFFFFF;
			outputWhite.defaultTextFormat = format;
			outputWhite.embedFonts = true;
			outputWhite.autoSize = TextFieldAutoSize.LEFT;
			outputWhite.antiAliasType = flash.text.AntiAliasType.ADVANCED;
			outputWhite.border = false;
			outputWhite.selectable = false;
			
			output.text = String(score);
			outputWhite.text = String(score);
			_outputObject.addChild(output);
			_outputObject.addChild(outputWhite);
			
			outputWhite.x += 1;
			outputWhite.y += 1;
			
			this.addChild(_outputObject);
		}
		
		public function addScore(scorePoints:Number):void
		{
			score += Math.round(scorePoints);
			output.text = String(score);
			outputWhite.text = String(score);
		}
	}

}