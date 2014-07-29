/**
 * ActionButton들의 구성을 담당한다.
 * menu depth별 목록을 모델로 가져야 한다.
 */ 
package managers
{
	import elements.ActionButtons;
	import elements.Character;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.EventDispatcher;
	import starling.events.TouchEvent;

	public class ActionButtonManager extends EventDispatcher
	{
		private var m_character:Character;
		private var m_menuLayer:Sprite;
		
		private var _depth:uint = 0;

		public function get depth():uint
		{
			return _depth;
		}

		public function set depth(value:uint):void
		{
			_depth = value;
			
			// list 재구성.
		}
		
		
		private var _numButtons:uint = 8;

		public function get numButtons():uint
		{
			return _numButtons;
		}

		public function set numButtons(value:uint):void
		{
			_numButtons = value;
		}

		
		public function ActionButtonManager(layer:Sprite)
		{
			m_menuLayer = layer;
		}
		
		
		// functions

		/**
		 * 필요한 버튼들을 구성한다.
		 */
		public function initialize(character:Character = null):void
		{
			/*
			 default 버튼 구성.
			 back, cancel
			 category
			 1. 날씨 (번개, 맑음, 비, 먹구름...)
			 2. 동물 (양, 까마귀, ...)
			 3. 동작 (껑충, 뒤돌아보기, 타격...)
			 4. 캐릭터 스페셜 (???)
			*/
			
			m_menuLayer.removeChildren(0, -1, true);
//			m_menuLayer.visible = true;
			
			show();
			
			if (character)
			{
				m_menuLayer.x = character.x;
				m_menuLayer.y = character.y;
			}
		}
		
		
		/**
		 * 버튼들을 나타낸다.
		 */
		public function show():void
		{
			createButton();
		}
		
		private function createButton():void
		{
			var button:Sprite = ActionButtons.Button("sub" + m_menuLayer.numChildren.toString());
			button.addEventListener(TouchEvent.TOUCH, 
				function():void
				{
//					m_menuLayer.visible = false;
					initialize();
				}
			);
			
			var yPadding:uint = 30;
			var t:Number = (Math.PI * 2 / _numButtons) * m_menuLayer.numChildren - Math.PI/2; // 12시 방향 기준.
			var r:Number = Main.STAGE_HEIGHT * 0.3 / 2;
			
			var buttonAddedToStage:Function;
			
			buttonAddedToStage = function():void
			{
				var initX:Number = Main.STAGE_WIDTH / 2 - button.width / 2;
				var initY:Number = r + yPadding; + button.height/2;
				
				// init start pos.
				button.scaleX = button.scaleY = 0.4;
				button.x = Main.STAGE_WIDTH / 2 - button.width / 2;
				button.y = r + yPadding + button.height/2;
				
				button.removeEventListener(Event.ADDED_TO_STAGE, buttonAddedToStage);
				var tween:Tween = new Tween(button, 0.2, Transitions.EASE_OUT_BACK);
				var newX:Number = initX + (r * Math.cos(t));
				var newY:Number = initY + (r * Math.sin(t));
				tween.moveTo(newX, newY);
				tween.scaleTo(1.0);
				tween.onUpdate =
					function():void
					{
						if (tween.progress > 0.5)
							if (m_menuLayer.numChildren < _numButtons)
								createButton();
					};
				tween.onComplete =  
					function():void 
					{
						Starling.juggler.remove(tween);
					};
				
				Starling.juggler.add(tween);
				
//				trace("layer numChildren:" + m_menuLayer.numChildren);
			};
			
			button.addEventListener(Event.ADDED_TO_STAGE, buttonAddedToStage);
			
			m_menuLayer.addChild(button);
		}
		
	}
}