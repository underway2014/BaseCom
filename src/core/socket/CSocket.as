package core.socket
{
	import core.loadEvents.Cevent;
	
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.Socket;
	
	public class CSocket extends EventDispatcher
	{
		private var socket:Socket;
		public function CSocket(host:String = "127.0.0.1",port:int = 9999)
		{
			super();
			socket = new Socket();
			socket.addEventListener(IOErrorEvent.IO_ERROR,errorFun);
			socket.addEventListener(Event.CONNECT,connectFun);
			socket.addEventListener(ProgressEvent.SOCKET_DATA,socketDataFun);
		}
		private var msg:String;
		public function send(str:String):void
		{
			msg = str;
			if(!socket.connected)
			{
				try
				{
					socket.connect("127.0.0.1",9999);
				}
				catch(e:IOError)
				{
					
				}
			}
			else
			{
				try
				{
					connectFun(null);
				}
				catch(e:IOError)
				{
					
				}
				
			}
		}
		/**
		 *服务器返回数据 
		 */		
		private var _returnData:*;
		private var isSuccess:Boolean;
		private function socketDataFun(event:ProgressEvent):void
		{
			if(socket.bytesAvailable)
			{
				isSuccess = true;
				_returnData = socket.readUTF();
				dispatchEvent(new Event(Cevent.SOCKET_SUCCESS));
			}
		}
		private function errorFun(event:IOErrorEvent):void
		{
//			throw new Error("connect error...");
			trace("connect error.in csocket.");
			socket.close();
			isSuccess = false;
			dispatchEvent(new Event(Cevent.SOCKET_ERROR));
		}
		private function connectFun(event:Event):void
		{
			socket.writeUTF(msg);
			try{
				
				socket.flush();
			}
			catch(e:IOError)
			{
				
			}
				
			
		}

		public function clear():void
		{
			clearEvent();
			if(socket.connected)
			socket.close();
			socket = null;
			_returnData = null;
			trace("inner clear success..");
			
		}
		//清理事件侦听
		private function clearEvent():void{
			if(socket != null){
				if(socket.hasEventListener(IOErrorEvent.IO_ERROR)) socket.removeEventListener(IOErrorEvent.IO_ERROR,errorFun);
				if(socket.hasEventListener(Event.CONNECT)) socket.removeEventListener(Event.CONNECT,connectFun);
				if(socket.hasEventListener(ProgressEvent.SOCKET_DATA)) socket.removeEventListener(ProgressEvent.SOCKET_DATA,socketDataFun);
//				if(socket.hasEventListener(Event.CLOSE)) socket.removeEventListener(Event.CLOSE,closeFun);
			}
		}
		public function get returnData():*
		{
			return _returnData;
		}

	}
}