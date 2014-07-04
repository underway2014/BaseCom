package core.filter
{
	import flash.filters.ColorMatrixFilter;
	import flash.filters.GlowFilter;

	public class CFilter
	{
		public function CFilter()
		{
		}
		//,
		public static var glowFilter:Array = [new GlowFilter(0x33CCFF,1,16,16,2,1),new GlowFilter(0xAACC00,1,16,16,2,1)];
		public static var blueYellowFilter:Array = [new GlowFilter(0xffffff,0.75,20,20,2,1,false,false),new GlowFilter(0xdfab2,1,5,5,2,1,true)];//,new GlowFilter(182245252,1,10,110,2,1,true)
		public static var grayFilter:Array = [new ColorMatrixFilter([0.3,0.6,0,0,0,0.3,0.6,0,0,0,0.3,0.6,0,0,0,0,0,0,1,0])];
		public static var whiteFilter:Array = [new GlowFilter(0xffffff,1,4,4,8)];
	}
}