package core.layout
{
	import flash.display.DisplayObject;

	public class PictureZoom
	{
		public function PictureZoom()
		{
		}
		/**
		 *等比例拉伸 
		 * @param obj
		 * @param _ww
		 * @param _hh
		 * 
		 */		
		public static function strench(obj:DisplayObject,_ww:int,_hh:int):void
		{
			if(obj.width * 1.0 / obj.height > _ww * 1.0 / _hh)
			{
				if (obj.width > _ww) 
				{
					obj.height = int(obj.height * _ww * 1.0 / obj.width);
					obj.width = int(_ww);
				}
			}else{
				if (obj.height > _hh) 
				{
					obj.width = int(_hh * obj.width * 1.0 / obj.height);
					obj.height = int(_hh);
				}
			}
			obj.x = (_ww - obj.width) / 2;
			obj.y = (_hh - obj.height) / 2;
		}
	}
}