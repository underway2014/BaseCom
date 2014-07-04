package core.memefree
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	/**
	 *垃圾强制回改 
	 * @author bin.li
	 * 
	 */	
	public class Memory 
	{
		
		
		private static var swfHex:Array = [0x46, 0x57, 0x53, 0x09, 0x24, 0x00, 0x00, 0x00, 0x78, 0x00, 0x05, 0x5f, 0x00, 0x00, 0x0f, 0xa0,
			0x00,0x00,0x0c,0x01,0x00,0x44,0x11,0x08,0x00,0x00,0x00,0x43,0x02,0xff,0xff,0xff,0x40,0x00,0x00,0x00]
		
		private static var _gcing:Boolean;
		private static var _loader:Loader = new Loader;
		private static var _swfBytes:ByteArray = new ByteArray;
		_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, __onComplete);
		
		public static function gc():void {
			
			if(!_gcing){
				
				_gcing = true;
				
				_loader.loadBytes(swfBytes);
				
			}
			
		}
		private static function get swfBytes():ByteArray{
			
			while (swfHex.length) {
				
				_swfBytes.writeByte(swfHex.shift());
				
			}
			
			return _swfBytes;        
		}
		private static function __onComplete(e:Event):void {
			
			_loader.unloadAndStop();
			_gcing = false;
			
		}
		
	}
	
}



