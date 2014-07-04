package core.layout
{
	import flash.display.DisplayObjectContainer;
	import flash.events.EventDispatcher;
	
	public class Manager extends EventDispatcher
	{
		/**
		 * 用于按钮SPRITE 显示对象的
		 * 
		 */		
		public function Manager()
		{
			super();
		}
		private var itemArr:Vector.<DisplayObjectContainer> = new Vector.<DisplayObjectContainer>;
		public function add(item:DisplayObjectContainer):void
		{
			itemArr.push(item);
		}
		public function getItemById(id:int):DisplayObjectContainer
		{
			return itemArr[id];
		}
		private var i:int;
		public function getIdByItem(s:DisplayObjectContainer):int
		{
			i=0;
			for each(var item:DisplayObjectContainer in itemArr)
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
		public function getItemArr():Vector.<DisplayObjectContainer>
		{
			return itemArr;
		}
		public function getArrayAfterId(id:int):Vector.<DisplayObjectContainer>
		{
			var vc:Vector.<DisplayObjectContainer> = new Vector.<DisplayObjectContainer>;
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
		public function getArrayBeforeId(id:int):Vector.<DisplayObjectContainer>
		{
			var vc:Vector.<DisplayObjectContainer> = new Vector.<DisplayObjectContainer>;
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
		public function getArrayBetweenId(beginId:int,endId:int):Vector.<DisplayObjectContainer>
		{
			return null;
		}
	}
}