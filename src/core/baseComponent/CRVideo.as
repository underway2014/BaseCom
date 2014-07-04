package core.baseComponent
{
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.geom.Rectangle;
	import flash.media.SoundTransform;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	
	import core.loadEvents.CLoaderMany;
	
	/**
	 *加载FLV 
	 * @author bin.li
	 * 
	 */	
	public class CRVideo extends Sprite
	{
		/**
		 * FLV播放路径
		 * **/
		private var _url:String;
		
		private var video:Video;
		private var _closeButton:CButton;
		
		private var connection:NetConnection;
		private var _width:int;
		private var _height:int;
		/**
		 * 
		 * @param w
		 * @param h
		 * @param showBar	是否显示拖动条
		 * 
		 */		
		public function CRVideo(w:int = 1080,h:int = 608,showBar:Boolean = false,controlArr:Array = null)
		{
			super();
			this.graphics.beginFill(0x000000);
			this.graphics.drawRect(0,0,w,h);
			this.graphics.endFill();
			
			video = new Video(w,h);
			addChild(video);
			//			this.addEventListener(MouseEvent.CLICK,soundCloseHandler);
			//			this.addEventListener(MouseEvent.DOUBLE_CLICK,soundOpenHandler);
			
			_width = w;
			_height = h;
			
			if(showBar&&controlArr)
			{
				controlUrlArr = controlArr;
				initBar();
			}
			
		}
		private var controlUrlArr:Array;
		//------------------------------------------------------------
		private var barSprite:Sprite;
		private var sliderSprite:Sprite;
		private var barLoader:CLoaderMany;
		private var musicLoader:CLoaderMany;
		private function initBar():void
		{
			barSprite = new Sprite();
			addChild(barSprite);
			
			sliderSprite = new Sprite();
			barSprite.addChild(sliderSprite);
			sliderSprite.addEventListener(Event.ENTER_FRAME,updateSlider);
			
			sliderSprite.addEventListener(MouseEvent.MOUSE_DOWN,sliderStartHandler);
			sliderSprite.addEventListener(MouseEvent.MOUSE_UP,sliderStopHandler);
			sliderSprite.addEventListener(MouseEvent.MOUSE_OUT,outHandler);
			
			barSprite.y = _height - 100;
			
			barLoader = new CLoaderMany();
			barLoader.load([controlUrlArr[0],controlUrlArr[1]]);
			barLoader.addEventListener(CLoaderMany.LOADE_COMPLETE,barLoadOkHandler);
			
			var stopBtn:CButton = new CButton([controlUrlArr[2],controlUrlArr[3]],false,true,true);
			stopBtn.addEventListener(MouseEvent.CLICK,stopPlayHandler);
			stopBtn.y = _height - 50;
			addChild(stopBtn);
			
			//			musicLoader = new CLoaderMany();
			//			musicLoader.load(["source/picture/musicBtn.png","source/picture/musicBg.png","source/picture/musicBar.png"]);
			//			musicLoader.addEventListener(CLoaderMany.LOADE_COMPLETE,musicOkHandler);
			//			
			//			musicSprite = new Sprite();
			//			addChild(musicSprite);
			//			musicSprite.addEventListener(MouseEvent.CLICK,showMusicHandler);
			//			
			//			barBgSprite = new Sprite();
			//			addChild(barBgSprite);
			//			musicSprite.y = barBgSprite.y = _height;
			//			barBgSprite.x = 100;
			//			barBgSprite.visible = false;
			
			//			musicBarSprite = new Sprite();
			//			barBgSprite.addChild(musicBarSprite);
			//			musicBarSprite.addEventListener(MouseEvent.MOUSE_DOWN,musicDownHandler);
			//			musicBarSprite.addEventListener(MouseEvent.MOUSE_UP,musicUpHandler);
			//			musicBarSprite.addEventListener(MouseEvent.MOUSE_OUT,musicOutHandler);
			
		}
		private function stopPlayHandler(event:MouseEvent):void
		{
			videoPauseHandler(null);
		}
		private var isMusicDown:Boolean;
		private function musicDownHandler(event:MouseEvent):void
		{
			isMusicDown = true;
			musicBarSprite.startDrag(false);
		}
		private function musicUpHandler(event:MouseEvent):void
		{
			isMusicDown = false;
			musicBarSprite.stopDrag();
		}
		private function musicOutHandler(event:MouseEvent):void
		{
			if(isMouseDown)
				musicUpHandler(null);
		}
		private var musicSprite:Sprite;
		private var barBgSprite:Sprite;
		private var musicBarSprite:Sprite;
		private function musicOkHandler(event:Event):void
		{
			musicSprite.addChild(musicLoader._loaderContent[0]);
			barBgSprite.addChildAt(musicLoader._loaderContent[1],0);
			musicBarSprite.addChild(musicLoader._loaderContent[2]);
			musicBarSprite.y = musicLoader._loaderContent[1].height - musicBarSprite.height;
		}
		private function showMusicHandler(event:Event):void
		{
			if(barBgSprite.visible)
			{
				barBgSprite.visible = false;
			}
			else
			{
				barBgSprite.visible = true;
			}
		}
		
		
		private function dragChangeHandler(event:Event):void
		{
			stream.seek(sliderSprite.x/(_width - sliderSprite.width)*duration);
			trace("stream.time==n==",stream.time);
		}
		private function barLoadOkHandler(event:Event):void
		{
			barLoader._loaderContent[0].width = _width;
			barSprite.addChildAt(barLoader._loaderContent[0],0);
			sliderSprite.addChild(barLoader._loaderContent[1]);
			dragRect = new Rectangle(0,0,_width - sliderSprite.width,0)
		}
		//更新进度块的位置
		private function updateSlider(event:Event):void
		{
			if(!drag)
			{
				sliderSprite.x = int((_width-sliderSprite.width)*(stream.time/duration));
			}
			else
			{
				drag--;
			}
			
			//			trace("sliderSprite.x=",_width,"/",duration/stream.time,"=",sliderSprite.x);
		}
		
		private var dragRect:Rectangle;
		private var isMouseDown:Boolean;
		//开始拖动
		private function sliderStartHandler(event:MouseEvent):void
		{
			this.addEventListener(Event.ENTER_FRAME,dragChangeHandler);
			isMouseDown = true;
			sliderSprite.removeEventListener(Event.ENTER_FRAME,updateSlider);
			sliderSprite.startDrag(false,dragRect);
			videoPauseHandler(null);
			
		}
		private var drag:int;	//防止反弹的
		private function sliderStopHandler(event:MouseEvent):void
		{
			drag = 2;
			this.removeEventListener(Event.ENTER_FRAME,dragChangeHandler);
			isMouseDown = false;
			sliderSprite.stopDrag();
			setPositinAndPlay();
		}
		private function outHandler(event:MouseEvent):void
		{
			if(isMouseDown)
			{
				sliderStopHandler(null);
			}
		}
		private function setPositinAndPlay():void
		{
			stream.seek(sliderSprite.x/(_width - sliderSprite.width)*duration);
			//			stream.togglePause();
			videoPauseHandler(null);
			sliderSprite.addEventListener(Event.ENTER_FRAME,updateSlider);
		}
		
		//---------------------------------------------------------------------
		
		private var isPause:Boolean;	//视频当前是否暂停
		public function soundOpenHandler(event:Event):void
		{
			stream.soundTransform = new SoundTransform(1);
		}
		public function soundCloseHandler(event:Event):void
		{
			stream.soundTransform = new SoundTransform(0);
		}
		private var _volume:Number;	//音量大小
		public function videoPauseHandler(event:MouseEvent):void
		{
			if(!isPause)
			{
				stream.pause();
				sliderSprite.removeEventListener(Event.ENTER_FRAME,updateSlider);
				isPause = true;
			}
			else
			{
				stream.resume();
				sliderSprite.addEventListener(Event.ENTER_FRAME,updateSlider);
				isPause = false;
			}
		}
		private function netStatusHandler(event:NetStatusEvent):void
		{
			switch(event.info.code)
			{
				case "NetConnection.Connect.Success":
					connectStream();
					dispatchEvent(new Event(VIDEO_CONNECT_SUCCESS));
					break;
				case "NetStream.Play.StreamNotFound":
					throw new Error("Stream not found: " + _url);
					break;
				case "NetStream.Play.Stop" :
					if(_loop)
					{
						trace("重播放。。。");
						stream.play(url);
					}
					else
					{
						dispatchEvent(new Event(VIDEO_PLAY_OVER));
						trace("player over.....");
						if(!_isList)
							removeVideo(null);
					}
					break;
			}
		}
		/**
		 * 循环播放
		 */		
		private var _loop:Boolean;	//
		/**
		 * 播放内容是否有多个
		 */		
		private var _isList:Boolean; 	//
		
		public static const VIDEO_PLAY_OVER:String = "playover";
		public static const VIDEO_PLAY_PAUSE:String = "playpause";
		public static const VIDEO_PLAY_RESET:String = "replay";
		public static const VIDEO_CONNECT_SUCCESS:String = "connectsuccess";
		
		private var stream:NetStream;
		private function connectStream():void
		{
			if(stream)
			{
				stream.removeEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
				stream.close();
				stream = null;
			}
			
			var obj:Object=new Object(); 
			obj.onMetaData = onMetaData; 
			
			stream = new NetStream(connection);
			stream.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			stream.client = obj;
			video.attachNetStream(stream);
			stream.play(_url);
			stream.inBufferSeek = true;
			//			soundtransform = new SoundTransform(1);
			//			soundtransform = stream.soundTransform;
			
		}
		public function getInfo(type:int):String
		{
			switch(type)
			{
				case 0:
					//					return "加载字节数："+stream.bytesLoaded+"/"+stream.bytesTotal+"time:"+stream.time+"totaltime:"+duration;
					break;
				case 1:
					break;
				case 2:
					break;
				case 3:
					break;
				case 4:
					break;
			}
			return null;
		}
		//		private var soundtransform:SoundTransform;
		private function securityErrorHandler(event:SecurityErrorEvent):void
		{
			throw new Error(_url + "	:securityError....");
		}
		
		/**
		 *清除视频 ,且停止数据流
		 * **/
		private function removeVideo(event:MouseEvent):void
		{
			if(this.parent)
			{
				this.parent.removeChild(this);
			}
		}
		public function close():void
		{
			stream.close();
		}
		
		public function get url():String
		{
			return _url;
		}
		
		public function set url(value:String):void
		{
			_url = value;
			if(connection)
			{
				connection.removeEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
				connection.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
				connection = null;
			}
			connection = new NetConnection();
			connection.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			connection.connect(null);
			//			trace("connection is null");
		}
		private var duration:Number;
		public function onMetaData(infoObject:Object):void 
		{ 
			trace("metadata"); 
			duration=infoObject.duration;//获取总时间 
		}
		
		public function get loop():Boolean
		{
			return _loop;
		}
		
		/**
		 *是否循环播放  
		 */			
		public function set loop(value:Boolean):void
		{
			_loop = value;
		}
		
		public function get isList():Boolean
		{
			return _isList;
		}
		
		public function set isList(value:Boolean):void
		{
			_isList = value;
		}
		
		public function get volume():Number
		{
			//			trace("===音量大小===",stream.soundTransform.volume);
			if(stream)
			{
				_volume = stream.soundTransform.volume;
				return _volume;
			}
			return -1;
		}
		
		public function set volume(value:Number):void
		{
			_volume = value;
		}

		public function get closeButton():CButton
		{
			return _closeButton;
		}

		public function set closeButton(value:CButton):void
		{
			_closeButton = value;
			_closeButton.x = 1080 - 55;
			_closeButton.y = 7;
			_closeButton.addEventListener(MouseEvent.CLICK,removeVideo);
			addChild(_closeButton);
		}
		
		
	}
}

