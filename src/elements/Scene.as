/**
 * Input UI와 Main UI를 그린다.
 * Input UI에 대한 입력 처리 또한 담당한다.
 * 
 * 캐릭터의 표현만 담당하도록 Refactoring 한다. - 14.07.22
 * (Main Layer)
 *  */

package elements
{
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;

	public class Scene extends Sprite
	{
		public function Scene()
		{
			super();
			
			var bg:Background = new Background();
			bg.initialize();
			addChild(bg);
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onResized():void
		{
			trace("stage is resized. - Scene.as");
		}
		
		
		private var m_testBtn:Sprite;
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			
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
	}
}