package com.tarambola.model.Classes
{
	public class PlusItem
	{
		public var id:uint;
		public var title:String;
		public var url:String;
		
		public function PlusItem(id:uint, title:String, url:String)
		{
			this.title = title;
			this.url = url;
			this.id = id;
		}
	}
}