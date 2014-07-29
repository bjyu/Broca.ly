package events
{
	import starling.events.Event;
	
	public class SelectEvent extends Event
	{
		public static const SELECTED:String = "selected"; 
		
		public function SelectEvent(data:Object)
		{
			super(SELECTED, false, data);
		}
	}
}