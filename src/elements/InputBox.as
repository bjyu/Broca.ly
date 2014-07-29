package elements
{
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.SoftKeyboardEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	import feathers.controls.Button;
	import feathers.events.FeathersEventType;
	import feathers.text.StageTextField;
	import feathers.themes.MetalWorksMobileTheme;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class InputBox extends Sprite
	{
		/**
		 * AS3 Lists에 추가 된다.
		 */
		private var m_input:TextField;
		
		// autoCorrect 문제로 인한 대체 컴포넌트 (not resolved.)
		private var m_input2:StageTextField;
		
		
		private var m_faceButton:starling.display.Button;
		private var m_sendButton:feathers.controls.Button;
		
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
		public static var INPUTBOX_POS_Y:Number = 600;		
		
		public function get softKeyboardRect():Rectangle
		{
			return m_input ? m_input.stage.softKeyboardRect : new Rectangle(0,600,800,460);
		}
		
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
//			m_input.stage.focus = m_input;
//			m_input.requestSoftKeyboard();
		}
		
		private function initialize2():void
		{
			// initialize inputbox.
			m_input = new TextField();
			m_input.border = true;
			//			m_input.multiline = true;
			m_input.wordWrap = true;
			m_input.defaultTextFormat = new TextFormat("Helvetica", 22, 0x000000);
			m_input.width = Main.STAGE_WIDTH;
			m_input.height = 50;
			m_input.x = 0;
			m_input.y = INPUTBOX_POS_Y;
			m_input.type = TextFieldType.INPUT;
			
			// show soft keyboard
			m_input.needsSoftKeyboard  = true;
			m_input.requestSoftKeyboard();
			
			Starling.current.nativeOverlay.addChild(m_input);
			
			m_input.addEventListener(SoftKeyboardEvent.SOFT_KEYBOARD_ACTIVATE, onKeyboardActivate);
			m_input.addEventListener(SoftKeyboardEvent.SOFT_KEYBOARD_DEACTIVATE, onKeyboardDeactivate);
			
			m_input.addEventListener(FocusEvent.FOCUS_OUT, onFocusOut);
			
			var onKeyUp:Function;
			
			onKeyUp = function(event:KeyboardEvent):void
			{
				event.preventDefault();
			};
			
			m_input.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			m_input.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			
			m_faceButton = new starling.display.Button(Assets.getTexture("space"));
			m_faceButton.width = 50;
			m_faceButton.height = m_input.height;
			
			m_faceButton.y = m_input.y;
			m_faceButton.text = ":)";
			
			addChild(m_faceButton);
			
			m_faceButton.addEventListener(Event.TRIGGERED, 
				function(event:Event):void
				{
					m_input.removeEventListener(FocusEvent.FOCUS_OUT, onFocusOut);
					m_input.stage.focus = null;
					trace("triggered");
				}
			);
			
			// sendButton
			m_sendButton = new feathers.controls.Button();
			
			m_sendButton.width = 100;
			m_sendButton.height = m_input.height;
			
			m_sendButton.y = m_input.y;
			m_sendButton.label = "Send";
			m_sendButton.addEventListener(Event.TRIGGERED, onSendTriggered);
			
			
			addChild(m_sendButton);
			
			m_input.width -= m_faceButton.width + m_sendButton.width;
			m_faceButton.x = m_input.width;
			m_sendButton.x = m_faceButton.bounds.right;
		}
		
		protected function initialize():void
		{
			// m_input2;
			m_input2 = new StageTextField({multiline:true});
			m_input2.editable = true;
			
			m_input2.autoCorrect = false;
			m_input2.fontSize = 22;
			m_input2.fontFamily = "Helvetica";
			m_input2.viewPort = new Rectangle(0, INPUTBOX_POS_Y, Main.STAGE_WIDTH, 40);
			
			m_input2.addEventListener(SoftKeyboardEvent.SOFT_KEYBOARD_ACTIVATE, onKeyboardActivate);
			m_input2.addEventListener(SoftKeyboardEvent.SOFT_KEYBOARD_DEACTIVATE, onKeyboardDeactivate);
			
			m_input2.addEventListener(FocusEvent.FOCUS_OUT, onFocusOut);
			
			m_input2.stage = Starling.current.nativeStage;
			
			// 
			m_faceButton = new starling.display.Button(Assets.getTexture("space"));
			m_faceButton.width = 50;
			m_faceButton.height = m_input2.viewPort.height;
			
			m_faceButton.y = m_input2.viewPort.y;
			m_faceButton.text = ":)";
			
			addChild(m_faceButton);
			
			m_faceButton.addEventListener(Event.TRIGGERED, 
				function(event:Event):void
				{
					m_input2.removeEventListener(FocusEvent.FOCUS_OUT, onFocusOut);
					m_input2.stage.focus = null;
					trace("triggered");
				}
			);
			
			new MetalWorksMobileTheme();
			// sendButton
			m_sendButton = new feathers.controls.Button();
			
			m_sendButton.width = 100;
			m_sendButton.height = m_input2.viewPort.height;
			
			m_sendButton.y = m_input2.viewPort.y;
			m_sendButton.label = "Send";
			m_sendButton.addEventListener(Event.TRIGGERED, onSendTriggered);
			
			
			addChild(m_sendButton);
			
			m_input2.viewPort.width -= m_faceButton.width + m_sendButton.width;
			m_faceButton.x = m_input2.viewPort.width;
			m_sendButton.x = m_faceButton.bounds.right;
		}
		
		private function onSendTriggered():void
		{
//			dispatchEvent(new Event(""));
			trace("sendButton Triggered");
			
//			m_sendButton.focusManager = null;;
			
			var d:Object;
			
			// To Do # this code must be removed.
			{
				var arr:Array = m_input2.text.split(":");
				if (arr.length > 1)
				{
					d = {"userId":arr[0].toString(), "speech":m_input2.text};
					Main.comm.send(d);
//					Main.comm.send(JSON.stringify(d));
					m_input2.text = "";
					return;
				}
			}
			
			d = {"speech":m_input2.text};
			
			Main.comm.send(d);
//			Main.comm.send(JSON.stringify(d));

			m_input2.text = "";
			
			// To Do # ignore keyword hint.
//			m_input.stage.dispatchEvent(new KeyboardEvent(KeyboardEvent.KEY_UP, true, false, 13, 13));
			
		}
		
		protected function onFocusOut(event:FocusEvent):void
		{
//			m_input.stage.focus = m_input;
			m_input2.assignFocus();
			
			trace("focus out");
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
			
			if (!m_input.hasEventListener(FocusEvent.FOCUS_OUT))
				m_input.addEventListener(FocusEvent.FOCUS_OUT, onFocusOut);
			
			this.dispatchEvent(new Event("keyboardActivated"));
			
			trace("onKeyboardActvate");
		}
		
//		protected function preventDefault(event:SoftKeyboardEvent):void
//		{
//			event.preventDefault();
//			m_input.stage.focus = null;
//		}
	}
}