package core.baseComponent
{
	import core.loadEvents.CLoaderMany;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	public class CScrollBar extends Sprite
	{
		//BAR 滑动槽，滑动块图片地址

		private var loader:CLoaderMany;
		private var _target:Sprite;
		
		private var maskWidht:int;
		private var maskHeight:int;
		private var objX:int;
		private var objY:int;
		
		private var barSprite:Sprite = new Sprite;
		
		private var sliderSprite:Sprite = new Sprite;
		private var shape:Shape;
		
		private var isShowBar:Boolean = true;
		/**
		 * 
		 * @param _maskwidth  遮罩宽，高
		 * @param _maskheight
		 * 
		 */		
		public function CScrollBar(_maskwidth:int,_maskheight:int,barSrcUrls:Array = null)
		{
			//,_objx:int=0,_objy:int=0
			super();
			maskWidht = _maskwidth;
			maskHeight = _maskheight;
			
			this.addChild(barSprite);
			barSprite.x = maskWidht;
			
			shape = new Shape();
			shape.graphics.beginFill(0xaacc00);
			shape.graphics.drawRect(0,0,maskWidht,maskHeight);
			shape.graphics.endFill();
			this.addChild(shape);
			
			if(barSrcUrls)
			{
				isShowBar = false;
				loader = new CLoaderMany;
				loader.load(barSrcUrls);
				loader.addEventListener(CLoaderMany.LOADE_COMPLETE,bgOkHandler);
			}
		}
		/**
		 *滑块拖动 
		 * @param event
		 * 
		 */		
		private function barStartDragHandler(event:MouseEvent):void
		{
			trace("slider start drag..",barSprite.height);
			sliderSprite.startDrag(false,new Rectangle(0,0,0,barSprite.height-sliderSprite.height));
			addEventListener(Event.ENTER_FRAME,updateContent);
		}
		private function barStopDragHandler(event:MouseEvent):void
		{
			sliderSprite.stopDrag();
			removeEventListener(Event.ENTER_FRAME,updateContent);
		}
		private var barslider:DisplayObjectContainer;
		private function bgOkHandler(event:Event):void
		{
			loader._loaderContent[1].height = maskHeight;
			barSprite.addChild(loader._loaderContent[1]);
			sliderSprite.addChild(loader._loaderContent[0]);
			loader._loaderContent[0].x = 3;
			barSprite.addChild(sliderSprite);
			sliderSprite.addEventListener(MouseEvent.MOUSE_DOWN,barStartDragHandler);
			sliderSprite.addEventListener(MouseEvent.MOUSE_UP,barStopDragHandler);
			sliderSprite.addEventListener(MouseEvent.MOUSE_OUT,barStopDragHandler);
			//			barslider = loader._loaderContent[0];
		}
		
		/**
		 *更新滑块位置 
		 * @param event
		 * 
		 */		
		public function updateSlider(event:Event):void
		{
			//			
			//			barslider.y = Math.abs(_target.y-objY)/(_target.height-maskHeight)*(maskHeight-barslider.height);
			sliderSprite.y = Math.abs(_target.y-objY)/(_target.height-maskHeight)*(maskHeight-sliderSprite.height);
			
			
		}
		private function updateContent(event:Event):void
		{
			trace("==sliderSprite==",sliderSprite.y);
			_target.y = -sliderSprite.y/(barSprite.height-sliderSprite.height)*(_target.height-maskHeight)+objY;
		}
		public function get target():Sprite
		{
			return _target;
		}
		
		public function set target(value:Sprite):void
		{
			_target = value;
			_target.addEventListener(MouseEvent.MOUSE_DOWN,startdragHandler);
			_target.addEventListener(MouseEvent.MOUSE_UP,stopdragHandler);
			_target.addEventListener(MouseEvent.MOUSE_OUT,stopdragHandler);
			
			_target.mask = shape;
			
			this.x =_target.x;
			this.y = _target.y;
			objX = _target.x;
			objY = _target.y;
		}
		private function startdragHandler(event:MouseEvent):void
		{
			trace("==content drag..new ==");
			var yy:Number = (-_target.height+maskHeight)<0?(-_target.height+maskHeight):0;
			_target.startDrag(false,new Rectangle(objX,yy+objY,0,(_target.height-maskHeight)<0?0:(_target.height-maskHeight)));
//			if(isShowBar)
			addEventListener(Event.ENTER_FRAME,updateSlider);
		}
		private function stopdragHandler(event:MouseEvent):void
		{
			_target.stopDrag();
			removeEventListener(Event.ENTER_FRAME,updateSlider);
		}
		
	}
}