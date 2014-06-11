package events
{
	import starling.events.Event;
	
	public class CharacterEvent extends Event
	{
		public static const ACTING:String = "acting";
		
		public function CharacterEvent(type:String, bubbles:Boolean=false, data:Object=null)
		{
			super(type, bubbles, data);
		}
	}
}