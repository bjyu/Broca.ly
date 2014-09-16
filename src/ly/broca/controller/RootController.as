package ly.broca.controller
{
	import flash.geom.Point;
	
	import ly.broca.model.CharacterModel;
	import ly.broca.model.RootModel;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.EventDispatcher;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	public class RootController extends EventDispatcher
	{
		private var _children:Array = new Array();
		
		// when touch started
		private var m_started:Number = 0;
		// is button began and holded for 750ms.
		private var m_isHolded:Boolean = false;
		// touch point
		private var m_touchPoint:Point;
		

		public function RootController(root:RootModel, view:Sprite)
		{
			m_touchPoint = new Point();
			
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
			
			// To Do # only for one user
			// if (child == user's)
			
			child.view.addEventListener(TouchEvent.TOUCH, 
				function(e:TouchEvent):void
				{
					var touch:Touch = e.getTouch(child.view);
					if (!touch) return;
					
					if (touch.phase == TouchPhase.ENDED)
					{
						if (child.view.hasEventListener(Event.ENTER_FRAME))
							child.view.removeEventListener(Event.ENTER_FRAME, onBeStationary);
						
						/** Important: stop bubbles.*/
						e.stopPropagation();
						
						// actionButton list 나오지 않게 하기 위함.
						if (!m_isHolded)
							self.dispatchEvent(new Event("characterTouched", false, child.view));
						
						self.dispatchEvent(new Event("touchEnded"));
						
					}
					else if (touch.phase == TouchPhase.BEGAN)
					{
						m_started = 0;
						m_isHolded = false;
						m_touchPoint.x = touch.globalX;
						m_touchPoint.y = touch.globalY;
						child.view.addEventListener(Event.ENTER_FRAME, onBeStationary);
					}
					else if (touch.phase == TouchPhase.MOVED)
					{
						if (Point.distance(m_touchPoint, new Point(touch.globalX, touch.previousGlobalY)) > 10)
							child.view.removeEventListener(Event.ENTER_FRAME, onBeStationary);
						
						m_touchPoint.x = touch.globalX;
						m_touchPoint.y = touch.globalY;
						self.dispatchEvent(new Event("touchMoved", false, m_touchPoint));
					}
				}
			);
//			dispatchEvent(new Event("modelAdded"));
		}
		
		
		
		private function onBeStationary(e:Event):void
		{
			m_started += e.data;
//			trace(m_started);
			
			if (m_started > 0.75) 
			{
				e.target.removeEventListener(Event.ENTER_FRAME, onBeStationary);
				m_isHolded = true;
				trace("holded for 0.75s.");
				
				var se:Event = new Event("buttonHold", false, m_touchPoint);
				this.dispatchEvent(se);
			}
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