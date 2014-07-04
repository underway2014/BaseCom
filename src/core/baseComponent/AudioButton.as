package core.baseComponent
{
	import flash.text.TextField;
	
	import core.fontFormat.CFontFormat;

	public class AudioButton extends CButton
	{
		private var _text:String;
		public var upY:Number;
		public var downY:Number;
		private var _direct:Boolean;// = 0,up !0 down
		public function AudioButton(arg:Array, centerZoom:Boolean=true, isSelect:Boolean=true, _isStateChange:Boolean=false)
		{
			super(arg, centerZoom, isSelect, _isStateChange);
//			addText();
		}
		private var nameTextField:TextField;
		private function addText():void
		{
			nameTextField = new TextField();
			nameTextField.mouseEnabled = false;
			nameTextField.wordWrap = true;
			nameTextField.multiline = true;
			nameTextField.width = 110;
			nameTextField.x = -nameTextField.width / 2;
			nameTextField.setTextFormat(CFontFormat.formatAudioText);
//			nameTextField.y = -55 - nameTextField.textHeight;
			
			addChild(nameTextField);
		}
		public function rotationAllChilde(_angle:Number):void
		{
			
		}

		public function get text():String
		{
			return _text;
		}

		public function set text(value:String):void
		{
			_text = value;
			nameTextField.text = _text;
			nameTextField.height = nameTextField.textHeight;
			if(_direct)
			{
				nameTextField.y = 55;
			}else{
				nameTextField.y = - nameTextField.height - 55;
			}
		}
		public function get direct():Boolean
		{
			return _direct;
		}

		public function set direct(value:Boolean):void
		{
			_direct = value;
		}
	}

}