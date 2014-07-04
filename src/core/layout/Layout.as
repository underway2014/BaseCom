package core.layout
{
	
	
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	/**
	 * DisplayObject 布局
	 * @author bin.li
	 * 
	 */
	public class Layout extends EventDispatcher
	{
		private var itemArr:Vector.<DisplayObject> = new Vector.<DisplayObject>();
		
		private var row:int;//横向个数
		private var vertical:int;//纵向个数
		private var w:int;
		private var h:int;
		private var offx:int;
		private var offy:int;
		
		private var perWidth:int;//横向每个点的宽度
		private var perHeight:int//纵向每个占的高度
		
		public static const MOVE_OVER:String = "move_over";//按钮移动结束
		/**
		 * 
		 * @param _row  行排个数
		 * @param _vertical	列个数
		 * @param _width	行宽
		 * @param _height	列高
		 * @param _offx		偏移
		 * @param _offy
		 * 
		 */		
		public function Layout(_row:int,_vertical:int,_width:int,_height:int,_offx:int=0,_offy:int=0)
		{
			row = _row;
			vertical = _vertical;
			w = _width;
			h = _height;
			offx = _offx;
			offy = _offy;
			
			//perWidth = w/row;
			//perHeight = h/vertical;
			
			perWidth = w;
			perHeight = h;
		}
		public function clear():void
		{
			itemArr.length = 0;//对vector型数组进行清空
		}
		public function add(item:DisplayObject):void
		{
			var len:int = itemArr.length;
			item.x = (len%row)*perWidth + offx;
			item.y = int(len/row)*perHeight + offy;
			itemArr.push(item);
		}
		private var totalWidth:int;
		public function addAppress(item:DisplayObject):void
		{
//			trace("===totalWidth===",totalWidth);
			var len:int = itemArr.length;
			item.x = totalWidth + offx;
			item.y = int(len/row)*perHeight + offy;
			itemArr.push(item);
			totalWidth += item.width;
		}
		private var moveDis:int;
		private var disXY:Array;
		/**
		 * 实现layout所管理的对象逐个移动
		 * @param dis OBJ与目的地的距离
		 * @param _type 移动方向：1：向下，-1：向上
		 * 
		 */		
		public function objMove(dis:int,_type:int=1):void
		{
			disXY = [];
			for each(var obj:DisplayObject in itemArr)
			{
				disXY.push(obj.y + dis*_type);
			}
			ex.addEventListener(Event.ENTER_FRAME,realmoveHandler);
		}
		public function getItemArr():Vector.<DisplayObject>
		{
			return itemArr;
		}
		private var ex:Shape = new Shape;
		private var i:int;
		private var beginDis:int = 20;//当前一OBJ移距目的地距离小于这个时，第二个OBJ开始移动
		private function realmoveHandler(event:Event):void
		{
			for(i=0;i<itemArr.length;i++)
			{
				if(i>0)
				{
					if(Math.abs(itemArr[i-1].y-disXY[i-1])<beginDis)
					{
						itemArr[i].y += (disXY[i] -itemArr[i].y)*0.33 ;
					}
				}
				else
				{
					itemArr[i].y += (disXY[i] -itemArr[i].y)*0.33 ;
				}
				if(Math.abs(disXY[i] -itemArr[i].y)<2)
				{
					itemArr[i].y = disXY[i];
				}
			}
			if(Math.abs(itemArr[itemArr.length-1].y-disXY[itemArr.length-1])<2)
			{
				ex.removeEventListener(Event.ENTER_FRAME,realmoveHandler);
				trace("ex  remove addeventlistener");
				dispatchEvent(new Event(MOVE_OVER));
			}
		}
	}
}