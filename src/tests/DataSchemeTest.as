package tests
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import network.Comm;
	
	import org.flexunit.asserts.assertTrue;
	import org.flexunit.async.Async;
	
	import starling.events.Event;
	

	public class DataSchemeTest
	{	
		private var m_adapter:Sprite;
		
		[Before]
		public function setUp():void
		{
			m_adapter = new Sprite();
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		[BeforeClass]
		public static function setUpBeforeClass():void
		{
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}

		// 참고. 비동기 호출 단위 테스팅 http://qiita.com/__hage__/items/554da38d751f1e0aee1e
		[Test (async, timeout="2000")]		
		public function testModel():void
		{
			m_adapter.addEventListener(flash.events.Event.COMPLETE, Async.asyncHandler(this, onComplete, 2000));
			
			var comm:Comm = new Comm();
			comm.addEventListener("data", onData);
			
			var jsonData:Object = {"idx":"1","script":"test"};
			
			trace("send: " + JSON.stringify(jsonData));
			comm.send(JSON.stringify(jsonData));
		}
		
		private function onComplete(event:flash.events.Event, ctx:Object):void
		{
			trace("onComplete");
			assertTrue(true);
		}
		
		private function onData(event:starling.events.Event):void
		{
			try
			{
				var m:Object = JSON.parse(event.data.toString());
				trace("idx: " + m.idx);
				trace("script: " + m.script);
				
				m_adapter.dispatchEvent( new flash.events.Event( flash.events.Event.COMPLETE ));
			}
			catch(e:Error)
			{
				assertTrue(false);	
			}

		}		
		
	}
}