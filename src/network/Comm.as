/**
 * 네트워크 통신을 담당한다.
 */

package network
{
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.XMLSocket;
	import flash.system.Security;
	
	import starling.events.Event;
	import starling.events.EventDispatcher;

	public class Comm extends EventDispatcher
	{
		private var m_userId:String = "0";
		private var m_socket:XMLSocket;
		private var ipAddress:String;
		private var m_port:uint = 8080;
		
		public static var room:String = "lobby";
		
		public function Comm()
		{
			ipAddress = "localhost";
			
			initialize();
		}
		
		private function initialize():void
		{
//			Security.loadPolicyFile("xmlsocket://localhost:8080");
			m_socket = new XMLSocket(ipAddress, m_port);
			
			m_socket.addEventListener(flash.events.Event.CONNECT, onConnect);
			m_socket.addEventListener(IOErrorEvent.IO_ERROR, onError);
			m_socket.addEventListener(ProgressEvent.SOCKET_DATA, 
				function(event:ProgressEvent):void{
					trace(event.bytesLoaded);
					if (event.bytesLoaded == event.bytesTotal) trace("sended.");
				} 
			);
			
		}
		
		public function send(data:Object):void
		{
			try 
			{
				// To Do # this code must be removed.
				if (data.hasOwnProperty("userId"))
					m_userId = data.userId;
				else
					data["userId"] = m_userId;
				
				m_socket.send(JSON.stringify(data));
				trace("sending data: " + JSON.stringify(data));
			} 
			catch(e:Error) 
			{
				trace(e.message);
				// reconnect.
				m_socket.connect(ipAddress, m_port);
			}
			
		}
		
		protected function onError(event:IOErrorEvent):void
		{
			trace(event.toString());
		}
		
		protected function onConnect(event:flash.events.Event):void
		{
			this.dispatchEvent(new starling.events.Event("connect"));
			
			var obj:Object = {"room":room, "type":"join"}; // or message
			m_socket.send(JSON.stringify(obj));
			
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