package core.baseComponent
{
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import core.interfaces.SelectItem;
	import core.loadEvents.CLoaderMany;
	
	public class CButton extends Sprite implements SelectItem
	{
		private var urlArr:Array = new Array();
		private var loader:CLoaderMany;
		private var _txtX:Number=0;//控制按钮内的文字图片坐标
		private var _txtY:Number=0;
		public var data:*;//存放按钮数据
		private var centerZoom:Boolean = true;
		private var isStateChange:Boolean;	//是否支持各种状态间切换
		private var _bgWidth:int;
		/**
		 * 
		 * @param arg 按钮皮肤地址//正常，点击，按钮上的文字图片
		 * 
		 */		
		public function CButton(arg:Array, centerZoom:Boolean = true, isSelect:Boolean = true,_isStateChange:Boolean = false)
		{
			super();
			urlArr = arg;
			isStateChange = _isStateChange;
			this.centerZoom = centerZoom;
			currentState = normalState;
			this.addChild(normalState);
			this.addChild(clickState);
			//有时只需要两张图片
			if(arg.length>2)
			{
				this.addChild(txtSprite);
			}
			clickState.visible = false;
			
			trace("====urlArr==urlArrnnn==",urlArr);
			loader = new CLoaderMany();
			loader.load(urlArr);
			loader.addEventListener(CLoaderMany.LOADE_COMPLETE,loadOkHandler);
			
//			this.addEventListener(MouseEvent.MOUSE_OVER,overHandler);
			if(isSelect)
			{
				if(urlArr.length>1)
				this.addEventListener(MouseEvent.CLICK,clickHandler);
				this.addEventListener(MouseEvent.MOUSE_OUT,outHandler);
			}
			else
			{
				this.addEventListener(MouseEvent.MOUSE_DOWN,clickHandler);
				this.addEventListener(MouseEvent.MOUSE_UP,upHandler);
			}
			this.buttonMode = true;
			
		}
		private var currentState:Sprite;
		private var normalState:Sprite=new Sprite;
		private var downState:Sprite = new Sprite();
		private var overState:Sprite=new Sprite;
		private var clickState:Sprite = new Sprite;
		private var txtSprite:Sprite = new Sprite;
		private var i:int;
		private function loadOkHandler(event:Event):void
		{
			i=0;
			try
			{
				normalState.addChild(loader._loaderContent[i]);
				i++;
				if(urlArr.length>i)
				{
					clickState.addChild(loader._loaderContent[i]);
				}
				
				i++;
				if(i<urlArr.length)
					txtSprite.addChild(loader._loaderContent[i]);
				
				if (centerZoom)
				{
					i = 0;
					loader._loaderContent[i].x = -loader._loaderContent[i].width/2;
					loader._loaderContent[i].y = -loader._loaderContent[i].height/2;
					
					i++;
					if(urlArr.length>i)
					{
						loader._loaderContent[i].x = -loader._loaderContent[i].width/2;
						loader._loaderContent[i].y = -loader._loaderContent[i].height/2;
					}
					
					i++;
					if(i<urlArr.length)
					{
						loader._loaderContent[i].x = -loader._loaderContent[i].width/2;
						loader._loaderContent[i].y = -loader._loaderContent[i].height/2;
					}
				}
				dispatchEvent(new Event("buttonOK"));
			}
			catch(er:Error)
			{
				throw new Error("加载的图片路径个数不对！");
			}
		}
		private function overHandler(event:Event):void
		{
			trace("over===");
			if(currentState!=overState)
			{
				currentState.visible = false;
				currentState = overState;
				currentState.visible = true;
			}
		}
		private function outHandler(event:MouseEvent):void
		{
			if(currentState!=normalState&&currentState!=clickState)
			{
				currentState.visible = false;
				currentState = normalState;
				currentState.visible = true;
			}
		}
		private function downHandler(event:MouseEvent):void
		{
			if(currentState!=clickState)
			{
				currentState.visible = false;
				currentState = downState;
				currentState.visible = true;
			}
		}
		private function upHandler(event:MouseEvent):void
		{
			if(currentState != normalState)
			{
				currentState.visible = false;
				currentState = normalState;
				currentState.visible = true;
			}
		}
		private function clickHandler(event:MouseEvent):void
		{
			if(currentState!=clickState)
			{
				currentState.visible = false;
				currentState = clickState;
				currentState.visible = true;
			}
			else if(isStateChange)
			{
				currentState.visible = false;
				currentState = normalState;
				currentState.visible = true;
			}
		}
		public function select(b:Boolean):void
		{
			if(b)
			{
				clickHandler(null);
			}
			else
			{
				if(currentState!=normalState)
				{
					currentState.visible = false;
					currentState = normalState;
					currentState.visible = true;
				}
			}
		}
		public function move(b:Boolean):void
		{
			
		}

		public function get txtX():Number
		{
			return _txtX;
		}

		public function set txtX(value:Number):void
		{
			_txtX = value;
			txtSprite.x = _txtX;
		}

		public function get txtY():Number
		{
			return _txtY;
		}

		public function set txtY(value:Number):void
		{
			_txtY = value;
			txtSprite.y = _txtY;
		}

		public function get bgWidth():int
		{
			return _bgWidth;
		}

		public function set bgWidth(value:int):void
		{
			_bgWidth = value;
			for each(var obj:Loader in loader._loaderContent)
			{
				obj.width = _bgWidth;
			}
		}


	}
}