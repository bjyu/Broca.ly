/**
 * ActionButton들의 구성을 담당한다.
 * 
 * 
 * 
 * buttonModel
 	 {	
		"name":"cat1",
 		"numButton":7,
 	 	"buttons":
		[
 			{ "id":"btn1", "desc":"1", "subCatId":"cat2"},
 			{ "id":"btn2", "desc":"2"},
			{ "id":"btn3", "desc":"3"},
			 .
			 .
 * 
 */ 
package managers
{
	import elements.ActionButton;
	import elements.Character;
	
	import events.SelectEvent;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.EventDispatcher;
	import starling.events.TouchEvent;

	public class ActionButtonManager extends EventDispatcher
	{
		private var m_character:Character;
		private var m_menuLayer:Sprite;
		private var m_buttonsModel:Object; // for creating button sequentially
		
		private var _depth:uint = 0;
		private var m_levels:Array;
		
		private var m_model:Object =
		[
			// category name
			{	
				"name":"main",
		 		"numButtons":6,
		 	 	"buttons":
				[
		 			{ "id":"btn1", "desc":"1", "subCat":"cat2"},
		 			{ "id":"btn2", "desc":"2", "subCat":""},
					{ "id":"btn3", "desc":"3", "subCat":""},
					{ "id":"btn4", "desc":"4", "subCat":""},
					{ "id":"btn5", "desc":"5", "subCat":""},
					{ "id":"btn6", "desc":"6", "subCat":""},
			 	]
			},
			{	
				"name":"cat2",
				"numButtons":3,
				"buttons":
				[
					{"id":"btn10", "desc":"back", "subCat":""},
					{"id":"btn8", "desc":"2", "subCat":""},
					{"id":"btn9", "desc":"3", "subCat":""}
				]
			}
		];

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

//		public function set numButtons(value:uint):void
//		{
//			_numButtons = value;
//		}

		
		public function ActionButtonManager(layer:Sprite)
		{
			m_menuLayer = layer;
			m_levels = new Array();
		}
		
		
		// functions

		/**
		 * 필요한 버튼들을 구성한다.
		 */
		public function initialize(catId:String = "main"):void
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
			
//			createBasicButtons();
			createButtons(catId);
//			if (character)
//			{
//				m_menuLayer.x = character.x;
//				m_menuLayer.y = character.y;
//			}
		}
		
		
		private function createButton(id:String, subCatId:String = ""):DisplayObject
		{
//			var buttonId:String = id ? id : "sub" + m_menuLayer.numChildren.toString();
//			var button:Sprite = ActionButtons.Button(buttonId);
			var button:ActionButton = new ActionButton(id);
			button.subCatId = subCatId;
			button.name = id;
			
			button.addEventListener(Event.ADDED_TO_STAGE, buttonAddedToStage);
			
			m_menuLayer.addChild(button);
			
			trace(id + "button added.");
			return button;
		}
		
		private function buttonAddedToStage(event:Event):void
		{
			var button:DisplayObject = DisplayObject(event.currentTarget);
			
			button.removeEventListener(Event.ADDED_TO_STAGE, buttonAddedToStage);
			
			var yPadding:uint = 30;
			var t:Number = (Math.PI * 2 / _numButtons) * m_menuLayer.numChildren - Math.PI/2; // 12시 방향 기준.
			var r:Number = Main.STAGE_HEIGHT * 0.3 / 2;
			
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
						{
							// nextButton
							var btn:Object = m_buttonsModel.buttons[m_menuLayer.numChildren];
							var id:String = btn.id.toString();						
							var subCatId:String = btn.subCat.toString();
							createButton(id,subCatId);
						}
				};
			tween.onComplete =  
				function():void 
				{
					Starling.juggler.remove(tween);
				};
			
			Starling.juggler.add(tween);
			
			//				trace("layer numChildren:" + m_menuLayer.numChildren);
			button.addEventListener(TouchEvent.TOUCH, onButtonTouch);
		}
		
		private function onButtonTouch(event:TouchEvent):void
		{
			var button:ActionButton = ActionButton(event.currentTarget);
//					m_menuLayer.visible = false;
			
			if (button.subCatId)
			{
				m_levels.push(button.subCatId);
				initialize(button.subCatId);
			}
			else if(button.name == "btn10")
			{
				var catId:String = "main";
				if (m_levels.length > 0)
					catId = m_levels[m_levels.length-1].toString()
						
				initialize(catId);
				m_levels.pop();
			}
			else
			{
				this.dispatchEvent(new SelectEvent(button.name));
			}
		}
		
		/** 
		 * model기준으로 버튼을 구성한다.
		 * */
		private function createButtons(name:String):void
		{
			for each (var o:Object in m_model)
			{
				if (o.name == name) 
				{
					m_buttonsModel = o;
					_numButtons = int(o.numButtons.toString());
					
					if (_numButtons > 0)
					{
						var b:Object = o.buttons[0];
						createButton(b.id.toString(), b.subCat.toString());
					}
					break;
				}
			}
		}
		
		private function createBasicButtons():void
		{
			return;
			
			// back
			var backButton:ActionButton = new ActionButton("btn10");
			backButton.addEventListener(Event.TRIGGERED,
				function():void
				{
					m_levels.pop();
				}
			);
		}
		
	}
}