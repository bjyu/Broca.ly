package elements
{
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.SoftKeyboardEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
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
		private var m_faceButton:starling.display.Button;
		private var m_sendButton:starling.display.Button;
		
		public static const INPUTBOX_POS_Y:Number = 600;		
		
		public function get softKeyboardRect():Rectangle
		{
			return m_input ? m_input.stage.softKeyboardRect : null;
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
			m_input.stage.focus = m_input;
			m_input.requestSoftKeyboard();
		}
		
		protected function initialize():void
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
//			m_input.needsSoftKeyboard  = true;
//			m_input.requestSoftKeyboard();
			
			Starling.current.nativeOverlay.addChild(m_input);
			
//			m_input.addEventListener(flash.events.KeyboardEvent.KEY_UP , 
//				function(event:flash.events.KeyboardEvent):void 
//				{
					// To Do #1. 
//					if (event.keyCode == 13 && m_input.text) 
//					{
//						var arr:Array = m_input.text.split(":");
//						if (arr.length > 1)
//							m_id = arr[0].toString();
//						
//						var d:Object = {"userId":m_id,"speech":m_input.text};
//						
//						Main.comm.send(JSON.stringify(d));
//						m_input.text = "";
//					}
//				});
			
			m_input.addEventListener(SoftKeyboardEvent.SOFT_KEYBOARD_ACTIVATE, onKeyboardActvate);
			m_input.addEventListener(SoftKeyboardEvent.SOFT_KEYBOARD_DEACTIVATE, onKeyboardDeactivate);
			
			m_input.addEventListener(FocusEvent.FOCUS_OUT, onFocusOut);
			
			// 
			m_faceButton = new Button(Assets.getTexture("space"));
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
			m_sendButton = new Button(Assets.getTexture("space"));
			
			m_sendButton.width = 100;
			m_sendButton.height = m_input.height;
			
			m_sendButton.y = m_input.y;
			m_sendButton.text = "Send";
			m_sendButton.addEventListener(Event.TRIGGERED, onSendTriggered);
			
			
			addChild(m_sendButton);
			
			m_input.width -= m_faceButton.width + m_sendButton.width;
			m_faceButton.x = m_input.width;
			m_sendButton.x = m_faceButton.bounds.right;
		}
		
		// To Do #1 id 전역 위치 변경.
		private var m_id:String = "0";
		private function onSendTriggered():void
		{
//			dispatchEvent(new Event(""));
			
			var arr:Array = m_input.text.split(":");
			if (arr.length > 1)
				m_id = arr[0].toString();
			
			var d:Object = {"userId":m_id,"speech":m_input.text};
			
			Main.comm.send(JSON.stringify(d));
			m_input.text = "";
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
			
			this.dispatchEvent(new Event("keyboardActivated"));
			
			trace("onKeyboardActvate");
		}
		
		protected function preventDefault(event:SoftKeyboardEvent):void
		{
			event.preventDefault();
			m_input.stage.focus = null;
		}
	}
}