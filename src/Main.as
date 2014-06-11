package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageOrientation;
	import flash.display.StageScaleMode;
//	import flash.ui.Multitouch;
//	import flash.ui.MultitouchInputMode;
	
	import elements.Scene;

	import network.Comm;
	
	
	import starling.core.Starling;
	
	[SWF(frameRate="60")]
	public class Main extends Sprite
	{
		private var myStarling:Starling;
		public static var STAGE_WIDTH:Number;
		public static var comm:Comm;
		
		public function Main()
		{
			super();
			
			// support autoOrients
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.setOrientation(StageOrientation.DEFAULT);
	
			// touch or gesture?
//			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			// device boundary
			graphics.lineStyle(2, 0XFF0000);
			graphics.drawRect(0, 0, stage.fullScreenWidth, stage.fullScreenHeight);
			trace("fullScreen: " + stage.fullScreenWidth + ", " +  stage.fullScreenHeight);
			
			STAGE_WIDTH = stage.fullScreenWidth;
			
			// starting starling.
			myStarling = new Starling(Scene, stage);
//			myStarling.antiAliasing = 1;
			myStarling.start();
			
			comm = new Comm();
			
		}
	}
}