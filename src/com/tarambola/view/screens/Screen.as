package com.tarambola.view.screens
{
	import com.tarambola.model.Classes.Arq;
	
	import feathers.controls.Screen;
	
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
		
	public class Screen extends feathers.controls.Screen
	{
		//SCREEN NAME
		private var _name:String;
		
		private var _tween:Tween;
		
		public function Screen(name:String)
		{
			super();
			this._name = name;
		}
		//********** PUBLIC METHODS ***********//
		public function fadeIn():void
		{
			this.alpha = 0;
			this._tween = new  Tween(this, 0.5);
			this._tween.delay = 0.3;
			this._tween.animate("alpha", 1);
			this._tween.onComplete = endTween;
			Starling.juggler.add(this._tween);
		}
		//****** HANLDERS *****//
		private function endTween():void
		{
			Starling.juggler.remove(this._tween);
		}
		//GETS
		public override function get name():String
		{
			return(this._name);
		}
		//SETS
		public override function set name(name:String):void
		{
			this._name = name;
		}
	}
}