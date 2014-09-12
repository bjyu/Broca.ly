package elements
{
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.SoftKeyboardEvent;
	import flash.system.Capabilities;
	import flash.text.StageText;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	import feathers.controls.Button;
	
	import network.Comm;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class InputBox extends Sprite
	{
		/**
		 * AS3 List에 추가 된다.
		 */
		private var m_input:flash.text.TextField;
		private var m_inputBackground:Image;

		private var m_faceButton:starling.display.Button;
		private var m_sendButton:starling.display.Button;
//		private var m_sendButton:feathers.controls.Button;
		
		private var _faceId:String;

		/**
		 * faceBox에서 선택된 아이디.
		 */
		public function get faceId():String
		{
			return _faceId;
		}

		/**
		 * @private
		 */
		public function set faceId(value:String):void
		{
			_faceId = value;
		}

		// Device별 정리 필요.
		public static var INPUTBOX_POS_Y:Number = 636;		
		
//		public function get softKeyboardRect():Rectangle
//		{
//			return Starling.current.nativeStage.softKeyboardRect;
//		}
		
		/**
		 * Constructor
		 */
		public function InputBox()
		{
			super();
			
			initialize();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage():void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			// show as begin
			m_input.stage.focus = m_input;
			m_input.requestSoftKeyboard();
			
			
		}
		
		private function initialize():void
		{
			// stageText for removing typing hint, fake.
			var stageText:StageText = new StageText();
			stageText.stage = Starling.current.nativeStage;
			
			// inline event
			function focusOut():void
			{
				stageText.assignFocus();
				Starling.current.nativeStage.focus = m_input;
			}
			
			m_inputBackground = new Image(Assets.getAtlas("LayoutAtlas").getTexture("inputBox"));
			m_inputBackground.y = INPUTBOX_POS_Y;
//			m_inputBackground.width = 650;
			addChild(m_inputBackground);
			
			// initialize inputbox.
			var padding:int = 12;
			m_input = new TextField();
			
			m_input.visible = true;
//			m_input.border = true;
			//			m_input.multiline = true;
			m_input.wordWrap = true;
			m_input.defaultTextFormat = new TextFormat("Helvetica", 22, 0x000000);
//			m_input.width = Main.STAGE_WIDTH;
			m_input.height = 48;
			m_input.x = padding;
			m_input.y = INPUTBOX_POS_Y + /*offset*/ + padding;
			
//			var initY:Number = Starling.current.nativeStage.softKeyboardRect.y;
//			m_input.y = initY > 0 ? initY : INPUTBOX_POS_Y;
//			trace("inputBox initY:" + initY);
			
			m_input.type = TextFieldType.INPUT;
			
			// show soft keyboard
//			m_input.needsSoftKeyboard  = true;
//			m_input.requestSoftKeyboard();
			
			Starling.current.nativeOverlay.addChild(m_input);
			
			m_input.addEventListener(SoftKeyboardEvent.SOFT_KEYBOARD_ACTIVATE, onKeyboardActivate);
			m_input.addEventListener(SoftKeyboardEvent.SOFT_KEYBOARD_DEACTIVATE, onKeyboardDeactivate);
			m_input.addEventListener(FocusEvent.FOCUS_OUT, focusOut);
			
//			var onKeyUp:Function;
			
//			onKeyUp = function(event:KeyboardEvent):void
//			{
//				trace(event.keyCode.toString());
////				event.preventDefault();
//			};
			
//			m_input.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
//			m_input.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			
			m_faceButton = new starling.display.Button(Assets.getAtlas("LayoutAtlas").getTexture("faceButton"));
//			m_faceButton.width = 50;
//			m_faceButton.height = m_input.height;
			
			m_faceButton.y = m_inputBackground.y;
//			m_faceButton.text = ":)";
			
			addChild(m_faceButton);
			
			m_faceButton.addEventListener(Event.TRIGGERED, 
				function(event:Event):void
				{
					m_input.removeEventListener(FocusEvent.FOCUS_OUT, focusOut);
					m_input.stage.focus = null;
					m_input.addEventListener(FocusEvent.FOCUS_OUT, focusOut);
					trace("triggered");
				}
			);
			
			// sendButton
//			m_sendButton = new feathers.controls.Button();
			m_sendButton = new starling.display.Button(Assets.getAtlas("LayoutAtlas").getTexture("sendButton"));
			
//			m_sendButton.width = 100;
//			m_sendButton.height = m_input.height;
//			
			m_sendButton.y = m_inputBackground.y;
//			m_sendButton.label = "Send";
			m_sendButton.addEventListener(Event.TRIGGERED, onSendTriggered);
			
			
			addChild(m_sendButton);
			
			
			m_inputBackground.width = Main.STAGE_WIDTH - m_faceButton.width - m_sendButton.width; 
			m_input.width =  m_inputBackground.width - padding * 2;
			
			m_faceButton.x = m_inputBackground.width;
			m_sendButton.x = m_faceButton.bounds.right;
			
		}
		
		
		private function onSendTriggered():void
		{
			trace("sendButton Triggered");
			
			var d:Object;
			
			// To Do # this code must be removed.
			{
				var arr:Array = m_input.text.split(":");
				if (arr.length > 1)
				{
					d = {"type":"msg", "room": Comm.room, "userId":arr[0].toString(), "speech":m_input.text, "faceId":faceId};
					Main.comm.send(d);
//					Main.comm.send(JSON.stringify(d));
					m_input.text = "";
					return;
				}
			}
			
			d = {"speech":m_input.text, "faceId":faceId};
			
			Main.comm.send(d);
//			Main.comm.send(JSON.stringify(d));

			m_input.text = "";
		}
		
		protected function onKeyboardDeactivate(event:SoftKeyboardEvent):void
		{
			//			m_input.requestSoftKeyboard();
			// 위치가 변경되면 invalidate 시켜야 할 수 있다. 이벤트 오작동이 있음.			
			//			m_input.y = stage.stageHeight - m_input.height;
			trace("onKeyboardDeactivate");
		}
		
		protected function onKeyboardActivate(event:SoftKeyboardEvent):void
		{
			//			var r:Rectangle = m_input.stage.softKeyboardRect;
			//			m_input.y = r.y - m_input.height *2;// - KEYBOARD_LOCATION_PADDING;
			
			trace(Capabilities.manufacturer);
			if (!m_input.visible)
			{
				m_input.y = Starling.current.nativeStage.softKeyboardRect.y - m_input.height;
				
				// softKeyboardRect is incorrect on android. so need to calibrate.
				var padding:Number = 40;
				if (Capabilities.manufacturer.indexOf("Android") != -1)
					m_input.y -= padding;					

				m_input.visible = true;
				
				// stage is different.
				this.y = m_input.y;
			}
			
//			trace(Starling.current.nativeStage.softKeyboardRect.toString());
			this.dispatchEvent(new Event("keyboardActivated"));
			trace("onKeyboardActivate");
		}

	}
}