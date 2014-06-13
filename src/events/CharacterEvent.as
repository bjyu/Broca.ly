/**
 * Character의 Act함수가 실행될 때 발생하는 이벤트.
 */
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