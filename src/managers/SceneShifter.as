/**
 * 사용자 입력 영역과 캐릭터 표현 영역(Scene)을 표현하고, 입력 이벤트를 필요한 곳에 전달해준다.
 */

package managers
{
	import elements.Character;
	import elements.FaceBox;
	import elements.InputBox;
	import elements.Scene;
	import elements.SpeechBox;
	
	import events.SelectEvent;
	
	import feathers.themes.MetalWorksMobileTheme;
	
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	
	public class SceneShifter extends Sprite
	{
		// variables
		
		// main layer
		private var m_scene:Scene; 
		
		// action menu layer
		private var m_menuLayer:Sprite;
		
		// preview layer
		private var m_previewLayer:Sprite;
		
		private var m_speechBox:SpeechBox;
		private var m_inputBox:InputBox
		private var m_faceBox:FaceBox;
		
		private var m_characterManager:CharacterManager;
		private var m_actionButtonManager:ActionButtonManager;
		private var m_previewManager:PreviewManager;
		
		private var m_startInfo:Object = { 
			"info":[
					{"characterID":"character0", "isoX":"1", "isoY":"0"},
					{"characterID":"character1", "isoX":"2", "isoY":"0"},
					{"characterID":"character2", "isoX":"0", "isoY":"1"},
					{"characterID":"character6", "isoX":"2", "isoY":"1"},
					{"characterID":"character7", "isoX":"0", "isoY":"2"},
					{"characterID":"character11", "isoX":"1", "isoY":"2"},
				   ]
		};
		
		public function SceneShifter(startInfo:Object = null)
		{
			super();
			
			if (startInfo)
				m_startInfo = startInfo;
			
			loadResources();
		}
		
		private function loadResources():void
		{
			// loading image resources...
//			new MetalWorksMobileTheme();
			
			Assets.getAtlas("ActionButtonAtlas", Assets.getTexture("ActionButtons"), loadLayout);
			
			function loadLayout():void 
			{
				Assets.getAtlas("LayoutAtlas", Assets.getTexture("LayoutAtlas"), loadCharacters);
			}
			
			function loadCharacters():void 
			{
				Assets.getAtlas("CharactersAtlas", Assets.getTexture("CharactersAtlas"), initialize);
			}
			
			
//			Assets.addEventListener("ActionButtonAtlasLoaded", initialize);
			
		}
		
		/**
		 * initialize.
		 */
		protected function initialize():void
		{
			// building components
			//  scene
			m_scene = new Scene();
			m_scene.addEventListener(Event.ADDED_TO_STAGE, onSceneAddedToStage);
			
			addChild(m_scene);
			
			
			m_previewLayer = new Sprite();
			addChild(m_previewLayer);
			
			m_menuLayer = new Sprite();
			addChild(m_menuLayer);
			
			// init managers
			m_characterManager = new CharacterManager(m_startInfo, function():void {
					m_scene.addChild(m_characterManager.rootView);
					m_characterManager.rootView.y = m_speechBox.y - m_characterManager.rootView.height;
				} );
//				function():void {m_scene.addChild(m_characterManager.rootView);});
			
			
			
			//			m_characterManager.addEventListener("imageLoaded", initInputBox2);
			Main.comm.addEventListener("connect", onConnect);
			Main.comm.addEventListener("data", onData);
			
			m_actionButtonManager = new ActionButtonManager(m_menuLayer);
			m_actionButtonManager.addEventListener(SelectEvent.SELECTED, 
				function(event:SelectEvent):void
				{
					// 1. inputBox에 아이디 전달.
					// 2. subCatId가 있으면 버튼 재구성.
					
					// To Do # define effect resources.
//					m_previewManager.preview.showEffect(event.data.toString());
				}
			);
			
			m_previewManager = new PreviewManager(m_previewLayer);
			
		
			// To Do # remove this line (test code)
//			m_actionButtonManager.initialize("main");
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
					// 4. faceBox
					if (m_faceBox == null)
					{
						m_faceBox = new FaceBox();
						m_faceBox.y = Starling.current.nativeStage.softKeyboardRect.y;
						m_faceBox.width = stage.stageWidth;
						m_faceBox.height = Starling.current.nativeStage.softKeyboardRect.height;
						m_faceBox.addEventListener(SelectEvent.SELECTED, 
							function(event:SelectEvent):void
							{
								m_inputBox.faceId = event.data.toString();
								
								// preview
								m_previewManager.preview.showCharacter(m_inputBox.faceId);
							}
						);
						addChild(m_faceBox);
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
			
			// find model
			
			
			// assign data to model props
			
			// speech data to speechBox
			
//			actNext(d);
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
				character.addEventListener(TouchEvent.TOUCH, onCharacterTouch);
				m_scene.addChild(character);
			}
			
			character.faceId = data.faceId;
			
			// 액션.
			m_characterManager.act(character);
			
			m_speechBox.update(id, data.speech);
		}
		
		private function onCharacterTouch(event:TouchEvent):void
		{
//			m_actionButtonManager.initialize(Character(event.currentTarget).name);
		}
		
		private function actPrevious(data:Object):void
		{
			
		}
		
	}
}