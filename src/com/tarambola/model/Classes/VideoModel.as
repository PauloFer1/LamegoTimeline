package com.tarambola.model.Classes
{
	public class VideoModel
	{
		public var path:String;
		public var thumb:String
		public var text:StringLang;
		
		public function VideoModel(text:StringLang, path:String, thumb:String)
		{
			this.text=text;
			this.path = path;
			this.thumb = thumb;
		}
		public static function constructOne():VideoModel
		{
			var s:StringLang = new StringLang(Constants.PT,  "Integer turpis est, aliquet sed rutrum a, hendrerit volutpat ante. In pulvinar bibendum velit, ac aliquet velit pharetra in. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Sed feugiat turpis felis. Aliquam a egestas nunc. Donec mi odio, feugiat at laoreet et, hendrerit sed odio.");
			s.add(Constants.EN,  "Integer turpis est, aliquet sed rutrum a, hendrerit volutpat ante. In pulvinar bibendum velit, ac aliquet velit pharetra in. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Sed feugiat turpis felis. Aliquam a egestas nunc. Donec mi odio, feugiat at laoreet et, hendrerit sed odio.");
			s.add(Constants.ES,  "Integer turpis est, aliquet sed rutrum a, hendrerit volutpat ante. In pulvinar bibendum velit, ac aliquet velit pharetra in. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Sed feugiat turpis felis. Aliquam a egestas nunc. Donec mi odio, feugiat at laoreet et, hendrerit sed odio.");
			
			var i:VideoModel = new VideoModel(s, "video.flv", "foto.jpg");
			
			return(i);
		}
	}
}