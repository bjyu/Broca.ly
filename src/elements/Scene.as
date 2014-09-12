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
		
		
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			trace("Welcome to Broca.ly");
		}
		
	}
}