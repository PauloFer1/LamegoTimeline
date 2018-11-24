package com.tarambola.view.screens
{
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Quad;
	import starling.display.Sprite;
	
	public class ShadowBox extends Sprite
	{
		private var _shadow:Quad;
		private var _tween:Tween;
		
		public function ShadowBox()
		{
			super();
			
			this._shadow = new Quad(Starling.current.stage.stageWidth, Starling.current.stage.stageHeight, 0x000);
			this.alpha = 0;
			this.addChild(this._shadow);
		}
		public function show():void
		{
			this._tween = new  Tween(this, 0.5);
			this._tween.animate("alpha", 0.8);
			this._tween.onComplete = endTween;
			Starling.juggler.add(this._tween);
		}
		public function hide():void
		{
			this._tween = new  Tween(this, 0.5);
			this._tween.animate("alpha", 0);
			this._tween.onComplete = endTween;
			Starling.juggler.add(this._tween);
		}
		
		//********* HANDLERS ********//
		private function endTween():void
		{
			// TODO Auto Generated method stub
			
		}
	}
}