package com.tarambola.model.Classes
{
	public class GalleryVideoItem
	{
		public var title:String;
		public var url:String;
		public var text:String;
		public var thumb:String;
		
		public function GalleryVideoItem(title:String, url:String, text:String, thumb:String)
		{
			this.title = title;
			this.url = url;
			this.text = text;
			this.thumb = thumb;
		}
	}
}