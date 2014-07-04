package core.baseComponent
{
	import flash.display.Shape;

	public class CCImage extends CImage
	{
		public function CCImage(_ww:int, _hh:int, _keepProportion:Boolean=true)
		{
			super(_ww, _hh, _keepProportion);
			
			var shape:Shape = new Shape();
			shape.graphics.beginFill(0xaa0000);
			shape.graphics.drawRoundRect(0,0,_ww,_hh,15,15);
			shape.graphics.endFill();
			this.addChild(shape);
			this.mask = shape;
		}
	}
}