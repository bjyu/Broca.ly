/**
 * Preview contents includes close button. 
 * Preview character and effect sprites
 */
package elements
{
	import feathers.controls.Button;
	
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Preview extends Sprite
	{
		private var m_closeButton:Button;
		
		private var m_character:Sprite;
		private var m_effect:Sprite
		
		public function Preview()
		{
			super();
			
			// background Image
//			var image:Image = new Image(Assets.getTexture("space"));
//			image.color = 0x5c5c5c;
//			image.alpha = 0.5;
//			image.width = Main.STAGE_WIDTH * 0.6;
//			image.height = Main.STAGE_HEIGHT * 0.5 * 0.75;
//			addChild(image);
			
			m_closeButton = new Button();
			m_closeButton.label = "X";
			m_closeButton.addEventListener(Event.TRIGGERED, onCloseButtonTriggered);
			
			
			this.addChild(m_closeButton);
			
			this.visible = false;
		}
		
		private function onCloseButtonTriggered():void
		{
			this.visible = false;
		}
		
		public function showCharacter(faceId:String):void
		{
			// To Do #
			// 이미 로딩된 Character 클래스를 활용하는 것이 효과 적일 것. 
			var character:Image = new Image(Assets.getAtlas(Assets.DefaultAtlasName).getTexture(faceId));
			
			if (!m_character)
			{
				m_character = new Sprite();
				m_character.addChild(character);
				addChild(m_character);
				
				putCenter(m_character);
			}
			else
			{
				m_character.removeChildren(0,-1,true);
				m_character.addChild(character);
			}
			
			this.visible = true;
		}
		
		// separate character positioning and new effect sprite
		public function showEffect(effectKey:String):void
		{
			this.visible = true;
			
			var effectType:String = getEffectType(effectKey);
			
			switch(effectType)
			{
				case "A":
					var effect:Image = new Image(Assets.getTexture(effectKey));
					putCenter(effect);
					
					if (!m_effect)
					{
						m_effect = new Sprite();
						m_effect.addChild(effect);
						
						putCenter(m_effect);
						addChild(m_effect);
					}
					else
					{
						m_effect.removeChildren(0,-1,true);
						m_effect.addChild(effect);
					}
					break;
				
				case "B":
					// animation
					
					break;
				
				default:
					break;
			}
			
		}
		
		// To Do # would be like to move this function to pubic static utils
		public static function getEffectType(effectKey:String):String
		{
			// To Do #
			return "";
		}
		
		private function putCenter(displayObject:DisplayObject):void
		{
			var scale:Number = Math.min(Main.STAGE_WIDTH * 0.9 / displayObject.width, Main.STAGE_HEIGHT * 0.5 * 0.75 / displayObject.height);
			displayObject.scaleX = displayObject.scaleY = scale;
			
			// add to center
			this.x = (Main.STAGE_WIDTH - displayObject.width) / 2;
			this.y = (this.height - displayObject.height) / 2;
			
			m_closeButton.x = this.bounds.right - m_closeButton.width;
		}
		
	}
}