package ly.broca.model
{
	import ly.broca.controller.RootController;
	
	import starling.events.Event;
	import starling.events.EventDispatcher;

	public class RootModel extends EventDispatcher
	{
		public var children:Array = new Array();
		
		public var controller:RootController;
		
		public function RootModel()
		{
			
		}
		
		public function addChild(child:Object):void
		{
			children.push(child);
			
			dispatchEvent(new Event("modelAdded"));
		}
		
		public function removeChild(child:Object):void
		{
			var found:int = children.indexOf(child, 0);
			if (found > -1) {
				children.splice(found, 1);
				dispatchEvent(new Event("modelRemoved"));
			}
		}
	}
}