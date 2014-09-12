package ly.broca.controller
{
	import ly.broca.model.CharacterModel;
	import ly.broca.model.RootModel;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.EventDispatcher;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	public class RootController extends EventDispatcher
	{
		private var _children:Array = new Array();
		
		public function RootController(root:RootModel, view:Sprite)
		{
			root.controller = this;
			
			for each(var m:CharacterModel in root.children)
			{
				var c:CharacterController = new CharacterController(m);
				view.addChild(c.view);
				
				trace("child numChildren:" + c.view.numChildren);
				this.addController(c);
			}
			
			trace("root numChildren: " + view.numChildren);
		}
		
		public function addController(child:CharacterController):void
		{
			_children.push(child);
			var self:EventDispatcher = this;
			
			child.view.addEventListener(TouchEvent.TOUCH, 
				function(e:TouchEvent):void
				{
					if (e.getTouch(child.view, TouchPhase.ENDED))
					{
						self.dispatchEvent(new Event("characterTouched", false, child.view));
						
						/** Important: stop bubbles.*/
						e.stopImmediatePropagation();
					}
				}
			);
//			dispatchEvent(new Event("modelAdded"));
		}
		
		public function removeController(child:Object):void
		{
			var found:int = _children.indexOf(child, 0);
			if (found > -1) {
				_children.splice(found, 1);
//				dispatchEvent(new Event("modelRemoved"));
			}
		}
	}
}