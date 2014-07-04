package core.layout
{
	import flash.display.DisplayObject;
	import flash.events.EventDispatcher;
	import flash.sensors.Accelerometer;

	public class PageLayout extends EventDispatcher
	{

			private var itemArr:Vector.<DisplayObject> = new Vector.<DisplayObject>();
			
			private var row:int;//纵向个数
			private var column:int;//横向个数
			private var itemNum:int;//元素总个数
			private var wSpace:int;
			private var hSpace:int;
			private var offx:int;
			private var offy:int;

			/**
			 * 
			 * @param _row  行排个数
			 * @param _vertical	列个数
			 * @param _wSpace	行宽
			 * @param _hSpace	列高
			 * @param _offx		偏移
			 * @param _offy
			 * 
			 */		
			public function PageLayout(_row:int,_column:int,_itemNum:int, _wSpace:int,_hSpace:int,_offx:int=0,_offy:int=0)
			{
				row = _row;
				column = _column;
				itemNum = _itemNum;
				wSpace = _wSpace;
				hSpace = _hSpace;
				offx = _offx;
				offy = _offy;
			}
			
			public function clear():void
			{
				itemArr.length = 0;//对vector型数组进行清空
			}
			
			public function length():int
			{
				return itemArr.length;
			}
			
			public function add(item:DisplayObject):void
			{
				var len:int = itemArr.length >= 8 ? itemArr.length%8 : itemArr.length;
				
				item.x = (len%column)*wSpace + offx + (int)(itemArr.length/8)*4*wSpace;
				item.y = int(len/column)*hSpace + offy;
				itemArr.push(item);
			}
			
			public function getItem(index:int):DisplayObject
			{
				var item:DisplayObject = itemArr[index];
				return item;
			}
			
			public function resetPosition(startIndex:int):void
			{
				var prevPageNum:int = startIndex == 0 ? 0 : (row*column-startIndex%(row*column));
				
				for (var i:int=0; i<itemArr.length; i++)
				{
					var len:int = (i+prevPageNum) >= 8 ? (i+prevPageNum)%8 : i+prevPageNum;
					
					itemArr[i].x = (len%column)*wSpace + offx + (int)((i+prevPageNum)/8)*4*wSpace;
					itemArr[i].y = int(len/column)*hSpace + offy;
				}

			}
	}
}