package core.baseComponent
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import core.interfaces.SelectItem;
	
	public class TextButton extends Sprite implements SelectItem
	{
		private var normalSatae:Sprite = new Sprite();
		private var downState:Sprite = new Sprite();
		private var _twidth:int;
		private var _theight:int;
		private var ww:int;
		private var txt:TextField;
		public var data:*;
		public function TextButton(_name:String,_txtSize:uint = 20)
		{
			super();
			addChild(downState);
			addChild(normalSatae);
			txt = new TextField();
			txt.height = 30;
			var txtFormat:TextFormat = new TextFormat(null,_txtSize,0xccfaaf,true);
			txt.setTextFormat(txtFormat);
			txt.text = _name;
			addChild(txt);
			ww = txt.textWidth;
			_twidth = ww;
			
		}
		public function select(b:Boolean):void
		{
			downState.visible = b;
			normalSatae.visible = !b;
		}
		public function move(b:Boolean):void
		{
			
		}

		public function get twidth():int
		{
			return _twidth;
		}

		public function set twidth(value:int):void
		{
			_twidth = value;
			txt.x = (_twidth - ww) / 2;
		}

		public function get theight():int
		{
			return _theight;
		}

		public function set theight(value:int):void
		{
			_theight = value;
			downState.graphics.clear();
			downState.graphics.beginFill(0xaa0000);
			downState.graphics.drawRect(0,0,_twidth,theight);
			downState.graphics.endFill();
			normalSatae.graphics.clear();
			normalSatae.graphics.beginFill(0xaacc00);
			normalSatae.graphics.drawRect(0,0,_twidth,theight);
			normalSatae.graphics.endFill();
		}


	}
}