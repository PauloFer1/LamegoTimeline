package com.tarambola.view.screens
{
	import com.tarambola.controller.NavEvents;
	import com.tarambola.model.Classes.Arq;
	import com.tarambola.model.Classes.Constants;
	import com.tarambola.view.tools.ui.LangBtns;
	
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class VersionScreen extends Sprite
	{
		private var _langBtns:Sprite;
		private var _adult:Button;
		private var _child:Button;
		private var _logo:Image;
		private var _lang:Image;
		private var _quad:Quad;
		private var _tween:Tween;
		
		public function VersionScreen()
		{
			super();
			
			this.visible = false;
			this.touchable = false;
			this._langBtns = new Sprite();
			this.alpha=0;
			this._quad = new Quad(Starling.current.stage.stageWidth, Starling.current.stage.stageHeight, 0x8E1F28);
			this._quad.alpha = 0.9;
			
			this._adult = new Button(Arq.getInstance().model.asset.getTexture("adulto_btn"));
			this._child = new Button(Arq.getInstance().model.asset.getTexture("crianca_btn"));
			this._adult.addEventListener(Event.TRIGGERED, gotoAdult);
			this._child.addEventListener(Event.TRIGGERED, gotoChild);
			this._langBtns.addChild(this._adult);
			this._langBtns.addChild(this._child);
			this._child.x = this._adult.x + this._adult.width + 20;
			this._logo = new Image(Arq.getInstance().model.asset.getTexture("logo"));
			this._logo.x = Starling.current.stage.stageWidth/2 - this._logo.width/2;
			this._logo.y = 340;
			
			this._lang = new Image(Arq.getInstance().model.asset.getTexture("select_vers"));
			this._lang.x = Starling.current.stage.stageWidth/2 - this._lang.width/2;
			this._lang.y = this._logo.y + this._logo.height + 80;
			
			this._langBtns.x = Starling.current.stage.stageWidth/2 - this._langBtns.width/2;
			this._langBtns.y = Starling.current.stage.stageHeight/2 - this._langBtns.height/2;
			
			this.addChild(this._quad);
			this.addChild(this._logo);
			this.addChild(this._lang);
			this.addChild(this._langBtns);
		}
		
		private function gotoChild():void
		{
			this._adult.touchable = this._child.touchable=false;
			this._child.removeEventListener(Event.TRIGGERED, gotoChild);
			this._adult.removeEventListener(Event.TRIGGERED, gotoAdult);
			Constants.getInstance().actUI = Constants.UI2;
			this.remove();
			NavEvents.getInstance().dispatchCustomEvent("INIT.VERSION", "version_screen");
		}
		
		private function gotoAdult():void
		{
			this._adult.touchable = this._child.touchable=false;
			this._child.removeEventListener(Event.TRIGGERED, gotoChild);
			this._adult.removeEventListener(Event.TRIGGERED, gotoAdult);
			Constants.getInstance().actUI = Constants.UI1;
			this.remove();
			NavEvents.getInstance().dispatchCustomEvent("INIT.VERSION", "version_screen");
		}
		public function init():void
		{
			this._adult.touchable = true;
			this._child.touchable=true;
			this._adult.addEventListener(Event.TRIGGERED, gotoAdult);
			this._child.addEventListener(Event.TRIGGERED, gotoChild);
			this.alpha = 1;
			this.visible = true;
			this.touchable = true;
		}
		public function remove():void
		{
			this._tween = new  Tween(this, 0.5);
			this._tween.animate("alpha", 0);
			this._tween.onComplete = endTween;
			Starling.juggler.add(this._tween);
		}
		
		private function endTween():void
		{
			this.disposeTemporarily();
		}
		public function disposeTemporarily():void
		{
			this.visible = false;
			this.touchable = false;
		}
	}
}