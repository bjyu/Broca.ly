package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageAspectRatio;
	import flash.display.StageScaleMode;
	
	import Array;
	
	import flexunit.flexui.FlexUnitTestRunnerUIASMobile;
	
	import tests.ButtonModel_Parse_Test;
	import tests.DataSchemeTest;
	
	public class FlexUnitApplication extends Sprite
	{
		public function FlexUnitApplication()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_BORDER;
			stage.setAspectRatio(StageAspectRatio.PORTRAIT);
			onCreationComplete();
		}
		
		private function onCreationComplete():void
		{
			var testRunner:FlexUnitTestRunnerUIASMobile=new FlexUnitTestRunnerUIASMobile(stage.fullScreenWidth, stage.fullScreenHeight);
			testRunner.portNumber=8765; 
			this.addChild(testRunner); 
			testRunner.runWithFlexUnit4Runner(currentRunTestSuite(), "Broca.ly");
		}
		
		public function currentRunTestSuite():Array
		{
			var testsToRun:Array = new Array();
//			testsToRun.push(tests.DataSchemeTest);
			testsToRun.push(tests.ButtonModel_Parse_Test);
			return testsToRun;
		}
	}
}