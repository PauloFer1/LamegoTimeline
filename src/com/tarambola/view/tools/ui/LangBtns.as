package com.tarambola.view.tools.ui
{
	
	import com.tarambola.controller.NavEvents;
	import com.tarambola.model.Classes.Arq;
	import com.tarambola.model.Classes.Constants;
	
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class LangBtns extends Sprite
	{
		private var _pt:Button;
		private var _en:Button;
		private var _es:Button;
		
		public function LangBtns()
		{
			super();
			
			this._pt = new Button(Arq.getInstance().model.asset.getTexture("PTBtn"));
			this._en = new Button(Arq.getInstance().model.asset.getTexture("ENBtn"));
			this._es = new Button(Arq.getInstance().model.asset.getTexture("ESBtn"));
			
			this.addChild(this._pt);
			this.addChild(this._en);
			this.addChild(this._es);
			
			this._en.x = this._pt.x + this._pt.width + 14;
			this._es.x = this._en.x + this._en.width + 14;
			
			this._pt.addEventListener(Event.TRIGGERED, ptHandler);
			this._en.addEventListener(Event.TRIGGERED, enHandler);
			this._es.addEventListener(Event.TRIGGERED, esHandler);
		}
		
		private function esHandler():void
		{
			Constants.getInstance().actLang = Constants.ES;
			NavEvents.getInstance().dispatchCustomEvent("LANG.SELECTED", "langbtn", {lang:Constants.ES});
		}
		
		private function enHandler():void
		{
			Constants.getInstance().actLang = Constants.EN;
			NavEvents.getInstance().dispatchCustomEvent("LANG.SELECTED", "langbtn", {lang:Constants.EN});
		}
		
		private function ptHandler():void
		{
			Constants.getInstance().actLang = Constants.PT;
			NavEvents.getInstance().dispatchCustomEvent("LANG.SELECTED", "langbtn", {lang:Constants.PT});
		}
	}
}