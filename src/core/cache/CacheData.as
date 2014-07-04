package core.cache
{
	import flash.utils.Dictionary;

	public class CacheData
	{
		private static var guideDic:Dictionary = new Dictionary();
		public function CacheData()
		{
		}
		public static function getDataByName(name:String):*
		{
			for(var str:String in guideDic)
			{
				if(str == name)
				{
					return guideDic[name];
				}
			}
			return null;
		}
		public static function setDataByName(data:*,name:String):void
		{
			guideDic[name] = data;
		}
	}
}