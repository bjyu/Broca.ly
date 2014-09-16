/**
 *	캐릭터 액팅 선정을 취소 할 때 사용하는 취소버튼을 관리한다. 
 */

package managers
{
	import flash.geom.Point;
	
	import elements.ActionCancelButton;
	
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.EventDispatcher;
	
	
	public class CancelButtonManager extends EventDispatcher
	{
		private var m_faceCancelButton:ActionCancelButton;
		private var m_actionCancelButton:ActionCancelButton;
		private var m_buttonArr:Array;
		
		// follow touch point.
		private var m_controlButton:Button;
		private var m_controlButtonContainer:Sprite;
		
		
		// Action Buttons의 메뉴 레이어와 다른 오브젝트를 사용하는 편이 좋겠다.
		private var m_menuLayer:Sprite;
		
		// center of controlButton
		private var m_cp:Point;
		
		// radius of controlButton
		private var m_r:Number;
		
		// distance between touch point and cancel button' point.
		private var m_dist:Number = 200;
		
		private var m_isHolded:Boolean = false;
		
		//
		// constructor
		//
		public function CancelButtonManager(layer:Sprite)
		{
			m_cp = new Point();
			m_menuLayer = layer;
			
			// 1. compose button components (control button, two cancel buttons)
			m_faceCancelButton = new ActionCancelButton(Assets.getAtlas("LayoutAtlas").getTexture("faceButton"), "Cancel Face");
			m_actionCancelButton = new ActionCancelButton(Assets.getAtlas("LayoutAtlas").getTexture("pageCurrent"), "Cancel Action");
			
			m_buttonArr = new Array(m_faceCancelButton, m_actionCancelButton);
			
			m_controlButtonContainer = new Sprite();
			
			m_controlButton = new Button(Assets.getAtlas("LayoutAtlas").getTexture("pageDefault"));
			
			m_controlButtonContainer.addChild(m_controlButton);
			
			m_menuLayer.addChild(m_controlButtonContainer);
			m_menuLayer.addChild(m_faceCancelButton);
			m_menuLayer.addChild(m_actionCancelButton);
			
			m_menuLayer.visible = false;
			
			trace(m_controlButtonContainer.bounds.toString());
			m_controlButtonContainer.pivotX = m_controlButtonContainer.width/2;
			m_controlButtonContainer.pivotY = m_controlButtonContainer.height/2;
			
			
			// 3. display hint UI by checking collision.
//			m_controlButton.transformationMatrix.rotate();
//			m_controlButton.transformationMatrix.scale();
//			m_controlButton.skewX = 0;
		}
		
		public function onTouchMoved(e:Event):void
		{
			var tp:Point = Point(Point(e.data));
			var gap:Number = Point.distance(m_cp, tp);
			
			m_controlButtonContainer.rotation = Math.atan2(tp.y - m_cp.y, tp.x - m_cp.x) - Math.PI / 2;
			
			if (!m_isHolded) return;
			
			if (gap > m_r)
			{
				m_controlButton.height = gap;
			}
			
			// 가장 가까운 것으로 활성화 한다.
			stepBackButton(tp);
		}
		
		public function onTouchEnded(e:Event):void
		{
			m_isHolded = false;
			m_menuLayer.visible = false;	
			
			initialize();
		}
		
		// start control
		public function start(globalPoint:Point):void
		{
			// show buttons
			m_menuLayer.visible = true;
			
			// init for restart
			m_controlButton.height = m_controlButton.width;
			
			// start tracking (move event)
			m_r = m_controlButtonContainer.width / 2;
			
				
			m_cp.x = m_controlButtonContainer.x = globalPoint.x;
			m_cp.y = m_controlButtonContainer.y = globalPoint.y;
			
			m_isHolded = true;
			
			initialize();
		}
		
		private function getCircularPoint(r:Number, angle:Number):Point
		{
			return new Point(m_cp.x + r * Math.cos(angle), m_cp.y + r * Math.sin(angle));
		}
		
		public function initialize():void
		{
			// following object
			// x,y = touchXY
			
			
			/* Being Pushed object (cancel buttons) */
					
			var buttonsNum:int = m_buttonArr.length;
			
			// min angle
			var angleUnit:Number = Math.PI / 8;
			
			var startAngle:Number = -(angleUnit * buttonsNum / 2) 
				/*12o' standard*/ - Math.PI / 2;
			
			for each (var o:ActionCancelButton in m_buttonArr)
			{
				var initP:Point = getCircularPoint(m_dist, startAngle);
				o.initPoint.x = initP.x;
				o.initPoint.y = initP.y;
				o.angleToBasis = startAngle;
				o.initialize();
				
				startAngle += angleUnit;
			}
		}
		
		private function stepBackButton(globalPoint:Point):void
		{
			var button:ActionCancelButton;
			
			var minDist:Number = Number.MAX_VALUE;
			for each (var b:ActionCancelButton in m_buttonArr)
			{
				var dist:Number = Point.distance(b.initPoint, globalPoint);
				if (dist < minDist)
				{
					minDist = dist;
					button = b;
				}
				
				// gap
				var gap:Number = m_dist - dist;
				
				// boundary
				if (gap > 0)
				{
					var p:Number = b.width * Math.SQRT2 * gap / m_dist;
					b.x = b.initPoint.x + p * Math.cos(b.angleToBasis);
					b.y = b.initPoint.y + p * Math.sin(b.angleToBasis);
				}
				else
				{
					b.activated = false;
					if (b == button) button = null;
				}
			}
			
			for each (b in m_buttonArr)
			{
				b.activated = (b == button);
			}
			
		}
		
	}
}