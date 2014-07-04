package core.admin
{
	import core.date.CDate;
	import core.loadEvents.Cevent;
	import core.socket.CSocket;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	
	public class Administrator extends EventDispatcher
	{
		/**
		 * 全局单例
		 * @param p
		 * 
		 */		
		public function Administrator(p:privateClass)
		{
			super();
		}
		/**
		 *唯一对象 
		 */	
		private static var _instance:Administrator;
		
		public static function get instance():Administrator
		{
			if(!_instance)
			{
				_instance = new Administrator(new privateClass());
			}
			return _instance;
		}
		private static var socket:CSocket;
		public static function sendData(dataInfo:String):void
		{
			if(!socket)
			{
				socket = new CSocket();
				socket.addEventListener(Cevent.SOCKET_SUCCESS,socketDataHandler);
				socket.addEventListener(Cevent.SOCKET_ERROR,socketErrorHandler);
			}
			
			socket.send(dataInfo + "    " + CDate.getTime() );
				
		}
		private static function socketDataHandler(event:Event):void
		{
			
		}
		private static function socketErrorHandler(event:Event):void
		{
			
		}
	}
}
class privateClass{}