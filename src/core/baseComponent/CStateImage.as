package core.baseComponent
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import core.layout.PictureZoom;
	import core.loadEvents.CLoader;

	public class CStateImage extends CImage
	{
		private var _downUrl:String;
		private var donwContain:Sprite;
		private var keepPro:Boolean;
		public function CStateImage(_ww:int, _hh:int, _keepProportion:Boolean=true, ishowBg:Boolean=true)
		{
			super(_ww, _hh, _keepProportion, ishowBg);
			keepPro = _keepProportion;
		}

		public function get downUrl():String
		{
			return _downUrl;
		}

		public function set downUrl(value:String):void
		{
			_downUrl = value;
			donwContain = new Sprite();
			addChild(donwContain);
			donwContain.visible = false;
			var loader:CLoader = new CLoader();
			loader.load(_downUrl);
			loader.addEventListener(CLoader.LOADE_COMPLETE,picOkHandler);
		}
		private function picOkHandler(event:Event):void
		{
			var l:CLoader = event.target as CLoader;
			if(keepPro)
			{
				PictureZoom.strench(l._loader,this.width,this.height);
			}else{
				l._loader.width = this.width;
				l._loader.height = this.height;
			}
			donwContain.addChild(l._loader);
		}
		public function showGreySatate(_bool:Boolean):void
		{
			donwContain.visible = _bool;
		}

	}
}