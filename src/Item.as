package  
{
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.events.Event;
	
	public class Item extends Graphics
	{
		private var _items:Array;
		private var _item:Sprite = new Sprite();
		public var itemType:String;
		private var _flicker:Boolean = false;
		public var timerComplete:Boolean = false;
		
		private var _timer:Timer;
		
		public function Item() 
		{
			var randomWeapon:int = Math.ceil(Math.random() * 4)
			switch(randomWeapon)
			{
				case 1:
					machineGunItem();
					break;
				case 2:
					shotGunItem();
					break;
				case 3:
					sniperItem();
					break;
				case 4:
					homingItem();
					break;
				default:
					trace("Error generating item type");
			}
			
			_timer = new Timer(20);
			_timer.addEventListener(TimerEvent.TIMER, damageTimeHandler);
			_timer.start();
		}
		
		public function machineGunItem():void
		{
			itemType = "machineGunItem";
			
			var machineGunItem:MovieClip = new MachineGunItem() as MovieClip;
			_item.addChild(machineGunItem);
			this.addChild(_item);
			
		}
		
		public function shotGunItem():void
		{
			itemType = "shotGunItem";
			
			var shotGunItem:MovieClip = new ShotGunItem() as MovieClip;
			_item.addChild(shotGunItem);
			this.addChild(_item);
			
		}
		
		public function sniperItem():void
		{
			itemType = "sniperItem";
			
			var sniperItem:MovieClip = new SniperItem() as MovieClip;
			_item.addChild(sniperItem);
			this.addChild(_item);
			
		}
		
		public function homingItem():void
		{
			itemType = "homingItem";
			
			var homingItem:MovieClip = new HomingItem() as MovieClip;
			_item.addChild(homingItem);
			this.addChild(_item);
			
		}
		
		private function damageTimeHandler(event:TimerEvent):void
		{
			if (_timer.currentCount >= 250)
			{
				timerComplete = true;
				_timer.reset();
				_timer.removeEventListener(TimerEvent.TIMER, damageTimeHandler);
			}
			else if (_timer.currentCount >= 200)
			{
				flicker();
			}
		}

		public function flicker():void
		{
			_flicker = !_flicker;
			
			if (_flicker)
			{
				_item.visible = false;
			}
			
			else 
			{
				_item.visible = true;
			}
		}
	}
}