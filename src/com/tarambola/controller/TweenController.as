package com.tarambola.controller
{
	import com.tarambola.ErrorDisplay;
	
	import starling.animation.Tween;
	
	public class TweenController
	{
		static private var _instance:TweenController;
		
		//	private var _tweens:uint=0;
		private var _tweens:Vector.<Tween>;
		
		public function TweenController(SingletonEnforcer:SingletonEnforcer)
		{
			this._tweens = new Vector.<Tween>;
		}
		public static function getInstance():TweenController
		{
			if(TweenController._instance == null)
			{
				TweenController._instance = new TweenController(new SingletonEnforcer());
			}
			return(TweenController._instance);
		}
		public function addTween(tween:Tween):void
		{
			this._tweens.push(tween);
		}
		public function removeAndAdd(tween:Tween):void
		{
			this.removeIfExist(tween);
			this.addTween(tween);
		}
		public function removeTween(tween:Tween):void
		{
			for(var i:uint =0; i<this._tweens.length; i++)
			{
				if(this._tweens[i]==tween)
					this._tweens.splice(i, 1);
			}
		}
		public function reset():void
		{
			this._tweens = null;
			this._tweens = new Vector.<Tween>;
		}
		public function has(tween:Tween):Boolean
		{
			for(var i:uint =0; i< this._tweens.length; i++)
			{
				if(this._tweens[i] == tween)
					return(true);
			}
			return(false);
		}
		public function removeIfExist(tween:Tween):void
		{
			for(var i:uint =0; i< this._tweens.length; i++)
			{
				if(this._tweens[i] == tween)
				{
					this._tweens.splice(i, 1);
				}
			}
		}
		public function hasTween():Boolean
		{
			if(this._tweens.length>0)
				return true;
			return false;
		}
	}
}
class SingletonEnforcer {}