package com.tarambola.model.Classes
{
	import com.tarambola.HashMap;

	public class ItensModel
	{
		private var _itens:Vector.<ItemModel>;
		
		public function ItensModel()
		{
			this._itens = new Vector.<ItemModel>;
		}
		public function addItem(item:ItemModel):void
		{
			this._itens.push(item);
		}
		public function get totalItens():Vector.<ItemModel>
		{
			return(this._itens);
		}
	}
}