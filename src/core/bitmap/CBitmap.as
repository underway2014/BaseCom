package core.bitmap
{
	import com.hurlant.crypto.hash.SHA1;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Shape;

	public class CBitmap
	{
		public function CBitmap()
		{
		}
		public static function getBitmap(png_mc:*):Shape
		{
			var bitmapData:BitmapData=new BitmapData(png_mc.width,png_mc.height,true,0x000000);   
			bitmapData.draw(png_mc);   
			
			//重绘图象到bitmapData    
			//png_mc.graphics.beginFill(0,1);   
			var shape:Shape = new Shape();
			shape.graphics.beginBitmapFill(bitmapData);   
			var _width:Number = bitmapData.width;   
			var _height:Number = bitmapData.height;   
			for (var i:uint=0; i<_width; i++)    
			{   
				for (var j:uint=0; j<_height; j++)    
				{   
					if (bitmapData.getPixel32(i,j))    
					{   
						shape.graphics.drawRect(i,j,1,1);   
					}   
				}   
			}   
			
			shape.graphics.endFill();   
//			png_mc.removeChildAt(0);   
			return shape;
		}
	}
}