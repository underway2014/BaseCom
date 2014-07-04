package core.layout
{
	import flash.display.DisplayObjectContainer;
	import flash.events.EventDispatcher;
	
	import core.interfaces.MoveLeftRightItem;
	
	public class MoveManger extends EventDispatcher
	{
		/**
		 * 用于按钮SPRITE 显示对象的
		 * 
		 */		
		public function MoveManger()
		{
			super();
		}
		private var itemArr:Vector.<MoveLeftRightItem> = new Vector.<MoveLeftRightItem>;
		public function add(item:MoveLeftRightItem):void
		{
			itemArr.push(item);
		}
		public function getItemById(id:int):MoveLeftRightItem
		{
			return itemArr[id];
		}
		private var i:int;
		public function getIdByItem(s:MoveLeftRightItem):int
		{
			i=0;
			for each(var item:MoveLeftRightItem in itemArr)
			{
				i++;
				if(item == s)
				{
					return i;
					break;
				}
			}
			return 0;
		}
		public function getItemArr():Vector.<MoveLeftRightItem>
		{
			return itemArr;
		}
		public function getArrayAfterId(id:int):Vector.<MoveLeftRightItem>
		{
			var vc:Vector.<MoveLeftRightItem> = new Vector.<MoveLeftRightItem>;
			if(id < itemArr.length - 1)
			{
				for(id;id < itemArr.length - 1;id++)
				{
					vc.push(itemArr[id + 1]);
				}
				return vc;
			}
			return null;
		}
		public function getArrayBeforeId(id:int):Vector.<MoveLeftRightItem>
		{
			var vc:Vector.<MoveLeftRightItem> = new Vector.<MoveLeftRightItem>;
			if(id > 0  && id < itemArr.length)
			{
				for(id;id > 0;id--)
				{
					vc.push(itemArr[id - 1]);
				}
				return vc;
			}
			return null;
		}
		public function getArrayBetweenId(beginId:int,endId:int):Vector.<MoveLeftRightItem>
		{
			var vc:Vector.<MoveLeftRightItem> = new Vector.<MoveLeftRightItem>;
			for(beginId;beginId < endId;beginId++)
			{
				vc.push(itemArr[beginId + 1]);
			}
			return vc;
		}
	}
}
