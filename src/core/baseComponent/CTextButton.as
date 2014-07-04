package core.baseComponent
{
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	

	public class CTextButton extends CButton
	{
		private var _text:String;
		public var brotherNum:uint = 0;
		public var storeWidth:int;
		public function CTextButton(arg:Array, centerZoom:Boolean=true, isSelect:Boolean=true, _isStateChange:Boolean=false)
		{
			super(arg, centerZoom, isSelect, _isStateChange);
		}

		public function get text():String
		{
			return _text;
		}

		private var _txt:TextField;
		public function set text(value:String):void
		{
			_text = value;
			txt = new TextField();
			txt.mouseEnabled = false;
			txt.y = 9;
			var txtFormat:TextFormat = new TextFormat(null,14,0xffffff,true,null,null,null,null,TextFormatAlign.CENTER);
			txt.text = value;
			txt.setTextFormat(txtFormat);
			if(brotherNum == 2)
			{
				txt.width = 220;
			}else if(brotherNum == 8)
			{
//				txt.width = 104;
				txt.width = (_text.length + 2) * 14 < 120 ? 120 : (_text.length + 2) * 14;
			}
			else
			{
				txt.width = 147;
			}
			addChild(txt);
		}

		public function get txt():TextField
		{
			return _txt;
		}

		public function set txt(value:TextField):void
		{
			_txt = value;
		}


	}
}