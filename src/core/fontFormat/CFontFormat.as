package core.fontFormat
{
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;

	public class CFontFormat
	{
		public function CFontFormat()
		{
		}
		private static const LEADING_LINE:int = 2;
		private static const LETTER_SPACE:int = 2;
		public static var formatSpotName:TextFormat = new TextFormat(null,40,0x2576bb,true,null,null,null,null,TextFormatAlign.CENTER);
		public static var formatTitle:TextFormat = new TextFormat(null,20,0x5b5b5b,true);
		
		public static var formatAuthor:TextFormat = new TextFormat(null,17,0xc22900);
		public static var formatRouteGuideSite:TextFormat = new TextFormat(null,20,0x1e1e1e,true);
		public static var formatAudioText:TextFormat = new TextFormat(null,15,0xffffff,true,null,null,null,null,TextFormatAlign.CENTER,null,null,null,-5);//
		public static var formatAudioCenterName:TextFormat = new TextFormat(null,20,0xaa0000,true,null,null,null,null,TextFormatAlign.CENTER);//播放MUSIC spot name
		public static var formatVisitDetailTitle:TextFormat = new TextFormat(null,22,0xffffff,true,null,null,null,null);// 推荐线路详情Title
		public static var formatPageText:TextFormat = new TextFormat(null,20,0,null,null,null,null,null,TextFormatAlign.CENTER);
		public static var formatHomeGuideSpotName:TextFormat = new TextFormat(null,18,0x757575);//sh首页列出的景点
		
		public static function getTravelDscFormat():TextFormat
		{
			var formatDesc:TextFormat = new TextFormat(null,18,0x000000,false);
			formatDesc.letterSpacing = LETTER_SPACE;
			formatDesc.leading = LEADING_LINE;
			return formatDesc;
		}
		public static function getTravelDetailTitleFormat():TextFormat
		{
			var formatNoteDetailTitle:TextFormat = new TextFormat(null,24,0x707070,true);
			formatNoteDetailTitle.letterSpacing = LETTER_SPACE;
			return formatNoteDetailTitle;
		}
		public static function getRouteGuideDsc():TextFormat
		{
			var formatRouteGuideSiteDsc:TextFormat = new TextFormat(null,15,0x1e1e1e,null,null,null,null,null,null,null,null,null,2);
			formatRouteGuideSiteDsc.letterSpacing = LETTER_SPACE;
			return formatRouteGuideSiteDsc;
		}
		public static function getVisitDetailDsc():TextFormat
		{
			var formatVisitDetailDsc:TextFormat = new TextFormat(null,18,0x1e1e1e,false,null,null,null,null);// 推荐线路详情Dsc
			formatVisitDetailDsc.leading = LEADING_LINE;
			formatVisitDetailDsc.letterSpacing = LETTER_SPACE;
			return formatVisitDetailDsc;
		}
	}
}