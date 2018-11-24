package com.tarambola.model.Classes
{
	public class ItemModel
	{
		public var id:uint;
		public var posX:uint;
		public var title:StringLang;
		public var text:StringLang;
		public var gallery:Vector.<ImageModel>;
		public var videoGallery:Vector.<VideoModel>;
		public var plus:PlusModel;
		
		public function ItemModel()
		{
			this.gallery = new Vector.<ImageModel>;
			this.videoGallery = new Vector.<VideoModel>;
			this.title = new StringLang();
			this.text = new StringLang();
			this.plus = new PlusModel();
		}
		public function addTitle(lang:String, title:String):void
		{
			this.title.add(lang, title);
		}
		public function addText(lang:String, title:String):void
		{
			this.text.add(lang, title);
		}
		public function addGalleryItem(text:StringLang, path:String):void
		{
			var item:ImageModel  = new ImageModel(text, path);
			this.gallery.push(item);
		}
		public function addVideoItem(text:StringLang, path:String, thumb:String):void
		{
			var item:VideoModel = new VideoModel(text, path, thumb);
			this.videoGallery.push(item);
		}
		
		public static function constructOne():ItemModel
		{
			var i:ItemModel = new ItemModel();
			
			var s:StringLang = new StringLang(Constants.PT,  "Hendrerit sed odio.");
			s.add(Constants.EN,  "Sed feugiat turpis felis.");
			s.add(Constants.ES,  "Integer turpis est.");
			
			i.title = s;
			
			var s2:StringLang = new StringLang(Constants.PT,  "Integer turpis est, aliquet sed rutrum a, hendrerit volutpat ante. In pulvinar bibendum velit, ac aliquet velit pharetra in. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Sed feugiat turpis felis. Aliquam a egestas nunc. Donec mi odio, feugiat at laoreet et, hendrerit sed odio.");
			s2.add(Constants.EN,  "Integer turpis est, aliquet sed rutrum a, hendrerit volutpat ante. In pulvinar bibendum velit, ac aliquet velit pharetra in. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Sed feugiat turpis felis. Aliquam a egestas nunc. Donec mi odio, feugiat at laoreet et, hendrerit sed odio.");
			s2.add(Constants.ES,  "Integer turpis est, aliquet sed rutrum a, hendrerit volutpat ante. In pulvinar bibendum velit, ac aliquet velit pharetra in. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Sed feugiat turpis felis. Aliquam a egestas nunc. Donec mi odio, feugiat at laoreet et, hendrerit sed odio.");
			
			i.text = s2;
			i.plus = PlusModel.constructOne();
			i.gallery.push(ImageModel.constructOne());
			i.videoGallery.push(VideoModel.constructOne());

			return(i);
		}
		public function getOptions(lang:String):Vector.<String>
		{
			var opt:Vector.<String> = new Vector.<String>;
			if(this.text.getString(lang)!= null && this.text.getString(lang)!="")
				opt.push("info");
			if(this.gallery.length>0)
				opt.push("fotos");
			if(this.videoGallery.length>0)
				opt.push("video");
			if(this.plus.text.getString(lang)!= null && this.plus.text.getString(lang)!= "")
				opt.push("plus");
			
			return(opt);
		}
		
	}
}