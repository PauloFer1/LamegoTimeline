package com.tarambola.controller
{
	import com.tarambola.model.Model;
	
	public class Controller
	{
		private var model:Model;
		
		public function Controller(model:Model)
		{
			this.model=model;
		}
		public function init():void
		{
			DistanceController.getInstance().init();
		}
	}
}