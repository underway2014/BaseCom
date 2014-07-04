package core.layout
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.geom.Point;
	
	import org.osmf.layout.ScaleMode;
	/**
	 *增加了放大缩小，改变坐标功能 
	 * @author bin.li
	 * 
	 */
	public class GradientZoom extends Layout
	{
		private var ex:Shape = new Shape;
		
		public function GradientZoom(_row:int, _vertical:int, _width:int, _height:int, _offx:int=0, _offy:int=0)
		{
			super(_row, _vertical, _width, _height, _offx, _offy);
		}
		private var zoomOutThreshold:Number = 0.01;//缩小阀值
		private var zoomInThreshold:Number = 0.99;
		
		private var randomValue:Array = new Array;//
		private var i:int;
		
		private var smallSpeed:Number = 0.25;//缩小时的最小速度
		
		public var zoomOver:Boolean;//是否缩放完毕
		/**
		 *缩小 
		 * 
		 */		
		public function zoomOut():void
		{
			zoomOver = false;
//			randomValuArr();
			ex.addEventListener(Event.ENTER_FRAME,zoomOutHandler);
		}
		private function zoomOutHandler(event:Event):void
		{
			i=0;
			
			for each(var o:DisplayObject in super.getItemArr())
			{
//				o.scaleX -= Math.abs(o.scaleX)*randomValue[i];
//				o.scaleY -= Math.abs(o.scaleY)*randomValue[i];
//				o.alpha -= Math.abs(o.alpha)*randomValue[i];
//				i++;
				o.scaleX -= 0.444;
				o.scaleY -= 0.444;
				o.alpha -= 0.444;
			}
			trace("==zoom min==",o.scaleX,o.scaleY,i,randomValue);
			if(checkZoom(1))
			{
				trace("==check 缩小 true===");
				ex.removeEventListener(Event.ENTER_FRAME,zoomOutHandler);
				zoomOver = true;
				dispatchEvent(new Event(ZOOMOUT_OVER));
			}
		}
		public static const ZOOMOUT_OVER:String = "zoomoutover";
		public static const ZOOMIN_OVER:String = "zoominover";
		/**
		 *放大
		 * 
		 */		
		public function zoomIn():void
		{
			nowFrame = 0;
			zoomOver = false;
			randomValuArr();
			delayArr.length = 0;
			for(i=0;i<super.getItemArr().length;i++)
			{
				delayArr.push(Math.ceil(Math.random()*8));
			}
			trace("==delayarr===",delayArr);
			ex.addEventListener(Event.ENTER_FRAME,zoomInHandler);
		}
		private var delayArr:Array = new Array;//存放延时的数据
		private var nowFrame:int;
		
		private function zoomInHandler(event:Event):void
		{
			i=0;
			nowFrame++;
			trace("===nowframe==",nowFrame);
			for each(var o:DisplayObject in super.getItemArr())
			{
				if(nowFrame>delayArr[i])//延时效果
				{
					//randomValue[i]
					var speed:Number = (1-o.scaleX)*0.3;
					if(speed<0.02)
					{
						speed = 0.02;
					}
					if(1-o.scaleX<0.02)
					{
						o.scaleX = o.scaleY = o.alpha = 1;
					}
					else
					{
						o.scaleX += speed;
						o.scaleY += speed;
						o.alpha += speed;
					}
					i++;
				}
				else
				{
					i++;
					continue;
				}
			}
			if(checkZoom(2))
			{
				ex.removeEventListener(Event.ENTER_FRAME,zoomInHandler);
				zoomOver = true;
				dispatchEvent(new Event(ZOOMIN_OVER));
			}
		}
		
		/**
		 *检查缩放情况 
		 * @param type 1:缩小 2：放大
		 * @return 
		 * 
		 */		
		private function checkZoom(type:int):Boolean
		{
			switch(type)
			{
				case 1:			//缩小
					trace("===/缩小");
					for each(var o:DisplayObject in super.getItemArr())
					{
						if(o.scaleX<zoomOutThreshold&&o.scaleY<zoomOutThreshold)
						{
							o.scaleX = o.scaleY = o.alpha = zoomOutThreshold;
						}
						else
						{
							return false;
						}
					}
					return true;
					break;
				case 2:			//放大
					for each(var oo:DisplayObject in super.getItemArr())
					{
						if(oo.scaleX>zoomInThreshold&&oo.scaleY>zoomInThreshold)
						{
							oo.scaleX = oo.scaleY = oo.alpha = 1;
						}
						else
						{
							return false;
						}
					}
					return true;
					break;
			}
			return true;
		}
		/**
		 *改变所有的纵坐标 
		 * @param pointY  改变量
		 * type: 1向下，-1：向上
		 */		
		public function changeCoordinate(pointY:Number,type:int=1):void
		{
			for each(var oo:DisplayObject in super.getItemArr())
			{
				oo.y += pointY*type;
			}
		}
		
		/**
		 *产生一级随机数 
		 * 
		 */		
		private function randomValuArr():void
		{
			randomValue.length = 0;
			for(i=0;i<super.getItemArr().length;i++)
			{
				var speed:Number = Math.random()*0.5+0.05;
				speed = (speed<smallSpeed?smallSpeed:speed);
				randomValue.push(speed);
			}
		}
	}
}