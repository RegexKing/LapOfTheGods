package  
{
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.geom.ColorTransform;
	
	public class BatteryUi extends Sprite
	{
		private var _batteryBorder:MovieClip = new BatteryBorder() as MovieClip;
		private var _batteryBar:Sprite = new Sprite();
		private var _battery:Sprite = new Sprite();
		
		private var green:ColorTransform = new ColorTransform();
		private var yellow:ColorTransform = new ColorTransform();
		private var orange:ColorTransform = new ColorTransform();
		private var red:ColorTransform = new ColorTransform();
		
		public function BatteryUi() 
		{
			_battery.addChild(_batteryBorder);
			
			_batteryBar.graphics.beginFill(0x00FF00);
			_batteryBar.graphics.drawRect(0, 0, 15, 55);
			_batteryBar.graphics.endFill();
			
			_battery.addChild(_batteryBar);
			_batteryBar.x = 4;
			_batteryBar.y = 8 + _batteryBar.height;
			
			green.color = 0x00FF00;
			yellow.color = 0xFFFF00;
			orange.color = 0xFF9900;
			red.color = 0xFF0000;
			
			this.addChild(_battery);
		}
		
		public function adjustBattery(batteryPercent:Number):void
		{
			_batteryBar.scaleY = -(batteryPercent * .01);
			
			if (_batteryBar.scaleY <= -(0.75))
			{
				_batteryBar.transform.colorTransform = green;
			}
			
			else if (_batteryBar.scaleY <= -(0.50))
			{
				_batteryBar.transform.colorTransform = yellow;
			}
			
			else if (_batteryBar.scaleY <= -(0.25))
			{
				_batteryBar.transform.colorTransform = orange;
			}
			
			else
			{
				_batteryBar.transform.colorTransform = red;
			}
			
		}
		
	}

}