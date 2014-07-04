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
	 * 用于同时加载多SWF,多个图片
	 * @author Administrator
	 * 
	 */	
	public class CLoaderMany extends EventDispatcher
	{
		private var _loaderList:Vector.<Loader> = new Vector.<Loader>();;
		public var _loaderContent:Vector.<Loader> = new Vector.<Loader>();
		private var _percent:int;
		
		public static var _loadInfo:LoaderInfo;
		
		public static const LOADE_PROGRESS:String="progress";
		public static const LOADE_COMPLETE:String="complete";
		public function CLoaderMany()
		{
			super();
		}
		private var i:int;
		private var loaderContext:LoaderContext;
		private var len:int;
		private var _arg:Array;
		/**
		 * 
		 * @param arg  待加载图片URL地址
		 * 
		 */		
		public function load(arg:Array):void
		{
			i=0;
			_arg = arg;
			_loaderContent.length=0;
			len = arg.length;
			loaderContext = new LoaderContext();
			loaderContext.applicationDomain = ApplicationDomain.currentDomain;
			for each(var url:String in arg)
			{
				_loaderList[i]=new Loader();
				_loaderList[i].contentLoaderInfo.addEventListener(Event.COMPLETE,completeHandler);
				_loaderList[i].contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,progressHandler);
				_loaderList[i].contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,errorHandler);
				_loaderList[i].load(new URLRequest(url),loaderContext);
				i++;
			}
		}
		private var j:int = 0;
		private var ts:int;
		public function clear():void
		{
			for each(var l:Loader in _loaderList)
			{
				(l.contentLoaderInfo.content as Bitmap).bitmapData.dispose();
			}
		}
		private function completeHandler(event:Event):void
		{
			
			ts++;
			if(_loadedByte/_totalByte!=1||ts!=len)
			{
				return;
			}
			for each(var l:Loader in _loaderList)
			{
				_loaderContent.push(l);
			}
//			trace("CLoader.LOADE_COMPLETE=++====",ts);
			dispatchEvent(new Event(CLoader.LOADE_COMPLETE));
		}
		
		/**
		 * 返回一个MVOIECLIP
		 * **/
		public static function getMovieclip(str:String):MovieClip
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
		private var _loadedByte:int;
		private var _totalByte:int;
		private function progressHandler(event:ProgressEvent):void
		{
			i=0;
			_loadedByte = _totalByte = 0;
			for each(var loaderT:Loader in _loaderList)
			{
				i++;
				_loadedByte+=loaderT.contentLoaderInfo.bytesLoaded;
				_totalByte+=loaderT.contentLoaderInfo.bytesTotal;
			}
			_percent=Math.round(_loadedByte/_totalByte*100);
//			trace("===progres percent have===",_percent,_loadedByte,_totalByte);
			dispatchEvent(new Event(CLoader.LOADE_PROGRESS));
		}
		private function errorHandler(event:IOErrorEvent):void
		{
			throw new Error("cloaderMany load wrong.(路径出错)."+_arg[i-1]);
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