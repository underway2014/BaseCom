package core.baseComponent
{
	import core.loadEvents.CLoaderMany;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.sampler.NewObjectSample;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class TextFieldTemplate extends Sprite
	{
		/**TextFieldTemplate 的宽度**/
		private var _width:Number;
		/**TextFieldTemplate 的高度**/
		private var _height:Number;
		/**文本内容**/
		private var _text:String;
		
		/**图片URL(name,title,left or right)**/
		private var _picUrlArr:Array;
		/**判断使用那种模板  默认：0:文本右边有展示图片，1：文本左边有图片展示**/
		private var _type:uint=0;
		
		private var _fontsize:uint = 20;
		private var _color:uint = 0xaa0000;
		private var _indent:uint = 25;
		private var _leadint:uint = 6;
		private var _letterspace:uint = 4;

		private var desTxt:TextField;
		/**
		 * 
		 * @param _w	内含文本宽
		 * @param _h	内含文本高
		 * 
		 */		
		public function TextFieldTemplate(_w:Number = 250,_h:Number = 150)
		{
			super();
			desTxt = new TextField();
			desTxt.wordWrap = true;
			desTxt.selectable = false;
			desTxt.width = _w;
			
			var txtFormat:TextFormat = new TextFormat();
			txtFormat.size = _fontsize;
			txtFormat.color = _color;
			txtFormat.indent = _indent;
//			txtFormat.font = "Berlin Sans FB Demi";
			txtFormat.leading = _leadint;
			txtFormat.letterSpacing = _letterspace;
			desTxt.defaultTextFormat = txtFormat;
			
			this.addChild(desTxt);
			
			
		}
		/**文本中图片坐标**/
		private var picsXYL:Array = [new Point(100,0),new Point(100,30),new Point(0,30)];
		private var picsXY:Array = [new Point(0,0),new Point(0,30),new Point(250,30)];
		private var txtXYL:Array = [new Point(100,0),new Point(100,30)];
		private var txtXY:Array = [new Point(0,0),new Point(0,30)];
		private var loader:CLoaderMany;
		private var n:uint;
		private function setXY():void
		{
			n = 0;
			var bp:Bitmap;
			switch(type)
			{
				case 0:
					for each(bp in loadContent)
					{
						bp.x = picsXY[n].x;
						bp.y = picsXY[n].y;
						addChild(bp);
						n++;
					}
					desTxt.x = txtXY[Math.min(1,n-1)].x;
					desTxt.y = txtXY[Math.min(1,n-1)].y;
					break;
				case 1:
					for each(bp in loadContent)
					{
						bp.x = picsXYL[n].x;
						bp.y = picsXYL[n].y;
						addChild(bp);
						n++;
					}
					desTxt.x = txtXYL[Math.min(1,n-1)].x;
					desTxt.y = txtXYL[Math.min(1,n-1)].y;
					break;
				case 2:
					break;
			}
		}

		private var loadContent:Vector.<Bitmap> = new Vector.<Bitmap>();//存放加载好的内容
		private function picLoadOkHandler(event:Event):void
		{
			loadContent.length = 0;
			var bitmap:Bitmap;
			var bitmapdata:BitmapData;
			for each(var l:Loader in loader._loaderContent)
			{
				bitmap = new Bitmap();
				bitmapdata = new BitmapData(l.width,l.height);
				bitmapdata.draw(l);
				bitmap.bitmapData = bitmapdata;
				loadContent.push(bitmap);
			}
			setXY();
		}
		public function get text():String
		{
			return _text;
		}

		public function set text(value:String):void
		{
			_text = value;
			desTxt.htmlText = _text;
			desTxt.height = desTxt.textHeight+30;
		}

		public function get type():uint
		{
			return _type;
		}

		public function set type(value:uint):void
		{
			_type = value;
		}

		public function get picUrlArr():Array
		{
			return _picUrlArr;
		}

		public function set picUrlArr(value:Array):void
		{
			_picUrlArr = value;
			loader = new CLoaderMany();
			loader.load(_picUrlArr);
			loader.addEventListener(CLoaderMany.LOADE_COMPLETE,picLoadOkHandler);
		}


	}
}