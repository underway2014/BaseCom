package core.baseComponent
{
	import core.loadEvents.CLoader;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class CTextField extends Sprite
	{
		private var txt:TextField;
		private var _width:Number;
		
		/**用于测试的图片坐标,url**/
		private var testXY:Array = [new Point(10,20),new Point(100,100)];
		private var titlePicUrl:Array = ["source/data/sichuan/source/pictures/2.png","source/data/sichuan/source/pictures/1.png"];
		/**
		 * 
		 * @param _w
		 * @param fontSize 字体大小
		 * @param _color 颜色
		 * @param _indent 首先缩进
		 * @param _lead  行距
		 * @param _ltspace  字符间距
		 * 
		 */		
		public function CTextField(_w:Number=150,fontSize:int=15,_color:int=0x22cc00,_indent:int=0,_lead:int=5,_ltspace:int=2)
		{
			super();
			this.mouseEnabled = false;
			txt = new TextField();
			txt.selectable = false;
//			txt.embedFonts = true;
			txt.wordWrap = true;
			txt.width = _w;
			
			var txtFormat:TextFormat = new TextFormat();
			txtFormat.size = fontSize;
			txtFormat.color = _color;
			txtFormat.indent = _indent;
//			txtFormat.font = "Berlin Sans FB Demi";
			txtFormat.leading = _lead;
			txtFormat.letterSpacing = _ltspace;
			txt.defaultTextFormat = txtFormat;
			this.addChild(txt);
			addPics();
			
			this.addEventListener(MouseEvent.MOUSE_DOWN,startDragHandler);
			this.addEventListener(MouseEvent.MOUSE_UP,stopHandler);
		}
		private function startDragHandler(event:Event):void
		{
			
		}
		private function stopHandler(event:MouseEvent):void
		{
			
		}
		private var i:uint;
		private var loader:CLoader;
		private function addPics():void
		{
			for(i=0;i<2;i++)
			{
				loader = new CLoader;
				loader.load("source/data/sichuan/source/pictures/zoomin.png");
				loader.addEventListener(CLoader.LOADE_COMPLETE,addOkPic);
			}
		}
		private function addOkPic(event:Event):void
		{
			loader._loader.x = 10;
			this.addChild(loader._loader);
		}
		private var _htmlTxt:String;

		public function get htmlTxt():String
		{
			return _htmlTxt;
		}
		private var str:String="";

		public function set htmlTxt(value:String):void
		{
			_htmlTxt = value;
			str = value;
			trace(str.replace(myPattern,"		"));
			txt.htmlText = str.replace(myPattern,"		");
			txt.height = txt.textHeight+txt.textHeight/txt.numLines;
//			searchPick();
		}
		private var count:int;
		private var myPattern:RegExp =/@/g;
		private function searchPick():void
		{
			trace("===@ indexxxxx====",txt.getLineIndexOfChar(str.indexOf("@")),str.indexOf("@"));
			
			trace("==new str===",str.slice(str.indexOf("@")+1))
			str= str.slice(str.indexOf("@")+1);
			trace("------///////////////");
			trace("===@ indexxxxx====",txt.getLineIndexOfChar(str.indexOf("@")),str.indexOf("@"));
			trace("==new str===",str.slice(str.indexOf("@")+1));
//			trace("=======search====");
			var s:String = str;
			var index:int;
			var tst:int;
			while(s.indexOf("@")!=-1)
			{
				count++;
				index = s.indexOf("@");
				s = s.slice(s.indexOf("@")+1);
				trace("====ss===",s);
				tst = txt.getLineIndexOfChar(tst+s.indexOf("@"));
					trace("===line===",tst);
			}
			
			txt.htmlText = str.replace(myPattern,"		");
		
			trace("===count===",count,str.replace(myPattern,"		"));
		}

	}
}