package core.baseComponent
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	
	public class MusicPlayer extends EventDispatcher
	{
		private var sound:Sound;
		private var song:SoundChannel;
		private var autoPlay:Boolean;
		private var isLoop:Boolean;
		/**
		 * 
		 * @param _url
		 * @param _autoPlay		是否自动播放
		 * @param isLoop		是否循环	
		 * 
		 */		
		public function MusicPlayer(_url:String,_autoPlay:Boolean = true,_isLoop:Boolean = true)
		{
			super();
			autoPlay = _autoPlay;
			isLoop = _isLoop;
			sound = new Sound(new URLRequest(_url));
			sound.addEventListener(Event.COMPLETE,loadOkHandler);
			sound.addEventListener(IOErrorEvent.IO_ERROR,errorHandler);
		}
		private function loadOkHandler(event:Event):void
		{
			if(autoPlay)
			{
				play();
			}
		}
		private function errorHandler(event:IOErrorEvent):void
		{
			throw new Error("加载音乐出错！请查路径！");
		}
		/**
		 *播放头的位置 
		 */		
		private var _currentPosition:int;
		public static const BEGIN_PLAYING:String = "beginplaying";
		public static const RE_PLAYING:String = "replaying";
		public static const PLAY_OVER:String = "playover";
		public static const STOP_PLAYING:String = "stopplaying";
		
		/**
		 * 开始播放或从暂停处开始播放 
		 * @param beginTime		可设置开始播放位置，毫秒
		 * 
		 */		
		public function play(beginTime:int = 0):void
		{
			if(beginTime)
			{
				_currentPosition = beginTime;
			}
			song = sound.play(_currentPosition);
			dispatchEvent(new Event(BEGIN_PLAYING));
			song.addEventListener(Event.SOUND_COMPLETE,playOverHandler);
		}
		/**
		 *从头播放 
		 * 
		 */		
		public function replay():void
		{
			_currentPosition = 0
			dispatchEvent(new Event(RE_PLAYING));
			song.stop();
			song = null;
			play();
		}
		/**
		 *暂停 
		 * 
		 */		
		public function pause():void
		{
			_currentPosition = song.position;
			dispatchEvent(new Event(STOP_PLAYING));
			song.stop();
		}
		private function playOverHandler(event:Event):void
		{
			if(isLoop)
			{
				_currentPosition = 0;
				song = null;
				play();
			}
			else
			{
				dispatchEvent(new Event(PLAY_OVER));
			}
		}
		/**
		 *清除并发送PLAY_OVER消息 
		 * 
		 */		
		public function clear():void
		{
			if(song)
			{
				song.stop();
				song = null;
				dispatchEvent(new Event(PLAY_OVER));
			}
		}

		public function get currentPosition():int
		{
			return _currentPosition;
		}

		public function set currentPosition(value:int):void
		{
			_currentPosition = value;
		}
	}
}