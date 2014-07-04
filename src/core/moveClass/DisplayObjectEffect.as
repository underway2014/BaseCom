package core.moveClass
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	
	import flashx.textLayout.formats.Float;

	public class DisplayObjectEffect extends EventDispatcher
	{
		private static var SCALE:Number = 1.2;
		/**
		 *注册点在左上角的放大缩小 
		 * 
		 */		
		public function DisplayObjectEffect()
		{
		}
		private static var nowObj:DisplayObject;
		private static var oldPoint:Point = new Point();
		/**
		 * 
		 * @param obj
		 * @param _isZoomOut	//放大后是否还要缩小呢？
		 * 
		 */		
		public static function scale(obj:DisplayObject,_isZoomOut:Boolean = false):void
		{
//			if(nowObj)
//			{
//				resetAll();
//			}
			nowObj = obj;
			oldPoint.x = obj.x;
			oldPoint.y = obj.y;
			isZoomOut = _isZoomOut;
			nowObj.addEventListener(Event.ENTER_FRAME,zoomIn);
		}
		private static function resetAll():void
		{
//			if(
		}
		private static var isZoomOut:Boolean;
		/**
		 *放大 
		 * @param event
		 * 
		 */		
		private static function zoomIn(event:Event):void
		{
			nowObj.x -= nowObj.width*0.1/2;
			nowObj.scaleX += 0.1;
			nowObj.y -= nowObj.height*0.1/2;
			nowObj.scaleY += 0.1;
			
			if(!isZoomOut)
			{
				changeAlpha();
			}
			else
			{
				if(nowObj.scaleX>SCALE)
				{
					nowObj.removeEventListener(Event.ENTER_FRAME,zoomIn);
					nowObj.addEventListener(Event.ENTER_FRAME,zoomOut);
				}
			}
		}
		/**
		 *缩小 
		 * 
		 */		
		private static function zoomOut(event:Event):void
		{
			nowObj.x += nowObj.width*0.1/2;
			nowObj.scaleX -= 0.1;
			nowObj.y += nowObj.height*0.1/2;
			nowObj.scaleY -= 0.1;
			if(nowObj.scaleX<=1||nowObj.scaleY<=1)
			{
				nowObj.removeEventListener(Event.ENTER_FRAME,zoomOut);
				reset();
			}
		}
		
		private static function changeAlpha():void
		{
			if(nowObj.scaleX>SCALE)
				nowObj.alpha -= 0.3;
			if(nowObj.alpha<=0)
			{
				nowObj.removeEventListener(Event.ENTER_FRAME,zoomIn);
				_instance.dispatchEvent(new Event("scaleOver"));
			}
		}
		/**
		 *恢复 
		 * 
		 */		
		public static function reset():void
		{
			if(nowObj)
			{
//				nowObj.removeEventListener(Event.ENTER_FRAME,zoomIn);
				nowObj.scaleX = nowObj.scaleY = 1;
				nowObj.alpha = 1;
				nowObj.x = oldPoint.x;
				nowObj.y = oldPoint.y;
				_instance.dispatchEvent(new Event("scaleOver"));
			}
		}
		private static var _instance:DisplayObjectEffect;
		public static function get instance():DisplayObjectEffect
		{
			if(!_instance)
			{
				_instance = new DisplayObjectEffect();
			}
			
			return _instance;
		}

			
	}
}