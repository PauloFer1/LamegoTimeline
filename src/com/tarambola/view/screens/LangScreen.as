package com.tarambola.view.screens
{
	import com.tarambola.model.Classes.Arq;
	import com.tarambola.view.tools.ui.LangBtns;
	
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	
	public class LangScreen extends Sprite
	{
		private var _langBtns:LangBtns;
		private var _logo:Image;
		private var _lang:Image;
		private var _quad:Quad;
		private var _tween:Tween;
		private var _line:Quad;
		
		public function LangScreen()
		{
			super();
			
			this.visible = false;
			this.touchable = false;
			this.alpha=0;
			this._quad = new Quad(Starling.current.stage.stageWidth, Starling.current.stage.stageHeight, 0x8E1F28);
			this._quad.alpha = 0.9;
			
			this._langBtns = new LangBtns();
			this._logo = new Image(Arq.getInstance().model.asset.getTexture("logo"));
			this._logo.x = Starling.current.stage.stageWidth/2 - this._logo.width/2;
			this._logo.y = 340;
			
			this._lang = new Image(Arq.getInstance().model.asset.getTexture("select_lang"));
			this._lang.x = Starling.current.stage.stageWidth/2 - this._lang.width/2;
			this._lang.y = this._logo.y + this._logo.height + 80;
			
			this._langBtns.x = Starling.current.stage.stageWidth/2 - this._langBtns.width/2;
			this._langBtns.y = Starling.current.stage.stageHeight/2 - this._langBtns.height/2;
			
			this._line = new Quad(50, 7, 0xECE8CA);
			this._line.x = Starling.current.stage.stageWidth/2 - this._line.width/2;
			this._line.y = this._langBtns.y + this._langBtns.height/2 - this._line.height/2;
			
			this.addChild(this._quad);
			this.addChild(this._logo);
			this.addChild(this._lang);
			this.addChild(this._line);
			this.addChild(this._langBtns);
		}
		public function init():void
		{
			this.touchable = true;
			this.alpha = 1;
			this.visible = true;
		}
		public function remove():void
		{
			this.touchable=false;
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