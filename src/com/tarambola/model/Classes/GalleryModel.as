package com.tarambola.model.Classes
{
	import flash.filesystem.File;

	public class GalleryModel
	{
		public var text:StringLang;
		public var gallery:Vector.<ImageModel>;
		
		public function GalleryModel()
		{
			this.gallery = new Vector.<ImageModel>;
		}
		public function addImage(text:StringLang, path:String):void
		{
			this.gallery.push(new ImageModel(text, path));
		}
		public static function constructOne():GalleryModel
		{
			var g:GalleryModel = new GalleryModel();;
			
			var s:StringLang = new StringLang(Constants.PT,  "Integer turpis est, aliquet sed rutrum a, hendrerit volutpat ante. In pulvinar bibendum velit, ac aliquet velit pharetra in. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Sed feugiat turpis felis. Aliquam a egestas nunc. Donec mi odio, feugiat at laoreet et, hendrerit sed odio.");
			s.add(Constants.EN,  "Integer turpis est, aliquet sed rutrum a, hendrerit volutpat ante. In pulvinar bibendum velit, ac aliquet velit pharetra in. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Sed feugiat turpis felis. Aliquam a egestas nunc. Donec mi odio, feugiat at laoreet et, hendrerit sed odio.");
			s.add(Constants.ES,  "Integer turpis est, aliquet sed rutrum a, hendrerit volutpat ante. In pulvinar bibendum velit, ac aliquet velit pharetra in. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Sed feugiat turpis felis. Aliquam a egestas nunc. Donec mi odio, feugiat at laoreet et, hendrerit sed odio.");
			
			g.text = s;
			
			var s2:StringLang = new StringLang(Constants.PT,  "Feugiat at laoreet et, hendrerit sed odio.");
			s2.add(Constants.EN,  "Donec mi odio, feugiat at laoreet et.");
			s2.add(Constants.ES,  "Integer turpis est, aliquet sed rutrum.");
			
			
			g.addImage(s2, File.applicationDirectory.resolvePath("files").resolvePath("images").resolvePath("foto1.jpg").url);
			
			return(g);
		}
	}
}