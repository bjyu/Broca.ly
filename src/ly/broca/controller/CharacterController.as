/**
 * life cycle
 * 1. create models from data
 * 2. create controller with model
 * 2.1 create view by controller
 * 
 * */

package ly.broca.controller
{
	import flash.geom.Point;
	
	import elements.Character;
	
	import events.ModelChangedEvent;
	
	import ly.broca.model.CharacterModel;
	
	import utils.Isomatric;

	public class CharacterController
	{
		public var model:CharacterModel;
		public var view:Character;
		
		// IsoMatrix 한 칸의 너비
		private var sideUnit:Number = 200;
		
		// model을 받는다.
		
		public function CharacterController(m:CharacterModel)
		{
			model = m;
			
			view = new Character();
			
			sideUnit = Math.min(Main.STAGE_WIDTH, Main.STAGE_HEIGHT) / 3 / 2;
			
			
			// To Do # rootView에 추가
			// rootController.view.add ?
			// rootView.add ?
			
			initialize();
			
			model.addEventListener(ModelChangedEvent.MODEL_CHANGED, modelChanged);
		}
		
		private function modelChanged(e:ModelChangedEvent):void
		{
			if (view.hasOwnProperty(e.data.name))
				view[e.data.name] = e.data.value;
			else
				throw new Error(view.name + " has not " + e.data.name + " property.");
		
			trace("set new value - " + e.data.name + ":" + e.data.value);
		}
		
		public function initialize():void
		{
			view.faceId = model.faceID;
			view.characterID = model.characterID;
			view.matrixPos = model.matrixPos;

//			model.effect
			
			relocate(model.matrixPos);
		}
		
		/**
		 * 배치 매트릭스 배열로 캐릭터를 배치시킨다.
		 */ 
		private function relocate(point:Point):void
		{
			var p:Point = Isomatric.convert2dToIsometric(point, sideUnit);
			view.x = p.x;
			view.y = p.y;
			
			trace(point.toString() + " -> " + p.toString());
		}
	}
}