package core.loadEvents
{
	import flash.events.Event;
	
	public class DataEvent extends Event
	{
		public static const CLICK:String = "selfclick";

		private var _data:*;
		
		/**
		 *自定义事件，可携带数据 
		 * @param type
		 * @param bubbles
		 * @param cancelable
		 * 
		 */		
		public function DataEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		override public function toString():String
		{ 
			return formatToString("DataEvent", "type", "bubbles", "cancelable", 
				"eventPhase", "data"); 
		}

		public function get data():*
		{
			return _data;
		}

		public function set data(value:*):void
		{
			_data = value;
		}

	}
}