package core.baseComponent
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import core.loadEvents.CLoaderMany;
	
	public class CCScrollBar extends Sprite
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
		public function CCScrollBar(_maskwidth:int,_maskheight:int,barSrcUrls:Array = null)
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
			
			dragMask = new Sprite();
			dragMask.graphics.beginFill(0xaacc00,0);
			dragMask.graphics.drawRect(0,0,_maskwidth,_maskheight);
			dragMask.graphics.endFill();
			dragMask.visible = false;
			
			if(barSrcUrls)
			{
				isShowBar = false;
				loader = new CLoaderMany;
				loader.load(barSrcUrls);
				loader.addEventListener(CLoaderMany.LOADE_COMPLETE,bgOkHandler);
			}
//			this.addEventListener(MouseEvent.MOUSE_DOWN,startdragHandler);
//			this.addEventListener(MouseEvent.MOUSE_UP,stopdragHandler);
		}
		private var dragMask:Sprite;
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
			loader._loaderContent[0].x = -4;
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
			
			if(!hasAddMove && Math.sqrt((this.mouseX - mouse_beginX)*(this.mouseX - mouse_beginX) + (this.mouseY - mouse_beginY)*(this.mouseY - mouse_beginY)) >= standar_dis)
			{
				_target.addEventListener(MouseEvent.MOUSE_MOVE,moveOntargetHandler);
				hasAddMove = true;
			}
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
//			_target.addEventListener(MouseEvent.MOUSE_OUT,stopdragHandler);
			this.addChild(_target);
			this.addChild(dragMask);
			_target.mask = shape;
			
			this.x =_target.x;
			this.y = _target.y;
			objX = _target.x;
			objY = _target.y;
		}
		private var mouse_beginX:int = 0;
		private var mouse_beginY:int = 0;
		private var standar_dis:int = 10;
		private var hasAddMove:Boolean;
		private function startdragHandler(event:MouseEvent):void
		{
			mouse_beginX = this.mouseX;
			mouse_beginY = this.mouseY;
			var yy:Number = (-_target.height+maskHeight)<0?(-_target.height+maskHeight):0;
			_target.startDrag(false,new Rectangle(objX,yy+objY,0,(_target.height-maskHeight)<0?0:(_target.height-maskHeight)));
//			var yy:Number = (-_target.height+maskHeight)<0?(-_target.height+maskHeight) - 40:0;
//			_target.startDrag(false,new Rectangle(objX,yy+objY,0,(_target.height-maskHeight + 40)<0?0:(_target.height-maskHeight + 40)));
			
			this.addEventListener(Event.ENTER_FRAME,updateSlider);
			
//			_target.addEventListener(MouseEvent.MOUSE_MOVE,moveOntargetHandler);
		}
		private function moveOntargetHandler(event:MouseEvent):void
		{
			_target.mouseChildren = _target.mouseEnabled = false;
			dragMask.addEventListener(MouseEvent.MOUSE_UP,stopdragHandler);
			dragMask.addEventListener(MouseEvent.MOUSE_OUT,stopdragHandler);
			dragMask.visible = true;
		}
		private function stopdragHandler(event:MouseEvent):void
		{
			_target.stopDrag();
			this.removeEventListener(Event.ENTER_FRAME,updateSlider);
			if(hasAddMove)
			{
				_target.removeEventListener(MouseEvent.MOUSE_MOVE,moveOntargetHandler);
				dragMask.removeEventListener(MouseEvent.MOUSE_UP,stopdragHandler);
				dragMask.removeEventListener(MouseEvent.MOUSE_OUT,stopdragHandler);
			}
			dragMask.visible = false;
			hasAddMove = false;
			_target.mouseChildren = _target.mouseEnabled = true;
		}
		public function changeScrollBarState(_isShow:Boolean):void
		{
			barSprite.visible = _isShow;
		}
		public function reset():void
		{
			sliderSprite.y = _target.y = 0;
		}
	}
}

