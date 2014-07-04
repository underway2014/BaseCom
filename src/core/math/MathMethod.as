package core.math
{
	/**
	 * 
	 * @author bin.li
	 * 
	 */	
	public class MathMethod
	{
		
		public function MathMethod()
		{
		}
		/**
		 * 产生一个最大值小于_n的数组，且不重复T
		 * @param _n
		 * @return 
		 * 
		 */		
		public static function randomArr(_n:int):Array
		{
			var a:Array = [];
			for(var i:int=0;i<_n;i++)
			{
				a.push(i);
			}
			var b:Array = [];
			while(b.length!=_n)
			{
				var r:int =a.splice(Math.floor((Math.random()*a.length)),1);
				b.push(r);
			}
			return b;
		}
		/**
		 *将一个一维数组切分成一个二维数组 
		 * @param _a
		 * @param _n	切几刀
		 * @return 
		 * 
		 */		
		public static function sliceArr(_a:Array,_n:int):Array
		{
			var n:int = Math.floor(_a.length/_n);
			var b:Array = [];
			for(var i:int=0;i<_n+1;i++)
			{
				var a:Array = [];
				for(var j:int=i*n;j<(i+1)*n;j++)
				{
					if(j>_a.length-1)
					{
						break;
					}
					a.push(_a[j]);
				}
				if(a.length)
				{
					b.push(a);
				}
			}
			return b;
		}
	}
}