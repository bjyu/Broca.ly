/**
 * Input UI와 Main UI를 그린다.
 * Input UI에 대한 입력 처리 또한 담당한다.
 */

package elements
{
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.SoftKeyboardEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	import feathers.controls.TextInput;
	import feathers.core.ITextEditor;
	import feathers.events.FeathersEventType;
	import feathers.text.StageTextField;
	
	import managers.CharacterManager;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	
	import utils.MyTextFieldTextEditor;

	public class Scene extends Sprite
	{
		
		private var m_input:TextField;
		private var m_input2:TextInput;
		private var m_actingInputBox:ActingInputBox;
		
		private var m_speechBox:SpeechBox;
		private var m_characterManager:CharacterManager;
		
		private var m_sendButton:starling.display.Button;
		
		private var m_id:String = "0";
		public static const KEYBOARD_LOCATION_PADDING:int = 22;
		
		/**
		 * 사용자 정보를 갖는다.
		 */
		private var m_user:Object;
		
		public function Scene()
		{
			super();
			
			var bg:Background = new Background();
			bg.initialize();
			addChild(bg);
			
			m_speechBox = new SpeechBox();
						
			this.addChild(m_speechBox);
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			Main.comm.addEventListener("connect", onConnect);
			Main.comm.addEventListener("data", onData);
			
		}
		
		private function onResized():void
		{
			trace("stage is resized. - Scene.as");
		}
		
		private function initInputBox2():void
		{
			m_input2 = new TextInput();
			m_input2.width = stage.stageWidth;
			m_input2.height = 40;
			
			m_input2.y = 400;
			
//			m_input2.textEditorProperties.fontName = "Helvetica";
//			m_input2.textEditorProperties.fontSize = 26;
			
			m_input2.textEditorFactory = function():ITextEditor
			{
				var textEditor:MyTextFieldTextEditor = new MyTextFieldTextEditor();
//				var textEditor:TextFieldTextEditor = new TextFieldTextEditor();
				textEditor.textFormat = new TextFormat("Helvetica", 26, 0x0);

				textEditor.multiline = true;
				return textEditor; 
			}
				
			
			m_input2.text = "type here...";
			
//			var bounds2:Rectangle = Starling.current.nativeStage.softKeyboardInputAreaOfInterest;
			
//			Starling.current.nativeStage.
			m_input2.addEventListener(FeathersEventType.SOFT_KEYBOARD_ACTIVATE,
				function():void
				{
					var bounds:Rectangle = Starling.current.nativeStage.softKeyboardRect;
					m_input2.y = bounds.y - m_input2.height * 2;
				}
			);
			
			m_input2.addEventListener(FeathersEventType.SOFT_KEYBOARD_DEACTIVATE,
				function():void
				{
					// To Do Sth.
					m_input2.focusManager.focus();
				}
			);
			
			m_speechBox.y = m_input2.y - m_speechBox.height;
			
			
			addChild(m_input2);
		}
		
		private function initInputBox():void
		{
			// initialize inputbox.
			m_input = new TextField();
			m_input.border = true;
//			m_input.multiline = true;
			m_input.wordWrap = true;
			m_input.defaultTextFormat = new TextFormat("Helvetica", 22, 0x000000);
			m_input.width = stage.stageWidth;
			m_input.height = 50;
			m_input.x = 0;
			m_input.y = 350;
			m_input.type = TextFieldType.INPUT;
			
			// show soft keyboard
//			m_input.needsSoftKeyboard  = true;
//			m_input.requestSoftKeyboard();
			
			Starling.current.nativeOverlay.addChild(m_input);
			
			m_input.addEventListener(flash.events.KeyboardEvent.KEY_UP , 
				function(event:flash.events.KeyboardEvent):void 
				{
					if (event.keyCode == 13 && m_input.text) 
					{
						var arr:Array = m_input.text.split(":");
						if (arr.length > 1)
							m_id = arr[0].toString();
						
						var d:Object = {"userId":m_id,"speech":m_input.text};
						
						Main.comm.send(JSON.stringify(d));
						m_input.text = "";
					}
				});
			
			m_input.addEventListener(SoftKeyboardEvent.SOFT_KEYBOARD_ACTIVATE, onKeyboardActvate);
			m_input.addEventListener(SoftKeyboardEvent.SOFT_KEYBOARD_DEACTIVATE, onKeyboardDeactivate);
			
			m_input.addEventListener(FocusEvent.FOCUS_OUT, onFocusOut);
			
			m_speechBox.y = m_input.y - m_speechBox.height;
			
			// sendButton
			m_sendButton = new Button(Assets.getTexture("space"));
			
			m_sendButton.width = 100;
			m_sendButton.height = m_input.height;
			
			m_sendButton.x = stage.stageWidth - m_sendButton.width;
			m_sendButton.y = m_input.y;
			
//			m_sendButton.label = "Send";
			
			m_input.width -= m_sendButton.width;
			
			
			m_sendButton.addEventListener(Event.TRIGGERED, 
				function(event:Event):void
				{
					m_input.removeEventListener(FocusEvent.FOCUS_OUT, onFocusOut);
					
					m_input.stage.focus = null;
					trace("triggered");
				}
			);
			
			addChild(m_sendButton);
			
		}
		
		protected function onFocusOut(event:FocusEvent):void
		{
			m_input.stage.focus = m_input;
			trace("focus out");
		}
		
		protected function onKeyboardDeactivate(event:SoftKeyboardEvent):void
		{
//			m_input.requestSoftKeyboard();
			// 위치가 변경되면 invalidate 시켜야 할 수 있다. 이벤트 오작동이 있음.			
//			m_input.y = stage.stageHeight - m_input.height;
			trace("onKeyboardDeactivate");
		}
		
		protected function onKeyboardActvate(event:SoftKeyboardEvent):void
		{
//			var r:Rectangle = m_input.stage.softKeyboardRect;
//			m_input.y = r.y - m_input.height *2;// - KEYBOARD_LOCATION_PADDING;
			
			if (!m_input.hasEventListener(FocusEvent.FOCUS_OUT))
				m_input.addEventListener(FocusEvent.FOCUS_OUT, onFocusOut);
			
			if (m_actingInputBox == null)
			{
				m_actingInputBox = new ActingInputBox();
				m_actingInputBox.y = m_input.stage.softKeyboardRect.y;
				m_actingInputBox.width = stage.stageWidth;
				m_actingInputBox.height = m_input.stage.softKeyboardRect.height;
				
				addChild(m_actingInputBox);
			}
			
			trace("onKeyboardActvate");
		}
		
		protected function preventDefault(event:SoftKeyboardEvent):void
		{
			event.preventDefault();
			m_input.stage.focus = null;
		}
		
		private function onConnect():void
		{
			trace("connected.");
//			m_id = "0";
		}
		
		private function onData(event:Event):void
		{
			var d:Object = JSON.parse(event.data.toString());
			actNext(d);
		}		
		
		private function onEnterFrame(event:Event):void
		{
			
		}
		
		private var m_testBtn:Sprite;
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			m_characterManager = new CharacterManager();
			m_characterManager.addEventListener("imageLoaded", initInputBox);
//			m_characterManager.addEventListener("imageLoaded", initInputBox2);
			
			this.stage.addEventListener(Event.RESIZE, onResized);
			
			trace("Welcome to Broca.ly");
			
			return;
			
			// ActionButtons
			m_testBtn = ActionButtons.Button("1");
			m_testBtn.x = 0;
			m_testBtn.y = 350;
			
			this.addChild(m_testBtn);
			
			m_testBtn.addEventListener(TouchEvent.TOUCH, onButtonTouch);
			
			
		}
		
		private function onButtonTouch(event:TouchEvent):void
		{
			var sp:Sprite = event.currentTarget as Sprite;
			
			for (var i:int = 0; i < 4; i++) 
			{
				var button:Sprite = ActionButtons.Button("sub" + i.toString());
				this.addChild(button);
				var t:Number = Math.PI/3 * i - Math.PI/2;
				var r:int = 60;
				button.x = sp.x + r * Math.cos(t);
				button.y = sp.y + r * Math.sin(t);
			}
			
			sp.removeEventListeners(TouchEvent.TOUCH);			
		}
		
		private function actNext(data:Object):void
		{
			// 캐릭터 찾기
			var id:String = data.userId;
			var character:Character = m_characterManager.findCharacter(id);
			if (character == null)
			{
				character = m_characterManager.newCharacter(id);
				
				this.addChild(character);
			}
			
			// 액션.
			m_characterManager.act(character);
//			character.act();
			m_speechBox.update(id, data.speech);
		}
		
		private function actPrevious(data:Object):void
		{
				
		}
	}
}