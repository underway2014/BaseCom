package core.string
{
	import flash.geom.Point;

	/**
	 *数组，字符串常用方法 
	 * @author bin.li
	 * 
	 */	
	public class StringSlice
	{
		public function StringSlice()
		{
		}
		/**
		 * 返回书内容文本
		 * @param _str
		 * @param _m1	分面(含两页)
		 * @param _m2	分页
		 * @param _m3	
		 * @return 
		 * 
		 */		
		public static function split(_str:String,_m1:String = "@",_m2:String = "$",_m3:String = "%"):Array
		{
			var a:Array = _str.split(_m1);
			var b:Array = [];
			for each(var s:String in a)
			{
				if(s.search(_m2) != -1)
				{
					b.push(s.split(_m2));
				}
				else//只有一块文本（）；
				{
					b.push([s]);
				}
			}
			return b;
		}
		/**
		 *返回坐标数组  
		 * @param _str
		 * @param _m1	分面(含两页)
		 * @param _m2	分页
		 * @param _m3	
		 * @return 
		 * 
		 */			
		public static function getPointArr(_str:String,_m1:String = "$",_m2:String = "@",_m3:String = ","):Vector.<Point>
		{
			var a:Array = _str.split(_m1);
			var b:Array = [];	//XY坐标，还是字符串
			var c:Vector.<Point>;	//含G一个或两个NEW POINT（）
			var combin:Vector.<Point> = new Vector.<Point>;
			for each(var s:String in a)
			{
//				for each(var s1:String in s.split(_m2))
//				{
					b = s.split(_m2);
					combin.push(new Point(b[0],b[1]));
//				}
			}
			
			return combin;	//[[new Point(),new Point()],[new Point(),new Point()],]
			
		}
		/**
		 * 将数组中每项前插OR后接一个安符串
		 * @param _arr	//待处理数组
		 * @param _str	//待添加字符
		 * @param _type 1：二维数组，非1：一维数组
		 * @param _dir	//前插OR后接
		 * @return 
		 * 
		 */		
		public static function addString(_arr:Array,_str:String,_type:int = 1,_dir:int = 1):Array
		{
			var j:int = 0;
			var i:int = 0;
			if(_type==1)
			{
				for each(var s:Array in _arr)
				{
					j = 0;
					for each(var ss:String in s)
					{
						_arr[i][j] = _str + _arr[i][j];
						j++;
					}
					i++;
				}
			}
			else
			{
				for each(var str:String in _arr)
				{
					_arr[i] = _str + _arr[i];
					i++;
				}
			}
			return _arr;
		}
		/**
		 *合合两个或两个以上数组 
		 * @param arr1
		 * @param arr2
		 * @param arg
		 * @return 
		 * 
		 */		
		public static function combinArr(arr1:Array,arr2:Array,...arg):Array
		{
			var arr:Array = [];
			for each(var d:* in arr1)
			{
				arr.push(d);
			}
			for each(var dt:* in arr2)
			{
				arr.push(dt);
			}
			if(arg.length)
			{
				for each(var a:Array in arg)
				{
					for each(var dd:* in a)
					{
						arr.push(dd);
					}
				}
			}
			return arr;
		}
		
		
		public static function checkPosition(_str:String):int
		{
			return 1;
		}
	}
}