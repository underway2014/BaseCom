package core.baseComponent
{
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import core.tween.TweenLite;
	
	public class LoopAtlas extends Sprite
	{
		private var viewArr:Array;
		private var currentPage:int = 0;
		public function LoopAtlas(_viewArr:Array)
		{
			super();
			
			viewArr = _viewArr;
			len = viewArr.length;
			viewContain = new Sprite();
			addChild(viewContain);
			init();
		}
		private var viewContain:Sprite;
		private var len:int;
		private var leftView:Sprite = new Sprite();
		private var midView:Sprite = new Sprite();
		private var rightView:Sprite = new Sprite();
		private var leftIndex:int;
		private var rightIndex:int;
		private var manger:Array;
		private var dataViewArr:Array;
		private function init():void
		{
			manger = new Array();
			manger.push(leftView);
			manger.push(midView);
			manger.push(rightView);
			
			dataViewArr = new Array();
			
			timer.addEventListener(TimerEvent.TIMER,autoMove);
			timer.start();
			getView();
		}
		private var dir:int = -1;
		private function autoMove(event:TimerEvent):void
		{
			var endX:int = viewContain.x + 1494 * dir;
			for each(var view:Sprite in manger)
			{
//				endX = view.x + dir * view.width;
			}
				TweenLite.to(viewContain,.4,{x:endX,onComplete:moveOver});
		}
		private function moveOver():void
		{
			currentPage -= dir;
			if(currentPage > viewArr.length - 1)
			{
				currentPage = 0;
			}
			if(currentPage < 0)
			{
				currentPage = viewArr.length - 1;
			}
			if(dir == -1)//left
			{
				
			}else{//right
				
			}
			getView();
		}
		private function getView():void
		{
			while(dataViewArr.length)
			{
				dataViewArr.shift();
			}
			if(currentPage - 1 >=0)
			{
				leftIndex = currentPage - 1;
			}
			else{
				leftIndex = len - 1;
			}
			if(currentPage + 1 > len - 1)
			{
				rightIndex = 0;
			}else{
				rightIndex = currentPage + 1;
			}
			dataViewArr.push(viewArr[leftIndex]);
			dataViewArr.push(viewArr[currentPage]);
			dataViewArr.push(viewArr[rightIndex]);
			
			reLayout();
		}
		private var timer:Timer = new Timer(1000 * 4);
		private function reLayout():void
		{
			viewContain.x = 0;
			var n:int = - 1;
			for each(var view:Sprite in dataViewArr)
			{
				view.x = n * 1494;
				viewContain.addChild(view);
				n++;
			}
			while(viewContain.numChildren  > 3)
			{
				viewContain.removeChildAt(0);
			}
		}
	}
}