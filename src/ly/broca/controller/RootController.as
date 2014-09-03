package ly.broca.controller
{
	import ly.broca.model.CharacterModel;
	import ly.broca.model.RootModel;
	
	import starling.display.Sprite;

	public class RootController
	{
		private var _children:Array = new Array();
		
		public function RootController(root:RootModel, view:Sprite)
		{
			root.controller = this;
			
			for each(var m:CharacterModel in root.children)
			{
				var c:CharacterController = new CharacterController(m);
				view.addChild(c.view);
				
				this.addController(c);
			}
		}
		
		public function addController(child:Object):void
		{
			_children.push(child);
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