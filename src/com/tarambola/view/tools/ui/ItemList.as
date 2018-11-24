package com.tarambola.view.tools.ui
{
	import starling.display.Sprite;

	public class ItemList extends Sprite
	{
		public function ItemList()
		{
			var v:Vector.<String> = new Vector.<String>;
			v.push("info");
			v.push("fotos");
			v.push("video");
			v.push("plus");
			
			for(var i:int = 0; i < 15; i++)
			{
				var item:Item = new Item(i, v);
				this.addChild(item);
			}
		}
	}
}