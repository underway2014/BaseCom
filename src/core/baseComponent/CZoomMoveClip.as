package core.baseComponent
{

	import core.loadEvents.CLoaderMany;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	import core.loadEvents.CLoaderMany;

	/**
	 *渐入渐出的MovieClip 
	 * @author bin.li
	 * 
	 */	
	public class CZoomMoveClip extends Sprite
	{
		private var loader:CLoaderMany;
		private var urlArr:Array;
		private var position:Point;
		//private var bitmapArr:Vector.<Bitmap> = new Vector.<Bitmap>();

		public function CZoomMoveClip(arr:Array, pos:Point)
		{
			super();
			urlArr = arr;
			position = pos;
			loader = new CLoaderMany();
			loader.load(urlArr);
			loader.addEventListener(CLoaderMany.LOADE_COMPLETE,completeHandler);
		}

		private function completeHandler(event:Event):void
		{
			for each(var l:Loader in loader._loaderContent)
			{
				l.x = position.x;
				l.y = position.y;
			}
			this.addChild(loader._loaderContent[0]);
			
			trace("add over....");
			changeZoomType(true);
		}
		
		public function changeZoomType(zoomIn:Boolean):void
		{
			this.removeChild(zoomIn ? loader._loaderContent[0] : loader._loaderContent[1]);
			this.addChild(zoomIn ? loader._loaderContent[1] : loader._loaderContent[0]);
		}

		public function clear():void
		{
			if(this.parent)
			{
				this.parent.removeChild(this);
			}
		}
	}
}