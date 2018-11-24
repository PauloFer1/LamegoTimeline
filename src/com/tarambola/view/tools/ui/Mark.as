package com.tarambola.view.tools.ui
{
	import com.tarambola.model.Classes.Arq;
	import com.tarambola.model.Classes.Constants;
	
	import starling.display.Button;
	import starling.textures.Texture;
	
	public class Mark extends Button
	{
		public function Mark()
		{
			super(Arq.getInstance().model.asset.getTexture("mark_"+Constants.getInstance().actUI));
		}
	}
}