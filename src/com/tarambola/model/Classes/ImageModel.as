package com.tarambola.model.Classes
{
	import flash.filesystem.File;

	public class ImageModel
	{
		public var path:String;
		public var text:StringLang;
		
		public function ImageModel(text:StringLang, path:String)
		{
			this.path = path;
			this.text = text;
		}
		
		public static function constructOne():ImageModel
		{
			var s:StringLang = new StringLang(Constants.PT,  "Integer turpis est, aliquet sed rutrum a, hendrerit volutpat ante. In pulvinar bibendum velit, ac aliquet velit pharetra in. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Sed feugiat turpis felis. Aliquam a egestas nunc. Donec mi odio, feugiat at laoreet et, hendrerit sed odio.");
			s.add(Constants.EN,  "Integer turpis est, aliquet sed rutrum a, hendrerit volutpat ante. In pulvinar bibendum velit, ac aliquet velit pharetra in. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Sed feugiat turpis felis. Aliquam a egestas nunc. Donec mi odio, feugiat at laoreet et, hendrerit sed odio.");
			s.add(Constants.ES,  "Integer turpis est, aliquet sed rutrum a, hendrerit volutpat ante. In pulvinar bibendum velit, ac aliquet velit pharetra in. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Sed feugiat turpis felis. Aliquam a egestas nunc. Donec mi odio, feugiat at laoreet et, hendrerit sed odio.");
			
			var i:ImageModel = new ImageModel(s, File.applicationDirectory.resolvePath("files").resolvePath("images").resolvePath("foto1.jpg").url);
			
			return(i);
		}
	}
}