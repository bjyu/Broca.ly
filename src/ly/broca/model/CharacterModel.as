package ly.broca.model
{
	import flash.geom.Point;
	
	import events.ModelChangedEvent;
	
	import starling.events.EventDispatcher;

	public class CharacterModel extends EventDispatcher
	{
//		private var _userId:String;
		
		private var _characterID:String;

		public function get characterID():String
		{
			return _characterID;
		}

		public function set characterID(value:String):void
		{
			_characterID = value;
			dispatchEvent(new ModelChangedEvent({"name":"characterID", "value":value}));
		}

		
		private var _faceID:String;

		public function get faceID():String
		{
			return _faceID;
		}

		public function set faceID(value:String):void
		{
			_faceID = value;
		}

		
		private var _matrixPos:Point = new Point();

		public function get matrixPos():Point
		{
			return _matrixPos;
		}

		public function set matrixPos(value:Point):void
		{
			_matrixPos = value;
		}

		
		private var _effect:Object = {"name":"", "order":"front"};

		public function get effect():Object
		{
			return _effect;
		}

		public function set effect(value:Object):void
		{
			_effect = value;
		}

		
		public function CharacterModel()
		{
			
		}
	}
}