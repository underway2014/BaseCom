package core.timer
{
	import core.constant.Const;

	public class TimerDevice
	{
		public function TimerDevice()
		{
		}
		/**
		 *最后一次操作时间 
		 */		
		public static var LAST_TIME:Date;
//		public static var SPACE_TIME:int;
		/**
		 *清零 
		 * 
		 */		
		public static function resetTime():void
		{
			LAST_TIME = new Date();
//			trace("^^^^",LAST_TIME.getTime());
		}
		/**
		 *检查是否很久无人操作应该自动返回了 
		 * @return 
		 * 
		 */		
		public static function check(longtime:int = Const.TOTAL_BACK_TIME):Boolean
		{
			var d:Date = new Date();
			if(!LAST_TIME)
			{
				LAST_TIME = new Date();
			}
//			trace("LAST_TIME.getTime()-d.getTime() = ",LAST_TIME.getTime(),LAST_TIME.getTime()-d.getTime());
			if(Math.abs(LAST_TIME.getTime()-d.getTime())>longtime)
			{
//				resetTime();
				return true;
			}
			return false;
		}
		/**
		 *检查是否可播放全屏广告 
		 * @return 
		 * 
		 */		
		public static function getSpaceTime():Boolean
		{
			var d:Date = new Date();
			if(!LAST_TIME)
			{
				LAST_TIME = new Date();
			}
			if(Math.abs(LAST_TIME.getTime()-d.getTime())>Const.BEGIN_PLAY_TIME)
			{
				return true;
			}
			return false;
		}
	}
}