package core.date
{
	public class CDate
	{
		
		public function CDate()
		{
		}
		/**
		 *返回当前时间 2012-5-22  17:55 
		 * @return 
		 * 
		 */		
		public static function getTime():String
		{
			var date:Date = new Date();
			return date.getFullYear()+"-"+(date.getMonth()%12+1)+"-"+date.getDate()+"	"+date.getHours()+":"+date.getMinutes();
		}
//		public static function 
	}
}