/**
 * 사용자 입력 영역과 캐릭터 표현 영역(Scene)을 표현하고, 입력 이벤트를 필요한 곳에 전달해준다.
 */

package managers
{
	import flash.geom.Rectangle;
	import flash.text.TextFormat;
	
	import elements.ActingInputBox;
	import elements.Character;
	import elements.InputBox;
	import elements.Scene;
	import elements.SpeechBox;
	
	import feathers.controls.TextInput;
	import feathers.core.ITextEditor;
	import feathers.events.FeathersEventType;
	
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	
	import utils.MyTextFieldTextEditor;
	
	public class SceneShifter extends Sprite
	{
		// variables
		private var m_scene:Scene;
		private var m_speechBox:SpeechBox;
		private var m_inputBox:InputBox
		private var m_actingInputBox:ActingInputBox;
		
		private var m_characterManager:CharacterManager;
		
		public function SceneShifter()
		{
			super();
			
			initialize();
		}
		
		/**
		 * initialize.
		 */
		protected function initialize():void
		{
			// loading image resources...
			
			
			// building components
			// 1. scene
			m_scene = new Scene();
			m_scene.addEventListener(Event.ADDED_TO_STAGE, onSceneAddedToStage);
			
			addChild(m_scene);
			
			
			// init managers
			m_characterManager = new CharacterManager();
			//			m_characterManager.addEventListener("imageLoaded", initInputBox);
			//			m_characterManager.addEventListener("imageLoaded", initInputBox2);
			Main.comm.addEventListener("connect", onConnect);
			Main.comm.addEventListener("data", onData);
		}
		
		// event handlers
		private function onSceneAddedToStage():void
		{
			m_scene.removeEventListener(Event.ADDED_TO_STAGE, onSceneAddedToStage);
			
			// 2. speechBox
			m_speechBox = new SpeechBox();
			var onSpeechBoxAddedToStage:Function;
			m_speechBox.addEventListener(Event.ADDED_TO_STAGE,
				onSpeechBoxAddedToStage = function():void
				{
					m_speechBox.removeEventListener(Event.ADDED_TO_STAGE, onSpeechBoxAddedToStage);
					m_speechBox.y = InputBox.INPUTBOX_POS_Y - m_speechBox.height;
				}
			);
			addChild(m_speechBox);
			
			// 3. inputBox
			m_inputBox = new InputBox();
			addChild(m_inputBox);
			
			m_inputBox.addEventListener("keyboardActivated", function(event:Event):void
			{
				// 4. actionBox
				if (m_actingInputBox == null)
				{
					m_actingInputBox = new ActingInputBox();
					m_actingInputBox.y = m_inputBox.softKeyboardRect.y;
					m_actingInputBox.width = stage.stageWidth;
					m_actingInputBox.height = m_inputBox.softKeyboardRect.height;
					
					addChild(m_actingInputBox);
				}
			}
			);
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

		
		// functions
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
			
			m_speechBox.update(id, data.speech);
		}
		
		private function actPrevious(data:Object):void
		{
			
		}
		
		private var m_input2:TextInput;
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
			
			//			m_speechBox.y = m_input2.y - m_speechBox.height;
			
			
			addChild(m_input2);
		}
	}
}