package core.encrypt
{
	import com.hurlant.crypto.symmetric.DESKey;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.AsyncErrorEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.NetStatusEvent;
	import flash.events.ProgressEvent;
	import flash.media.Video;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.net.NetStreamAppendBytesAction;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLStream;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.ByteArray;
	
	public class Encrypt extends Sprite
	{
		private static var KEY_YH:int = 32;
		private static var KEY_DES:String = "1234561111111111";
		private var sourceType:int = 0;  //0: 图片  1：视频
		private var encrypt:Boolean = true;
		private var display:Sprite = new Sprite();
		
		private var loaderContext:LoaderContext  = new LoaderContext();
		private var loader:Loader = new Loader();

		
		private var connection:NetConnection;
		private var stream:NetStream;
		private var video:Video = new Video(1080,608);

		public function Encrypt()
		{
			var btnCtrlEncrypt:Sprite = new Sprite();
			btnCtrlEncrypt.graphics.beginFill(0xFF0000);
			btnCtrlEncrypt.graphics.drawRect(0,0,50,50);
			btnCtrlEncrypt.graphics.endFill();
			this.addChild(btnCtrlEncrypt);
			btnCtrlEncrypt.x = 0;
			btnCtrlEncrypt.y = 50;
			btnCtrlEncrypt.visible = true;
			btnCtrlEncrypt.alpha = 1.0;
			btnCtrlEncrypt.buttonMode = true;
			btnCtrlEncrypt.addEventListener(MouseEvent.CLICK,btnEncryptClick);
			
			var btnCtrlSave:Sprite = new Sprite();
			btnCtrlSave.graphics.beginFill(0x00FF00);
			btnCtrlSave.graphics.drawRect(0,0,50,50);
			btnCtrlSave.graphics.endFill();
			this.addChild(btnCtrlSave);
			btnCtrlSave.x = 0;
			btnCtrlSave.y = 150;
			btnCtrlSave.visible = true;
			btnCtrlSave.alpha = 1.0;
			btnCtrlSave.buttonMode = true;
			btnCtrlSave.addEventListener(MouseEvent.CLICK,btnSaveClick);
			
			var btnCtrlDencrypt:Sprite = new Sprite();
			btnCtrlDencrypt.graphics.beginFill(0x0000FF);
			btnCtrlDencrypt.graphics.drawRect(0,0,50,50);
			btnCtrlDencrypt.graphics.endFill();
			this.addChild(btnCtrlDencrypt);
			btnCtrlDencrypt.x = 0;
			btnCtrlDencrypt.y = 250;
			btnCtrlDencrypt.visible = true;
			btnCtrlDencrypt.alpha = 1.0;
			btnCtrlDencrypt.buttonMode = true;
			btnCtrlDencrypt.addEventListener(MouseEvent.CLICK,btnDencryptClick);
			
			display.x = 100;
			this.addChild(display);
			
			//初始化视频播放
			connection = new NetConnection();
			connection.connect(null);
			stream = new NetStream(connection);
			
			var clientobj:Object =new Object();
			clientobj.onMetaData=function():void{ };
			stream.client=clientobj;
			
			stream.addEventListener(NetStatusEvent.NET_STATUS,netStatusHandler);   
			stream.addEventListener(AsyncErrorEvent.ASYNC_ERROR,netAsyncErrorHandler);		
			
			video.addEventListener(Event.REMOVED_FROM_STAGE,removeVideoHandler);
			video.smoothing = true;

		}
		
		private function removeVideoHandler(e:Event):void
		{
			stream.close();
		}
		
		private var fileEncrypt:FileReference = new FileReference();
		private function btnEncryptClick(e:Event):void
		{
			var imageTypes:FileFilter = new FileFilter("图片文件 (*.png)", "*.png");
			var videoTypes:FileFilter = new FileFilter("视频文件 (*.flv)", "*.flv");
			var allTypes:Array = new Array(imageTypes, videoTypes);
			fileEncrypt.browse(allTypes);
			fileEncrypt.addEventListener(Event.SELECT, onSelecteEncrypt);
			
			encrypt = true;
		}
		
		private function onSelecteEncrypt(event:Event):void
		{
			var arr:Array = fileEncrypt.name.split(".");
			if (arr[1] == "png")
				sourceType = 0;
			else if (arr[1] == "flv")
				sourceType = 1;
			
			loadFileBinary("C://Documents and Settings//yn.gao//桌面//"+fileEncrypt.name);	
		}

		private var fileSave:FileReference = new FileReference();
		private var saveData:ByteArray = new ByteArray();
		private function btnSaveClick(e:Event):void
		{
			fileSave.save(dstData, "");
			fileSave.addEventListener(Event.COMPLETE, saveComplete);
		}
		
		private function saveComplete(e:Event):void
		{
			trace("Save Done！");
		}
		
		private var fileDencrypt:FileReference = new FileReference();
		private function btnDencryptClick(e:Event):void
		{
			var imageTypes:FileFilter = new FileFilter("图片文件 (*.png)", "*.png");
			var videoTypes:FileFilter = new FileFilter("视频文件 (*.flv)", "*.flv");
			var allTypes:Array = new Array(videoTypes, imageTypes);
			fileDencrypt.browse(allTypes);
			fileDencrypt.addEventListener(Event.SELECT, onSelecteDencrypt);
			
			encrypt = false;
		}
		
		private function onSelecteDencrypt(event:Event):void
		{
			var arr:Array = fileDencrypt.name.split(".");
			if (arr[1] == "png")
				sourceType = 0;
			else if (arr[1] == "flv")
				sourceType = 1;
			
			loadFileBinary("C://Documents and Settings//yn.gao//桌面//"+fileDencrypt.name);
		}
		
		private var urlloader:URLLoader
		private var urlStream:URLStream;
		private var date:Date;
		
		private var my_text:TextField=new TextField();
		private var my_For:TextFormat=new TextFormat();


		public function loadFileBinary(fileName:String):void
		{
			my_For.font="_sans";
			my_For.color=0x333333;
			my_text.x=0;
			my_text.y=350;
			my_text.width=100;
			my_text.height=20;
			my_text.borderColor = 0xcccccc;
			my_text.border=true;
			my_text.text="欢迎光临";
			addChild(my_text);
			
//			if(display.numChildren != 0)
//				display.removeChildAt(0);
			
//			if (!encrypt)
//			{
//				if (sourceType == 0)	
//				{
					display.addChild(loader);
//				}
//				else if (sourceType == 1)
//				{
//					stream.close();
//					stream.play(null);
//					video.attachNetStream(stream);
//					
//					display.addChild(video);				
//				}
//			}
			
			saveData.clear();

			date = new Date();
			
			trace(fileName);
			//"http://files.cnblogs.com/Greatest/test.jpg.zip"
			//"http://images.missyuan.com/attachments/day_090906/20090906_a5a134d301d4c6d5800cbYH2Z9HxsRvy.png"
			//source//yunnan//kunming_begin.swf
			//source//音乐//春江花月夜 群星.mp3
			var urlrequest:URLRequest=new URLRequest("http://y1.eoews.com/assets/ringtones/2012/5/17/34031/axiddhql6nhaegcofs4hgsjrllrcbrf175oyjuv0.mp3");

			
			urlStream = new URLStream();
			urlStream.addEventListener(ProgressEvent.PROGRESS, processData);
			//urlStream.addEventListener(Event.COMPLETE, processData);
			
			try {
				trace("加载中...");
				urlStream.load(urlrequest);
				//loader.load(urlrequest);
			} catch (err:Error) {
				trace(err);
			}
		}
		
		private var dstData:ByteArray = new ByteArray();
		private var oldlen:int = 0;
		private function processData(evt:ProgressEvent):void 
		{
			//trace(evt.bytesLoaded);
			oldlen = dstData.length;
            urlStream.readBytes(dstData, oldlen);

			//oldlen += dstData.length;
			trace(dstData.length);
            // if (dstData.length > oldlen)
			// {
                // loader.loadBytes(dstData);
            // }

			var percentLoaded:Number = evt.bytesLoaded/evt.bytesTotal;
			percentLoaded = Math.round(percentLoaded * 100);
			my_text.text = "Loading: "+percentLoaded+"%";
			my_text.setTextFormat(my_For);
			trace(my_text.text);

			DESDecrypt(dstData, KEY_DES);
			//stream.appendBytes(dstData);
//			processAndDisplay();
//			
//			dstData.clear();
		}

		
		/**
		 
		 *加密/解密媒体文件并显示
		 
		 **/

		private function processAndDisplay():void
		{
//			if (dstData.length == 0)
//				return;
			
			//DES
			if (encrypt)
			{
				DESEncrypt(dstData, KEY_DES);
				//saveData.writeBytes(dstData, oldlen, dstData.length);
				
				trace("Encrypt Done！");
				var dateCur:Date = new Date();
				trace("time:", dateCur.millisecondsUTC - date.millisecondsUTC);
			}
			else
			{
				
				
				saveData.writeBytes(dstData, oldlen, dstData.length);

				//loader.loadBytes(saveData);
				
				DESDecrypt(dstData, KEY_DES);
				
				trace("Dencrypt Done！");
				var dateCur1:Date = new Date();
				trace("time:", dateCur1.millisecondsUTC - date.millisecondsUTC);
				
//				if (sourceType == 0)
//				{			
//					loader.loadBytes(dstData);
//				}
//				else if (sourceType == 1)
//				{
					//stream.appendBytes(dstData);
//					
//					//stream.seek(0);
//					//stream.appendBytesAction(NetStreamAppendBytesAction.RESET_SEEK);
//					
//				}
			}
		}
		
		private function netStatusHandler(event:NetStatusEvent):void  
		{   
			switch (event.info.code)   
			{   
				case "NetConnection.Connect.Success" :   
					break;   
				case "NetStream.Play.StreamNotFound" :   
					throw new Error("错误");   
					break;   
				
				case "NetStream.Play.Stop" :
					display.removeChild(video);
					break;   
				
			}   
		}   
		
		private function netAsyncErrorHandler(event:AsyncErrorEvent):void  
		{   

		}
		
		
		/**
		 
		 *加密
		 
		 **/

		public static function DESEncrypt(src:ByteArray,k:String):ByteArray
		{
			var key:ByteArray = new ByteArray();
			key.writeUTFBytes(k);
			
			var des:DESKey = new DESKey(key);
			des.encrypt(src);
	
			return src;
		}
		
		/**
		 
		 * 解密
		 
		 **/
		
		
		public static function DESDecrypt(src:ByteArray,k:String):ByteArray
		{
			var key:ByteArray = new ByteArray();
			key.writeUTFBytes(k);
			
			var des:DESKey = new DESKey(key);
			des.decrypt(src);
			
			return src;
		}
		


	}
}