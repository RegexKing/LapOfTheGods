package  
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class Scrolling  extends Sprite
	{
		//inner boundary variables
		public var rightInnerBoundary:uint;
		public var leftInnerBoundary:uint;
		public var topInnerBoundary:uint;
		public var bottomInnerBoundary:uint;
		
		//scroll variables
		private var _temporaryX:int;
		private var _temporaryY:int
		private var _scroll_Vx:int;
		private var _scroll_Vy:int;
		private var _angle:Number;
		
		private var _stage:Object;
		
		public function Scrolling(stage:Object) 
		{
			_stage = stage;
			
			//Define the inner boundary variables
			rightInnerBoundary = (_stage.stageWidth / 2) + (_stage.stageWidth / 6);
			leftInnerBoundary = (_stage.stageWidth / 2) - (_stage.stageWidth / 6);
			topInnerBoundary = (stage.stageHeight / 2) - (stage.stageHeight / 6);
			bottomInnerBoundary = (stage.stageHeight / 2) + (stage.stageHeight / 6);
		}
		
		public function scrollBackground(character:Player, background:Sprite):void
		{
			//Scroll background
			//Calculate the scroll velocity
			_temporaryX = background.x;
			_temporaryY = background.y;
			
			
			_angle = GameUtil.find_angle(character, _stage);
			
			//Stop character at the inner boundary edges
			if (character.x - character.width / 2 < leftInnerBoundary)
			{
				character.x = leftInnerBoundary + character.width / 2;
				rightInnerBoundary = (_stage.stageWidth / 2) + (_stage.stageWidth / 6);
				background.x -= character.vx;
			}
			
			else if (character.x + character.width / 2 > rightInnerBoundary)
			{
				character.x = rightInnerBoundary - character.width / 2;
				leftInnerBoundary = (_stage.stageWidth / 2) - (_stage.stageWidth / 6);
				background.x -= character.vx;
			}
			
			if (character.y - character.height / 2 < topInnerBoundary)
			{
				character.y = topInnerBoundary + character.height / 2;
				bottomInnerBoundary = (_stage.stageHeight / 2) + (_stage.stageHeight / 6);
				background.y -= character.vy;
				
			}
			
			else if (character.y + character.height / 2 > bottomInnerBoundary)
			{
				character.y = bottomInnerBoundary - character.height / 2;
				topInnerBoundary = (_stage.stageHeight / 2) - (_stage.stageHeight /6);
				background.y -= character.vy;
			}
			
			
			//check the stage boundries
			if (background.x > 0)
			{
				background.x = 0;
				leftInnerBoundary = 0;
			}
			
			else if (background.y > 0)
			{
				background.y = 0;
				topInnerBoundary = 0;
			}
			
			else if (background.x < _stage.stageWidth - background.width)
			{
				background.x = _stage.stageWidth - background.width;
				rightInnerBoundary = _stage.stageWidth;
			}
			
			else if (background.y < _stage.stageHeight - background.height)
			{
				background.y = _stage.stageHeight - background.height;
				bottomInnerBoundary = _stage.stageHeight;
			}

			//Calculate the scroll velocity
			_scroll_Vx = background.x - _temporaryX; 
			_scroll_Vy = background.y - _temporaryY; 
		}
		
		public function scrollObject(object:Sprite):void
		{
			object.x += _scroll_Vx;
			object.y += _scroll_Vy;
		}
		
		public function scrollArray(array:Array):void
		{
			
			for (var i:int = 0; i < array.length; i++)
			{
					array[i].x += _scroll_Vx;
					array[i].y += _scroll_Vy;
			}
		}
	}

}