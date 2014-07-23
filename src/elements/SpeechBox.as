package elements
{
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	
	public class SpeechBox extends Sprite
	{
		private var m_nameTextField:TextField;
		private var m_wordsTextField:TextField;
		
		public function SpeechBox()
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			initialize();
		}
		
		protected function initialize():void
		{
			m_nameTextField = new TextField(100, 30, "");
			m_nameTextField.border = true;
			this.addChild(m_nameTextField);
			
			m_wordsTextField = new TextField(stage.stageWidth * 0.9, 80, "");
			m_wordsTextField.fontSize = 20;
			m_wordsTextField.hAlign = HAlign.LEFT
			m_wordsTextField.border = true;
			
			m_wordsTextField.x = stage.stageWidth * 0.05;
			m_wordsTextField.y = m_nameTextField.bounds.height;
			
			this.addChild(m_wordsTextField);
		}
		
		/**
		 * 대사창을 갱신합니다.
		 */
		public function update(name:String,speech:String):void
		{
			m_nameTextField.text = name;
			m_wordsTextField.text = speech;	
		}
	}
}