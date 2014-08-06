package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageOrientation;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import feathers.core.FocusManager;
	
	import managers.SceneShifter;
	
	import network.Comm;
	
	import starling.core.Starling;
	
	[SWF(frameRate="60")]
	public class Main extends Sprite
	{
		private var myStarling:Starling;
		
		public static var STAGE_WIDTH:Number;
		public static var STAGE_HEIGHT:Number;
		public static var comm:Comm;
		
		public function Main()
		{
			super();
			
			// support autoOrients
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.setOrientation(StageOrientation.DEFAULT);
			
			stage.addEventListener(Event.RESIZE, onResize);
	
			// touch or gesture?
//			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			// device boundary (dev)
			graphics.lineStyle(2, 0XFF0000);
			graphics.drawRect(0, 0, stage.fullScreenWidth, stage.fullScreenHeight);
			trace("fullScreen: " + stage.fullScreenWidth + ", " +  stage.fullScreenHeight);
			
			STAGE_WIDTH = stage.fullScreenWidth;
			STAGE_HEIGHT = stage.fullScreenHeight;
			
			// starting starling.
			myStarling = new Starling(SceneShifter, stage);
			myStarling.antiAliasing = 1;
			myStarling.start();
			
//			FocusManager.isEnabled = true;
			
			comm = new Comm();
			
		}
		
		protected function onResize(event:Event):void
		{
			// TODO Auto-generated method stub
			trace("stage is resized.");
		}
	}
}