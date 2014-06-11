package utils
{
	import flash.geom.Rectangle;
	
	import starling.display.DisplayObject;
	import starling.events.Event;

	public class Animator
	{
		public static const TO_LEFT:int = 0;
		public static const TO_RIGHT:int = 1;
		public static const TO_TOP:int = 2;
		public static const TO_BOTTOM:int = 3;
		
		
		public static function bottopUp(sprite:DisplayObject):void 
		{
//			var origin:Rectangle = Character(sprite).textureBounds();
			var origin:Rectangle = sprite.bounds.clone();
			
			// initialize
			sprite.y = sprite.pivotY = origin.height;
			sprite.height = 0;
			
			// events
			sprite.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			function onEnterFrame(event:Event):void 
			{
				if(sprite.height <= origin.height)
				{
					sprite.height += (origin.height - sprite.height + 10) * 0.1;
				} 
				else
				{
					sprite.height = origin.height;
					sprite.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				}
			}
			
		}
		
		
		public static function moveTo(sprite:DisplayObject, position:int = TO_LEFT):void
		{
			// intitialzie
			var origin:Rectangle = sprite.bounds.clone();
			var targetX:Number;
			var targetY:Number;
			var vector:int = 1;
			
			switch (position)
			{
				case 0:
					sprite.x = -sprite.width;
					targetX = 0;
					break;
				
				case 1:
					break;
				
				case 2:
					break;
				
				case 3:
					sprite.x = Main.STAGE_WIDTH
					targetX = Main.STAGE_WIDTH - sprite.width;
					break;
			}
			
			vector = (targetX > sprite.x) ? 1 : -1;
			
			sprite.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			// animation
			function onEnterFrame(event:Event):void 
			{
				if (sprite.x * vector <= targetX)
				{
					sprite.x += (targetX - sprite.x) * 0.1;
				}
				if (Math.abs(targetX - sprite.x) < 0.1)
				{
					sprite.x = targetX;
					sprite.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				}
			}
			
			
		}
		
	}
	
}