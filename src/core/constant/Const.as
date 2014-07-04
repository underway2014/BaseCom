package core.constant
{
	/**
	 *存放各种常量
	 * @author bin.li
	 * 
	 */	
	public class Const
	{
		public function Const()
		{
		}
		/**
		 * 所有资源的根目录
		 */
		public static const ROOT_URL:String = "";
		
		/**
		 *下方，上方地址根目录 
		 */		
		public static const PIC_BOTTOM_WIDTH:int = 180;	//广告图片宽度
		public static const PIC_BOTTOM_HEIGHT:int = 82;
		
		/**
		 * 字母查询页面显示类型
		 */
		public static const RECOMMEND:String = "scenic_recommend";
		public static const SEARCH:String = "letter_search";
		public static const LETTERS:String = "abcdefghijklmnopqrstuvwxyz";
		
		/**
		 * 景点查询类型---线路、地图
		 */
		public static const MAP:String = "map";
		public static const ROUTE:String = "route";
		
		/**
		 *间隔检测时间 
		 */		
		public static const CHECK_TIME:int = 1000*30;
		/**
		 *无人操作返回时间 (全攻略类型时间较长)云南的有个视频时间较长
		 */		
		public static const TOTAL_BACK_LONG_TIME:int = 1000*60*8;
		
		/**
		 *无人操作返回时间 (全攻略类型时间较长)
		 */		
		public static const TOTAL_BACK_TIME:int = 1000*60*6;
		/**
		 *无人操作较短返回时间 
		 */		
		public static const TOTAL_BACK_SHORT_TIME:int = 1000*60*5;
	
		
		/**
		 *所有广告ID存放的共享对象NAME 
		 */		
		public static const ALL_ADVERTISE_ID:String = "alladvertiseid";
		
		/**
		 *多长时间播放一次全屏广告
		 */		
		public static const FULLSCREEN_ADVERTISE_TIME:int = 1000*60*0.8;
		/**
		 *当多久无人操作时放一次全屏广告 
		 */		
		public static const BEGIN_PLAY_TIME:int = 1000*60*0.2;
		/**
		 *全屏广告播放持续时间 
		 */		
		public static const PLAYING_TIME:int = 1000*60*0.5;
		
		/**
		 *屏幕分屏size
		 */
		public static const SCREEN_WIDTH:int = 1080;
		public static const TOP_HEIGHT:int = 1056;
		public static const MIDDLE_HEIGHT:int = 608;
		
		/**
		 *模块名 
		 */		
		public static const MAP_MODULE:String = "map_module";
		public static const ROUTE_MODULE:String = "route_module";
		public static const AROUND_MODULE:String = "around_module";
		
		/**
		 *zh 地图站点颜色
		 */		
		public static const colorArray:Array = [0xed4f11,0xf27e18,0xefc814,0xbadc0a,0x0cd115,0x10b7d6,0x1173c7,0x021cda,0x6120e6,0x8a01e2,0xfb02e1,0xe63862,0xe74a0e,0xf37f1b,0xe9c313,0xb2d108,0xcca14,0x11c0da,0x0f6dbd,0x0017c1];//17
		public static const otherColor:int = 0x555454;
	}
}