package core.loadEvents
{
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	/**
	 *显示对象进行二进制加载，显示 
	 * @author bin.li
	 * 
	 */	
	public class CURLLoader extends EventDispatcher
	{
		private var i:uint;	//用于记数
		private var urlArr:Array = new Array();		//存放待加载的URL
		private var _loader:URLLoader;
		public var name:String;
		public static const LOAD_COMPLETE:String = "loadcomplete";
		private var islayout:Boolean = false;//是否对加载的DISPLAYOBJECT进行布局
		
		public function CURLLoader(b:Boolean=false)
		{
			islayout = b;
		}
		public function close():void
		{
//			_loader.close();
		}
		/**
		 * 
		 * @param a	待加载的内容的URL数组
		 * 
		 */		
		public function load(a:Array):void
		{
			i = 0;
			urlArr = a;
			objArr = [];
			if(urlArr.length)
			{
				realLoad();
			}
		}
		private function realLoad():void
		{
			
			_loader = new URLLoader(new URLRequest(urlArr[i]));
			_loader.dataFormat = URLLoaderDataFormat.BINARY;
			_loader.addEventListener(ProgressEvent.PROGRESS,progressHandler);
			_loader.addEventListener(Event.COMPLETE,completeHandler);
			_loader.addEventListener(IOErrorEvent.IO_ERROR,errorHandler);
		}
		private var currentByte:ByteArray;
		private var loa:Loader;
		private var byteArr:Vector.<ByteArray> = new Vector.<ByteArray>();
		/**
		 *存放加载好的DisplayObject 
		 */		
		public var objArr:Array = new Array();
		private function completeHandler(event:Event):void
		{
			i++;
			currentByte = _loader.data as ByteArray;
			byteArr.push(currentByte);		//之后的解密就要放在这里
			
			loa = new Loader();
			loa.loadBytes(currentByte);
			loa.contentLoaderInfo.addEventListener(Event.COMPLETE,endOkHandler);
			
		}
		private function endOkHandler(event:Event):void
		{
			trace("==push in==");
			var cl:LoaderInfo = event.currentTarget as LoaderInfo;
			var bitmap:DisplayObject = cl.content as DisplayObject;
			objArr.push(bitmap);
			if(i<urlArr.length)
			{
				realLoad();
			}
			else//全部加载完成
			{
				trace("==dispatch==");
				if(islayout)
				{
					i = 0;
					for each(var o:DisplayObject in objArr)
					{
						o.x = i*o.width;
						i++;
					}
				}
				dispatchEvent(new Event(LOAD_COMPLETE));
			}
		}
		private function progressHandler(event:ProgressEvent):void
		{
			
		}
		private function errorHandler(event:IOErrorEvent):void
		{
			throw new Error("CURLLoader路径："+urlArr[i]+"有误！");
		}
	}
}