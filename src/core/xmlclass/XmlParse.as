package core.xmlclass
{
	
	import flash.net.getClassByAlias;
	import flash.net.registerClassAlias;
	import flash.utils.getDefinitionByName;
	/**
	 *解析XM 
	 * @author Administrator
	 * 
	 */
	public class XmlParse
	{
		public function XmlParse()
		{
		}
		private static const SAMPLE:String = "sample";
		private static const CLASS:String = "class";
		public static function parse(node:XML):Object
		{
			var o:Object = null;
			var c:Class;
			if(node.name()==SAMPLE)
			{
//				registerClassAlias(
//				trace("===node.attribute(CLASS)===",node.attribute(CLASS));
				c = getDefinitionByName(node.attribute(CLASS)) as Class;
				o = new c();
			}
			trace("00000====",node);
			trace("1111======",node.name(),node.children());
			for each(var x:XML in node.attributes())
			{
				trace("xxxxxxxx==",x.name(),x);
				if(x.name() == CLASS)
					continue;
				o[String(x.name())] = x;
			}
			for each(var m:XML in node.children())
			{
//				trace(m.name());
//				trace(node[m.name()]);
				o[String(m.name())] = node[m.name()];
			}
			return o;
		}
	}
}