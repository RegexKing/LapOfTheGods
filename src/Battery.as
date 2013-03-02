package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.*;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import mx.formatters.NumberFormatter;
	
	public class Battery extends Sprite
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
		private var BatteryFont:Class
		
		private var _batteryUi:BatteryUi;
		private var _timer:Timer;
		
		//Create the format and text field objects
		public var format:TextFormat = new TextFormat();
		public var output:TextField = new TextField();
		public var outputWhite:TextField = new TextField();
		public var outputObject:Sprite = new Sprite();
		
		private const FULL_POWER:Number = 100000
		public var batteryPower:Number = FULL_POWER;
		private var _secs:Number = 1000;
		private var _batteryPercent:Number;
		private var fmt:NumberFormatter = new NumberFormatter();
		private var _playerDead:Boolean = false;
		
		public function Battery(batteryUi:BatteryUi) 
		{
			_batteryUi = batteryUi;
			
			//format precision 1
			 fmt.precision = 1;
			
			//1. Configure the format
			format.size = 18;
			format.color = 0x000000;
			//The name of the font should match
			//the "name" parameter in the Embed tag
			format.font = "arcade";
			//2. Configure the text field
			output.defaultTextFormat = format;
			output.embedFonts = true;
			output.autoSize = TextFieldAutoSize.RIGHT;
			output.antiAliasType = flash.text.AntiAliasType.ADVANCED;
			output.border = false;
			output.selectable = false;
			
			format.color = 0xFFFFFF;
			outputWhite.defaultTextFormat = format;
			outputWhite.embedFonts = true;
			outputWhite.autoSize = TextFieldAutoSize.RIGHT;
			outputWhite.antiAliasType = flash.text.AntiAliasType.ADVANCED;
			outputWhite.border = false;
			outputWhite.selectable = false;
			
			outputObject.addChild(output);
			outputObject.addChild(outputWhite);
			outputWhite.x += 1;
			outputWhite.y += 1;
			
			
			this.addChild(outputObject);
			
			_batteryPercent = batteryPower / _secs;
			
			_timer = new Timer(20);
			_timer.addEventListener(TimerEvent.TIMER, timeHandler);
			_timer.start();
		}
		
		public function killTimer():void
		{
			_timer.removeEventListener(TimerEvent.TIMER, timeHandler);
		}
		
		public function takePlayerDamage(damagePnt:Number):void
		{
			// 1 damagepoint = -1%
			batteryPower -= damagePnt * 1000;
			
			if (batteryPower <= 0)
			{
				dispatchEvent(new Event("playerDie", true));
			}
		}
		
		public function recoverPlayerEnergy(energyPnt:Number):void
		{
			// 1 energyPnt = 1%
			batteryPower += energyPnt * 1000;
			
			if (batteryPower > FULL_POWER)
			batteryPower = FULL_POWER;
		}
		
		private function timeHandler(event:TimerEvent):void
		{
			batteryPower -= 20;
			
			_batteryPercent = batteryPower/_secs;
			
			var percentage:String;
			
			if (_batteryPercent < 10)
			{
				percentage = '0' + String(_batteryPercent);
			}
			else
			{
				percentage = String(_batteryPercent);
			}
			
			
			if (_batteryPercent <= 25)
			{
				format.color = 0xFF0000;
			}
			
			else
			{
				format.color = 0xFFFFFF;
			}
			
			outputWhite.defaultTextFormat = format;
			
			percentage = fmt.format(percentage);
			output.text = percentage;
			outputWhite.text = percentage;
			
			_batteryUi.adjustBattery(_batteryPercent);
		}
		
		/*
		public function checkPlayerDead():Boolean
		{
			if (_playerDead)
			{
				killTimer();
				
				return true;
			}
			
			else
			{
				return false;
			}
		}
		*/
		
		public function freezeBattery():void
		{
			outputWhite.text = "0.0";
			output.text = "0.0";
			_batteryUi.adjustBattery(0);
		}
	}

}