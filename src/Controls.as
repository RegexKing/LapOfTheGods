package  
{
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.events.Event;

	
	public class Controls extends Sprite
	{
		private var _stage:Object;
		
		//Boolean key press values
		private var isUpPressed:Boolean = false;
		private var isDownPressed:Boolean = false;
		private var isLeftPressed:Boolean = false;
		private var isRightPressed:Boolean = false;
		public var isSpacePressed:Boolean = false;
		public var spaceCount:int = 0;
		
		private var _player:Player;
		private var _angle:Number = 0;
		private var _angleDeg:Number = 0;
		private var _border:Number = 25; // Border of screen
		private var _weapon:Weapon;
		
		public function Controls(stage:Object, player:Player, weapon:Weapon) 
		{
			_weapon = weapon;
			_player = player;
			_stage = stage;
			
			_stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			_stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			_stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			_stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
		}
		
		public function freezeControls():void
		{
			_stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			_stage.removeEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			_stage.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			_stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
		}
		
		public function readKeyInput():void
		{
			playerInput();
			spacePress();
		}
		
		private function spacePress():void
		{
			if (isSpacePressed)
			{
				spaceCount++;
			}
			
		}
		
		private function playerInput():void
		{
			//Find the angle between the center of the
			//player character and the mouse
			_angle = GameUtil.find_angle(_player, _stage);
			  
			_angleDeg = (_angle * 180 / Math.PI - 90);
			
			_player.rotational.rotation = _angleDeg;
			
			_player.vx = ( -Number(isLeftPressed) * _player.speed) + (Number(isRightPressed) * _player.speed);
			_player.vy = ( -Number(isUpPressed) * _player.speed) + (Number(isDownPressed) * _player.speed);
			
			//move the player
			_player.x += _player.vx;
			_player.y += _player.vy;
			
			//move legs
			moveLegs();
			
			if (_player.x < _player.width / 2 + _border)
			{
				_player.x = _player.width / 2 + _border;
			}
			
			else if (_player.x > _stage.stageWidth - _player.height / 2 - _border)
			{
				_player.x = _stage.stageWidth - _player.height / 2 - _border;
			}
			
			if (_player.y < _player.width / 2 + _border)
			{
				_player.y = _player.width / 2 + _border;
			}
			
			else if (_player.y > _stage.stageHeight - _player.height / 2 - _border)
			{
				_player.y = _stage.stageHeight - _player.height / 2 - _border;
			}
		}
		
		private function moveLegs():void
		{
			if (_player.vx == 0 && _player.vy == 0)
			{
				_player.legsRotational.visible = false;
				_player.legs.gotoAndStop(1);
			}
			else if ((_player.vx < 0 && _player.vy < 0) || (_player.vx > 0 && _player.vy > 0))
			{
				_player.legsRotational.visible = true;
				_player.legsRotational.rotation = -45;
				_player.legs.play();
			}
			
			else if ((_player.vx > 0 && _player.vy < 0) || (_player.vx < 0 && _player.vy > 0))
			{
				_player.legsRotational.visible = true;
				_player.legsRotational.rotation = 45;
				_player.legs.play();
			}
			
			else if (_player.vy == 0)
			{
				_player.legsRotational.visible = true;
				_player.legsRotational.rotation = 90;
				_player.legs.play();
			}
			
			else if (_player.vx == 0)
			{
				_player.legsRotational.visible = true;
				_player.legsRotational.rotation = 0;
				_player.legs.play();
			}
		}
		
		public function stopPlayerMovement():void
		{
			isLeftPressed = false;
			isRightPressed = false;
			isUpPressed = false;
			isDownPressed = false;
			isSpacePressed = false;
		}
		
		public function mouseDownHandler(event:MouseEvent):void
		{	
			_weapon.fireWeapon();	
		}	
		
		public function mouseUpHandler(event:MouseEvent):void
		{
			_weapon.stopFire();
		}
		
		private function keyDownHandler(event:KeyboardEvent):void
		{
			if ((event.keyCode == Keyboard.LEFT) || (event.keyCode == Keyboard.A))
				{
					isLeftPressed = true;
				}
			else if ((event.keyCode == Keyboard.RIGHT) || (event.keyCode == Keyboard.D))
				{
					isRightPressed = true;
				}
			else if ((event.keyCode == Keyboard.UP) || (event.keyCode == Keyboard.W))
				{
					isUpPressed = true;
				}
			else if ((event.keyCode == Keyboard.DOWN) || (event.keyCode == Keyboard.S))
				{
					isDownPressed = true;
				}
			
			else if (event.keyCode == Keyboard.SPACE)
				{
					isSpacePressed = true;
				}
		}
		private function keyUpHandler(event:KeyboardEvent):void
		{
			if ((event.keyCode == Keyboard.LEFT) || (event.keyCode == Keyboard.A))
			{
				isLeftPressed = false;
			}
			else if ((event.keyCode == Keyboard.RIGHT) || (event.keyCode == Keyboard.D))
			{
				isRightPressed = false;
			}
			else if ((event.keyCode == Keyboard.UP) || (event.keyCode == Keyboard.W))
			{
				isUpPressed = false;
			}
			else if ((event.keyCode == Keyboard.DOWN) || (event.keyCode == Keyboard.S))
			{
				isDownPressed = false;
			}
			
			else if (event.keyCode == Keyboard.SPACE)
			{
				isSpacePressed = false;
				spaceCount = 0;
			}
		}
		
	}

}