package core.baseComponent
{
	
	
	import core.loadEvents.CLoaderMany;
	import core.loadEvents.Cevent;
	import core.moveClass.CGradient;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import flashx.textLayout.elements.OverflowPolicy;

	/**
	 *轮播图片 可渐出渐入
	 * @author bin.li
	 * 
	 */	
	public class CMoveClip extends Sprite
	{
		
		public static const PLAY_OVER:String = "playover";
		
		private var loader:CLoaderMany;
		private var urlArr:Array;
		private var bitmapArr:Vector.<Bitmap> = new Vector.<Bitmap>();
		private var speed:Number;
		private var specialStr:String;
		
		/**
		 * @param arr  图片地址数组
		 * @param s    alpha递变值(>0,<=1)
		 * @param delay  alpha递变时间间隔""
		 * @param isonce 是否循环播放
		 * @param maxalpha >1 让图片alpha达到最大时，出现暂停效果// 60 * 1000 / 100 * 0.1
		 * 
		 *    要求播放时长（分钟）X 60 X 1000 / delay X s = maxalpha;
		 */		
		public function CMoveClip(arr:Array,s:Number=1,delay:int=1000,isonce:Boolean = true,maxalpha:Number=1)
		{
			super();
			urlArr = arr;
//			trace("===in mc urlarr===",urlArr);
//			trace("*****maxalpha*******",maxalpha);
			cgradient = new CGradient(delay,isonce,maxalpha);
			cgradient.addEventListener(CGradient.ONCE_OVER,playoverHandler);
			
			speed = s;
			loader = new CLoaderMany();
			loader.load(urlArr);
			loader.addEventListener(CLoaderMany.LOADE_COMPLETE,completeHandler);
		}
		private function playoverHandler(event:Event):void
		{
			trace("cm get over event");
			dispatchEvent(new Event(PLAY_OVER));
		}
		private var bitmap:Bitmap;
		private var bd:BitmapData;
		private var cgradient:CGradient;
		public static const LOAD_OVER:String = "load_over";
		private function completeHandler(event:Event):void
		{
			for each(var l:Loader in loader._loaderContent)
			{
//				bitmap = new Bitmap();
//				bd = new BitmapData(l.width,l.height);
//				bd.draw(l);
//				bitmap.bitmapData = bd;
//				bitmapArr.push(l);
				cgradient.add(l);
				this.addChild(l);
			}
			dispatchEvent(new Event(LOAD_OVER));
			trace("add over....");
			
		}
		private var _totalFrame:int;
		/**
		 *开始播放 
		 * 
		 */		
		public function play():void
		{
			cgradient.alphaSpeed = speed;
			cgradient.visionChange();
		}
		public function stop():void
		{
			cgradient.stopPlay();
		}
		public function gotoAndSotp(_index:int):void
		{
			cgradient.gotAndStop(_index);
		}
		public function clear():void
		{
			cgradient.clearTimer();
			if(this.parent)
			{
				this.parent.removeChild(this);
			}
		}

		public function get totalFrame():int
		{
			_totalFrame = loader._loaderContent.length;
			return _totalFrame;
		}

	}
}