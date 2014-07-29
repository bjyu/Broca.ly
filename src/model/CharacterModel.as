package model
{
	import starling.events.EventDispatcher;

	public class CharacterModel extends EventDispatcher
	{
		private var _userId:String;
		
		private var _characterId:String;

		private var _faces:Array;
		
		public function CharacterModel()
		{
		}
	}
}