package com.tarambola.model.Classes
{
	public class ItensList
	{
		public var id:uint;
		public var itens:Vector.<ItemModel>;
		public var title:StringLang;
		public var posX:Number;
		
		public function ItensList()
		{
			this.itens = new Vector.<ItemModel>;
		}
		public static function constructOne(id:uint, posX:Number):ItensList
		{
			var it:ItensList = new ItensList();
			
			for(var i:uint; i<10; i++)
			{
				it.itens.push(ItemModel.constructOne());
			}
			it.id = id;
			it.posX = posX;
			
			return(it);
		}
	}
}