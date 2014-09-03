/**
 * fired when model variable is changed.
 * data scheme is like
 * - {"name":name,"value":val}
 */  
package events
{
	import starling.events.Event;
	
	public class ModelChangedEvent extends Event
	{
		static public var MODEL_CHANGED:String = "modelChanged";
		
		public function ModelChangedEvent(data:Object=null)
		{
			super(MODEL_CHANGED, false, data);
		}
	}
}