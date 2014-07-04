package core.moveClass
{
	import core.baseComponent.CMoveClip;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 *播放一组图片，可渐入渐出，可循环播放，可单次播放
	 * @author bin.li
	 * 
	 */
	public class CGradient extends EventDispatcher
	{
		/**
		 * 
		 * @param delay   播放速度
		 * @param isonce  是否循环播放
		 * maxalpha  大于1时，会有暂停效果
		 */		
		public function CGradient(delay:int=100,isonce:Boolean = true,maxalpha:Number=1)
		{
			objArr = new Array;
			_delay = delay;
			isOnce = isonce;
			maxAlpha = maxalpha;
		}
		public static const ONCE_OVER:String 	= "once_over";
		private var isOnce:Boolean;
		private var _delay:int;
		private var objArr:Array;
		private var currentObj:DisplayObject;
		private var nextObj:DisplayObject;
		
		public function add(obj:DisplayObject):void
		{
			objArr.push(obj);
			obj.alpha = 0;
			if(!currentObj)
			{
				currentObj = obj;
			}
		}
		public function gotAndStop(_index:int):void
		{
			if(_index>objArr.length)
			{
				_index = 1;
			}
			if(currentObj != objArr[_index-1])
			{
				currentObj.alpha = 0;
				currentObj = objArr[_index-1];
				currentObj.alpha = 1;
			}
			else
			{
				currentObj.alpha = 1;
			}
		}
		private var timer:Timer;
		/**
		 * 开始播放
		 * **/
		public function visionChange():void
		{
			timer = new Timer(_delay);
			timer.addEventListener(TimerEvent.TIMER,realChange);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE,stopMove);
			timer.start();
		}
		/**
		 *播放中停止播放 
		 * 
		 */		
		public function stopPlay():void
		{
			currentObj.alpha = 0;
			alphaIsFull = false;
			currentObj = objArr[0];
			clearTimer();
		}
		/**
		 * 图片alpha变化速度
		 * **/
		private var _alphaSpeed:Number = 0.05;
		private var isNext:Boolean = false;
		private var alphaIsFull:Boolean;
		
		private var maxAlpha:Number;
		private function realChange(event:Event):void
		{
			//			trace("change alpha....");
			if(currentObj.alpha>=maxAlpha||alphaIsFull)
			{
				if(currentObj.alpha>1) currentObj.alpha = 1;
				currentObj.alpha-=_alphaSpeed;
				if(currentObj.alpha<=0.5)
				{
					isNext = true;
				}
			}
			else
			{
				currentObj.alpha+=_alphaSpeed;
				trace("===currentObj.alpha==",currentObj.alpha,maxAlpha);
				if(currentObj.alpha>=maxAlpha)
					alphaIsFull = true;
			}
			
			
			if(isNext)
			{
				if(objArr.indexOf(currentObj)+1<objArr.length)
				{
					nextObj =objArr[objArr.indexOf(currentObj)+1];
				}
				else if(isOnce)//播放一次就结束语
				{
					stopPlay();
					this.dispatchEvent(new Event(ONCE_OVER));
					return;
				}
				else//循环播放
				{
					nextObj=objArr[0];
				}	
				
				nextObj.alpha+=_alphaSpeed;
				if(nextObj.alpha>=0.5)
				{
					currentObj.alpha = 0;
					currentObj = nextObj;
					alphaIsFull= false;
					nextObj=null;
					isNext = false;
				}
			}
		}
		private function stopMove(event:Event):void
		{
			
		}
		public function clearTimer():void
		{
			if(timer)
			{
				timer.removeEventListener(TimerEvent.TIMER,realChange);
				timer.removeEventListener(TimerEvent.TIMER_COMPLETE,stopMove);
				timer.stop();
				timer = null;
			}
		}
		public function get alphaSpeed():Number
		{
			return _alphaSpeed;
		}
		
		public function set alphaSpeed(value:Number):void
		{
			_alphaSpeed = value;
		}
	}
}