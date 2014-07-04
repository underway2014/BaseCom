package core.layout
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import core.interfaces.SelectItem;
	import core.loadEvents.Cevent;

	/**
	 * 管理添加进来的显示对象
	 * @author bin.li
	 * 
	 */	
	public class Group extends EventDispatcher
	{
		private var itemArr:Vector.<SelectItem> = new Vector.<SelectItem>();
		private var _autoChangeState:Boolean;
		private var currentItem:SelectItem;
		public function Group()
		{
		}
		public function resetCurrentItem():void
		{
			currentItem = null;
		}
		public function add(item:SelectItem):void
		{
			itemArr.push(item);
		}
		public function getItmeArr():Vector.<SelectItem>
		{
			return itemArr;
		}
		public function clear():void
		{
			for each(var item:DisplayObject in itemArr)
			{
				if(item.parent)
				{
					item.parent.removeChild(item);
				}
				item = null;
			}
		}
		/**
		 * 根据ID选中DisplayObject
		 * @param id 当前管理的OBJ的索引，-1：所有都处于正常状态
		 * 
		 */		
		public function selectById(id:int):void
		{
			if(id==-1)//所有的按钮都处于正常状态
			{
				if(currentItem)
				{
					currentItem.select(false);
					currentItem = null;
				}
				return;
			}
			var item:SelectItem = itemArr[id];
			if(currentItem != item)
			{
				if(currentItem)
				{
					currentItem.select(false);
				}
				currentItem = item;
				currentItem.select(true);
				dispatchEvent(new Event(Cevent.SELECT_CHANGE));
			}
		}
		public function selectByItem(item:SelectItem):void
		{
			if(currentItem != item)
			{
				if(currentItem)
				{
					currentItem.select(false);
				}
				currentItem = item;
				if(!_autoChangeState)
				{
					currentItem.select(true);
				}
				dispatchEvent(new Event(Cevent.SELECT_CHANGE));
			}
		}
		
		/**
		 * 只切换选中状态，不发送SELECT_CHANGE事件
		 */	
		public function setItemSelected(id:int):void
		{
			if(id==-1)//所有的按钮都处于正常状态
			{
				currentItem.select(false);
				currentItem = null;
				return;
			}
			var item:SelectItem = itemArr[id];
			if(currentItem != item)
			{
				if(currentItem)
				{
					currentItem.select(false);
				}
				currentItem = item;
				currentItem.select(true);
			}
		}
		public function getCurrentId():int
		{
			return itemArr.indexOf(currentItem);
		}
		public function getCurrentObj():SelectItem
		{
			return currentItem;
		}

		public function get autoChangeState():Boolean
		{
			return _autoChangeState;
		}

		public function set autoChangeState(value:Boolean):void
		{
			_autoChangeState = value;
		}

	}
}