/**
 * Input UI와 Main UI를 그린다.
 * Input UI에 대한 입력 처리 또한 담당한다.
 */

package elements
{
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	import managers.CharacterManager;
	
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;

	public class Scene extends Sprite
	{
		private var m_input:TextField;
		private var m_characterManager:CharacterManager;
		private var m_id:String = "0";
		
		/**
		 * 사용자 정보를 갖는다.
		 */
		private var m_user:Object;
		
		public function Scene()
		{
			super();
			m_characterManager = new CharacterManager();
			m_characterManager.addEventListener("imageLoaded", initInputBox);
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
//			this.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			
			Main.comm.addEventListener("connect", onConnect);
			Main.comm.addEventListener("data", onData);
		}
		
		
		
		private function initInputBox():void
		{
			// initialize inputbox.
			m_input = new TextField();
			m_input.border = true;
			m_input.defaultTextFormat = new TextFormat("Helvetica", 22, 0x000000);
			m_input.width = 580;
			m_input.height = 25;
			m_input.x = 20;
			m_input.y = 350;
			m_input.type = TextFieldType.INPUT;
			
			Starling.current.nativeOverlay.addChild(m_input);
			
			m_input.addEventListener(FocusEvent.FOCUS_IN, 
				function(event:FocusEvent):void
				{
					trace("focused");
					// show soft keyboard
					m_input.needsSoftKeyboard  = true;
					//m_input.requestSoftKeyboard();									   
					
				});
			
			m_input.addEventListener(flash.events.KeyboardEvent.KEY_UP , 
				function(event:flash.events.KeyboardEvent):void 
				{
					if (event.keyCode == 13 && m_input.text) 
					{
						var arr:Array = m_input.text.split(":");
						if (arr.length > 1)
							m_id = arr[0].toString();
						
						var d:Object = {"idx":m_id,"script":m_input.text};
						
						Main.comm.send(JSON.stringify(d));
						m_input.text = "";
					}
				});
		}
		
		private function onConnect():void
		{
			// TODO Auto Generated method stub
			trace("connected.");
//			m_id = "0";
		}
		
		private function onData(event:Event):void
		{
//			var script:String = event.data.script;
			
			var d:Object = JSON.parse(event.data.toString());
			actNext(d);
		}		
		
		private function onEnterFrame(event:Event):void
		{
			
		}
		
		private function onAddedToStage(event:Event):void
		{
			trace("Welcome to Broca.ly");
//			var charac13:Character = new Character();
//			this.addChild(charac1);
//			
//			characters.push(charac1);
			
			// ActionButtons
			var button1:Sprite = ActionButtons.Button("1");
			button1.x = 0;
			button1.y = 350;
			this.addChild(button1);
			
			button1.addEventListener(TouchEvent.TOUCH, onButtonTouch);
		}
		
		private function onButtonTouch(event:TouchEvent):void
		{
			var sp:Sprite = event.currentTarget as Sprite;
			
			for (var i:int = 0; i < 4; i++) 
			{
				var button:Sprite = ActionButtons.Button("sub" + i.toString());
				this.addChild(button);
				//					var gPoint:Point = globalToLocal(new Point(button1.x, button1.y));
				var t:Number = Math.PI/3 * i - Math.PI/2;
				var r:int = 60;
				button.x = sp.x + r * Math.cos(t);
				button.y = sp.y + r * Math.sin(t);
				//					
			}
			
			sp.removeEventListeners(TouchEvent.TOUCH);			
		}
		
		private function actNext(data:Object):void
		{
			// 캐릭터 찾기
			var id:String = data.idx;
			var character:Character = m_characterManager.findCharacter(id);
			if (character == null)
			{
				character = m_characterManager.newCharacter(id);
				this.addChild(character);
			}
			
			// 액션.
			character.act(data.script);
		}
		
		private function actPrevious(data:Object):void
		{
				
		}
		
		
	}
}