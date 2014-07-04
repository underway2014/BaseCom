package core.loadEvents
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.system.Security;
	import flash.system.SecurityDomain;
	/**
	 *加载单个SWF 
	 * @author bin.li
	 * 
	 */
	public class CLoader extends EventDispatcher
	{
		public var _loader:Loader;//加载后的SWF本身
		private var _percent:int;
		
		public static var _loadInfo:LoaderInfo;
		
		public static const LOADE_PROGRESS:String="progress";
		public static const LOADE_COMPLETE:String="complete";
		public function CLoader()
		{
			super();
			_loader=new Loader();
			
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE,completeHandler);
			_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,progressHandler);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,errorHandler);
			
//			_loader.addEventListener(Event.REMOVED_FROM_STAGE,clearSelfHandler);
		}
		private function clearSelfHandler(event:Event):void
		{
			_loader = null;
			trace("self has been removed..");
		}
		private var loaderContext:LoaderContext;
		public function load(url:String ):void
		{
			loaderContext = new LoaderContext();
			loaderContext.applicationDomain = ApplicationDomain.currentDomain;
			_loader.load(new URLRequest(url),loaderContext);
		}
		private function completeHandler(event:Event):void
		{
	
			_loadInfo=event.target as LoaderInfo;
			dispatchEvent(new Event(CLoader.LOADE_COMPLETE));
		}
		/**
		 * 返回一个MVOIECLIP
		 * **/
		public function getMovieclip(str:String):MovieClip
		{
			try
			{
//			　　var c:Class = _loadInfo.applicationDomain.getDefinition(str) as Class;
			　　var c:Class = ApplicationDomain.currentDomain.getDefinition(str) as Class;
				var m:MovieClip = new c();
				return m;
				
		　　}
			catch(error:Error)
			{
				throw new Error("元件："+str+"查无！");
			　　return null; 
			}
			return null;
		}
		/**
		 * 返回一个BITMAP
		 * **/
		public static function getBitmap(str:String):Bitmap
		{
			try
			{
//			　　var c:* = _loadInfo.applicationDomain.getDefinition(str);
			　　var c:* = ApplicationDomain.currentDomain.getDefinition(str);
				var m:* = new c();
				return new Bitmap(m);
			}
			catch(error:Error)
			{
				throw new Error("位图："+str+"查无！");
			　　return null; 
			}
		　　return null; 
		}
		private function progressHandler(event:ProgressEvent):void
		{
			_percent=Math.round(event.bytesLoaded/event.bytesTotal*100);
			dispatchEvent(new Event(CLoader.LOADE_PROGRESS));
		}
		private function errorHandler(event:IOErrorEvent):void
		{
			throw new Error("load wrong..");
		}

		public function get percent():int
		{
			return _percent;
		}

		public function set percent(value:int):void
		{
			_percent = value;
		}

	}
}