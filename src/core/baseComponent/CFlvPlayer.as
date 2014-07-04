package core.baseComponent
{
	import core.admin.Administrator;
	import core.loadEvents.CLoaderMany;
	import core.loadEvents.Cevent;
	
	import fl.video.FLVPlayback;
	import fl.video.VideoScaleMode;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.SoundTransform;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;

	
	/**
	 *本地FLV视频播放器
	 * @author yn.gao
	 * 
	 */	
	public class CFlvPlayer extends Sprite
	{
		public static const FLV_PLAY_OVER:String = "flvPlayOver";
		
		private var playBtnPos:Point = new Point(500, 500);
		private var stopBtnPos:Point = new Point(600, 500);
		private var playBarPos:Point = new Point(150, 450);
		private var playCtrlUrls:Array;

		private var _url:String; //FLV播放路径
		
		private var player:FLVPlayback;
		
		private var _isLoop:Boolean = false;

		public function CFlvPlayer(width:int=1080, height:int=608, playCtrls:Array = null)
		{
			super();
			
			this.addEventListener(Event.REMOVED_FROM_STAGE,movieRemoved);
			
			player = new FLVPlayback;
			player.scaleMode = VideoScaleMode.EXACT_FIT;
			player.width = width;
			player.height = height;
			this.addChild(player);
			player.autoPlay = false;
			player.fullScreenTakeOver=true;
			player.addEventListener("ready",playMovie);
			player.addEventListener("complete",playComplete);
			
			this.playCtrlUrls = playCtrls;
		}
		
		public function play(srcUrl:String):void
		{
			player.load(srcUrl);
		}
		
		private function playMovie(e:Event):void
		{ 
			player.play(); 
			
			if (playCtrlUrls != null)
			{
				initPlayControl();
			}
		}
		
		private function playComplete(e:Event):void
		{
			if (isLoop)
			{
				player.seek(0);
				player.play();
			}
			
			dispatchEvent(new Event(FLV_PLAY_OVER));
		}
		
		private function movieRemoved(e:Event):void
		{ 
			player.removeEventListener("ready",playMovie);
			player.removeEventListener("complete",playComplete);
			this.removeEventListener(Event.REMOVED_FROM_STAGE,movieRemoved);
			
			this.removeChild(player);
			player.stop();
			player = null;
		}

		private function videoPause(isPause:Boolean):void
		{
			if(!isPause)
			{
//				player.seek(player.playheadTime+5);
				player.play();
//				player.seek(player.playheadTime+2);
				trace("player.playheadTimeplay*=",player.playheadTime);
			}
			else
			{
				player.pause();
//				player.seek(player.playheadTime-2);
				trace("player.playheadTime*pause=",player.playheadTime);
			}
		}
		
		/**
		 *是否循环播放  
		 */	
		public function get isLoop():Boolean
		{
			return _isLoop;
		}
				
		public function set isLoop(value:Boolean):void
		{
			_isLoop = value;
		}
		
		/**
		 *初始化播放控制按钮  
		 */
		private var playCtrlsLoader:CLoaderMany;
		private var btnPlay:CButton;
		private var btnPause:CButton;
		private function initPlayControl():void
		{
			btnPlay = new CButton(new Array(playCtrlUrls[0], playCtrlUrls[1]), false);
			btnPlay.x = playBtnPos.x;
			btnPlay.y = playBtnPos.y;
			this.addChild(btnPlay);
			btnPlay.visible = false;
			btnPlay.addEventListener(MouseEvent.CLICK, playBtnClick);
			
			btnPause = new CButton(new Array(playCtrlUrls[2], playCtrlUrls[3]), false);
			btnPause.x = playBtnPos.x;
			btnPause.y = playBtnPos.y;
			this.addChild(btnPause);
			btnPause.addEventListener(MouseEvent.CLICK, pauseBtnClick);
			
			
			var btnStop:CButton = new CButton(new Array(playCtrlUrls[4], playCtrlUrls[5]), false);
			btnStop.x = stopBtnPos.x;
			btnStop.y = stopBtnPos.y;
			this.addChild(btnStop);
			btnStop.addEventListener(MouseEvent.CLICK, stopBtnClick);
			
			playCtrlsLoader = new CLoaderMany();
			playCtrlsLoader.load(new Array(playCtrlUrls[6], playCtrlUrls[7]));
			playCtrlsLoader.addEventListener(CLoaderMany.LOADE_COMPLETE, ctrlLoadOKHandler);
			
		}
		private var sliderSprite:Sprite = new Sprite();
		private var filmBgLength:int;
		private var rectFilm:Rectangle;
		private var rectVoice:Rectangle;
		private function ctrlLoadOKHandler(event:Event):void
		{
			playCtrlsLoader._loaderContent[0].x = playBarPos.x;
			playCtrlsLoader._loaderContent[0].y = playBarPos.y;
			this.addChild(playCtrlsLoader._loaderContent[0]);
			
			filmBgLength = playCtrlsLoader._loaderContent[0].width;
			rectFilm = new Rectangle(0,0,filmBgLength,0);
			playCtrlsLoader._loaderContent[1].x = playBarPos.x;
			playCtrlsLoader._loaderContent[1].y = playBarPos.y-5;
			this.addChild(sliderSprite);
			sliderSprite.addChild(playCtrlsLoader._loaderContent[1]);
			sliderSprite.addEventListener(MouseEvent.MOUSE_DOWN,changeTimeDownHandler);
			sliderSprite.addEventListener(MouseEvent.MOUSE_UP,changeTimeUpHandler);
			
			sliderSprite.addEventListener(Event.ENTER_FRAME,updatePosHandler);
		}
		
		private function changeTimeDownHandler(event:Event):void
		{
			sliderSprite.removeEventListener(Event.ENTER_FRAME,updatePosHandler);
			this.addEventListener(Event.ENTER_FRAME,setSeekHandler);
			sliderSprite.startDrag(false,rectFilm);
			pauseBtnClick(null);
			
		}
		private function setSeekHandler(event:Event):void
		{
			trace("bb=",player.playheadTime,sliderSprite.x,sliderSprite.x/filmBgLength*player.totalTime);
//			player.seekPercent(sliderSprite.x/filmBgLength);
			player.seek(sliderSprite.x/filmBgLength*player.totalTime);
//			player.play();
			trace("aa=",sliderSprite.x/filmBgLength*player.totalTime);
			
		}
		private function changeTimeUpHandler(event:MouseEvent):void
		{
			sliderSprite.stopDrag();
			sliderSprite.addEventListener(Event.ENTER_FRAME,updatePosHandler);
			this.removeEventListener(Event.ENTER_FRAME,setSeekHandler);
//			setSeekHandler(null);
			playBtnClick(null);
		}
		private function updatePosHandler(event:Event):void
		{
			if(player)
			{
				sliderSprite.x = filmBgLength*(player.playheadTime/player.totalTime);
				trace("player.playheadTime==",player.playheadTime,player.totalTime,filmBgLength,sliderSprite.x);
			}
		}
		
		private function playBtnClick(event:Event):void
		{
			btnPlay.visible = false;
			btnPause.visible = true;
			videoPause(false);
			sliderSprite.addEventListener(Event.ENTER_FRAME,updatePosHandler);
		}
		
		private function pauseBtnClick(event:Event):void
		{
			btnPause.visible = false;
			btnPlay.visible = true;
			videoPause(true);
			sliderSprite.removeEventListener(Event.ENTER_FRAME,updatePosHandler);
		}
		
		private function stopBtnClick(event:Event):void
		{
			trace("playerssss.playheadTime==",player.playheadTime,player.totalTime);
			player.seekPercent(0);
			player.play();
			trace("playerssxxxx.playheadTime==",player.playheadTime,player.totalTime);
		}
	}
}