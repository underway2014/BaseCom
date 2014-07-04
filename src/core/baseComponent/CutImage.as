package core.baseComponent
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import core.loadEvents.CLoader;
	
	public class CutImage extends Sprite
	{
		private var _url:String;
		private var wwidth:int;
		private var hheight:int;
		private var beginPoint:Point;
		public function CutImage(_ww:int,_hh:int,_beginPoint:Point)
		{
			super();
			wwidth = _ww;
			hheight = _hh;
			beginPoint = _beginPoint;
		}

		public function get url():String
		{
			return _url;
		}

		public function set url(value:String):void
		{
			_url = value;
			var loader:CLoader = new CLoader();
			loader.load(_url);
			loader.addEventListener(CLoader.LOADE_COMPLETE,loadOkHandler);
		}
		private function loadOkHandler(event:Event):void
		{
			var ll:CLoader = event.target as CLoader;
			var o:DisplayObject = ll._loader;
			var bitmapData:BitmapData = new  BitmapData(wwidth,hheight + beginPoint.y);
			bitmapData.draw(o,null,null,null,new Rectangle(beginPoint.x,beginPoint.y,wwidth,hheight));
			var bitmap:Bitmap = new Bitmap();
			bitmap.bitmapData = bitmapData;
			addChild(bitmap);
			this.width = 706;
			this.height = 651;
			ll._loader = null;
		}

	}
}