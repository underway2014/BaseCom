package core.loadEvents
{
	/**
	 *统一存放各种事件 
	 * @author bin.li
	 * 
	 */
	public class Cevent
	{
		public function Cevent()
		{
		}
		public static const SELECT_CHANGE:String = "selectchange";//选择变化
		public static const CURRENT_PAGE_CHANGE:String = "currentpagechange";//当前页码变化
		public static const TOTAL_PAGE_CHANGE:String = "totalpagechange";//总页码发生变化
		public static const REMOVED_DISPLAYOBJECT:String = "removedobject";//移除显示对象
		
		public static const PLAY_DOWN_ADVERTISE:String = "playadvertise";	//播放下方广告
		
		public static const VIDEO_SOUND_CLOSE:String = "videosoundclose";	//视频关闭声音
		public static const VIDEO_SOUND_OPEN:String = "videosoundopen";	//声音开启
		
		/**
		 *蝶片飞出，返回时事件 
		 */		
		public static const DISK_OUT_FIRSTEP_OVER:String = "diskoutoneover";
		public static const DISK_OUT_SECSTEP_OVER:String = "diskoutsecover";
		public static const DISK_BACK_FIRSTEP_OVER:String = "diskbacksecover";
		public static const DISK_BACK_SECSTEP_OVER:String = "diskbackoneover";
		
		/**
		 *清空DM，或全攻略内容
		 *  
		 */		
		public static const CLEAR_DM_QGL:String = "cleardmorqgl";
		
		/**
		 *景区全攻略
		 */	
		public static const MAP_PAGE_BACK:String = "mapPageBack";
		public static const SCENIC_PAGE_BACK:String = "scenciPageClick";
			
		/**
		 *xml文件加载
		 */	
		public static const XML_LOAD_COMPLETE:String = "xmlLoadComplete";	
		
		/**
		 *swf内部资源加载完成 (包含首页图片）
		 */	
		public static const INSIDESOURCE_LOAD_COMPLETE:String = "insidesource_loadcomplete";
		
		/**
		 *和服务器通信成功 
		 */		
		public static const SOCKET_SUCCESS:String = "socket_success";
		public static const SOCKET_ERROR:String = "socket_error";
	}
}