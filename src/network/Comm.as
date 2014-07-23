/**
 * 네트워크 통신을 담당한다.
 */

package network
{
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.XMLSocket;
	
	import starling.events.Event;
	import starling.events.EventDispatcher;

	public class Comm extends EventDispatcher
	{
		private var m_socket:XMLSocket;
		private var ipAddress:String = "192.168.0.100";
		
		public function Comm()
		{
			initialize();
//			ipAddress = "192.168.1.10";
		}
		
		private function initialize():void
		{
			m_socket = new XMLSocket(ipAddress, 8888);
			
			m_socket.addEventListener(flash.events.Event.CONNECT, onConnect);                   
			m_socket.addEventListener(IOErrorEvent.IO_ERROR, onError);
		}
		
		public function send(data:Object):void
		{
			try 
			{
				m_socket.send(data);
			} 
			catch(e:Error) 
			{
				trace(e.message);
				// reconnect.
				m_socket.connect(ipAddress, 8888);
			}
			
		}
		
		protected function onError(event:IOErrorEvent):void
		{
			trace(event.toString());
			
		}
		
		protected function onConnect(event:flash.events.Event):void
		{
			this.dispatchEvent(new starling.events.Event("connect"));
			
			m_socket.addEventListener(DataEvent.DATA, onDataReceived);
			m_socket.addEventListener(flash.events.Event.CLOSE, onClose);
		}
		
		protected function onClose(event:flash.events.Event):void
		{
			// TODO Auto-generated method stub
			
		}
		
		protected function onDataReceived(event:DataEvent):void
		{
			trace("received: " + event.data);
			this.dispatchEvent(new starling.events.Event("data", false, event.data));
			
		}
	}
}