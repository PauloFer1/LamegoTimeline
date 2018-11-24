package com.tarambola.model.Classes
{
	public class PlusModel
	{
		public var text:StringLang;
		public var galleries:Vector.<GalleryModel>;
		
		public function PlusModel()
		{
			this.galleries = new Vector.<GalleryModel>;
		}
		public static function constructOne():PlusModel
		{
			var p:PlusModel = new PlusModel();
			
			p.galleries.push(GalleryModel.constructOne());
			
			var s:StringLang = new StringLang(Constants.PT,  "Integer turpis est, aliquet sed rutrum a, hendrerit volutpat ante. In pulvinar bibendum velit, ac aliquet velit pharetra in. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Sed feugiat turpis felis. Aliquam a egestas nunc. Donec mi odio, feugiat at laoreet et, hendrerit sed odio.");
			s.add(Constants.EN,  "Integer turpis est, aliquet sed rutrum a, hendrerit volutpat ante. In pulvinar bibendum velit, ac aliquet velit pharetra in. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Sed feugiat turpis felis. Aliquam a egestas nunc. Donec mi odio, feugiat at laoreet et, hendrerit sed odio.");
			s.add(Constants.ES,  "Integer turpis est, aliquet sed rutrum a, hendrerit volutpat ante. In pulvinar bibendum velit, ac aliquet velit pharetra in. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Sed feugiat turpis felis. Aliquam a egestas nunc. Donec mi odio, feugiat at laoreet et, hendrerit sed odio.");
			
			p.text = s;
			
			return(p);
		}
	}
}