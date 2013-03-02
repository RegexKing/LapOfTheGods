package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.*;
	import mx.formatters.NumberFormatter;
	
	public class WeaponUi extends Sprite
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
		private var WeaponFont:Class
		
		//Create the format and text field objects
		public var format:TextFormat = new TextFormat();
		public var output:TextField = new TextField();
		public var outputWhite:TextField = new TextField();
		public var outputObject:Sprite = new Sprite();
		
		private var fmt:NumberFormatter = new NumberFormatter();
		
		public function WeaponUi() 
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
			
			outputObject.addChild(output);
			outputObject.addChild(outputWhite);
			outputWhite.x += 1;
			outputWhite.y += 1;
			
			this.addChild(outputObject);
		}
		
		public function update(weaponAmmo:int, weaponCapacity:int, isInfinite:Boolean = false):void
		{
			if (!isInfinite)
			{
				if (weaponAmmo == 0)
				{
					format.color = 0xFF0000;
				}
			
				else
				{
					format.color = 0xFFFFFF;
				}
			
				outputWhite.defaultTextFormat = format;
			
				output.text = String(weaponAmmo) + "/" + String(weaponCapacity);
				outputWhite.text = String(weaponAmmo) + "/" + String(weaponCapacity);
			}
			
			else
			{
				format.color = 0xFFFFFF;
				
				outputWhite.defaultTextFormat = format;
			
				output.text = "inf";
				outputWhite.text = "inf";
			}
		}
	}

}