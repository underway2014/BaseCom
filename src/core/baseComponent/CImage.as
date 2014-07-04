package core.baseComponent
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import core.layout.PictureZoom;
	import core.loadEvents.CLoader;
	
	public class CImage extends Sprite
	{
		private var _url:String;
		private var keepProportion:Boolean;
		public var data:*;
		private var normalContain:Sprite;
		/**
		 * 
		 * @param _ww 矩形框
		 * @param _hh
		 * @param _keepProportion 是否是等比例拉伸
		 * 
		 */		
		public function CImage(_ww:int,_hh:int,_keepProportion:Boolean = true,ishowBg:Boolean = true)
		{
			super();
			keepProportion = _keepProportion;
			var bg:Shape = new Shape();
			bg.graphics.beginFill(0xf0f0f0);
			bg.graphics.drawRect(0,0,_ww,_hh);
			bg.graphics.endFill();
			if(!ishowBg)
			{
				bg.alpha = 0;
			}
			this.addChild(bg);
			normalContain = new Sprite();
			addChild(normalContain);
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
			loader.addEventListener(CLoader.LOADE_COMPLETE,picOkHandler);
		}
		private function picOkHandler(event:Event):void
		{
			var l:CLoader = event.target as CLoader;
			if(keepProportion)
			{
				PictureZoom.strench(l._loader,this.width,this.height);
			}else{
				l._loader.width = this.width;
				l._loader.height = this.height;
			}
			normalContain.addChild(l._loader);
		}
		public function hidenNormal(bool:Boolean):void
		{
			normalContain.visible = bool;
		}

	}
}