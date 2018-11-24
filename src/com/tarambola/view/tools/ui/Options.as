package com.tarambola.view.tools.ui
{
	
	import com.tarambola.controller.NavEvents;
	
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.Line;
	
	public class Options extends Sprite
	{
		private var _id:uint;
		private var _pos:uint
		private var _options:Vector.<Option>;
		private var _mark:Mark;
		
		private var _topLayer:Sprite;
		private var _bottomLayer:Sprite;
		
		private var _lines:Vector.<Line>;
		private var _linesCont:Sprite;
		private var _lineTween:Tween;
		
		private var _horLine:Line;
		private var _verLine:Line;
		private var _linesCont2:Sprite;
		
		private var _tween1:Tween;
		
		//FLAGS
		private var _active:Boolean = false;
		private var _last:Boolean;
		
		public function Options(id:uint, pos:uint, options:Vector.<String>, last:Boolean = false)
		{
			super();
			this._id = id;
			this._pos=pos;
			this._last = last;
			
			this._topLayer = new Sprite();
			this._bottomLayer = new Sprite();
			this._lines = new Vector.<Line>;
			this._linesCont = new Sprite();
			this._linesCont.alpha=0;
			this._linesCont2 = new Sprite();
			
			this.addChild(this._bottomLayer);
			this.addChild(this._topLayer);
			
			this._options = new Vector.<Option>;
			this._mark = new Mark();
			this._topLayer.addChild(this._mark);
			
			this._horLine = new Line(0, this._mark.height/2, 1, 0xCB9866);
			this._horLine.lineTo(-70, this._mark.height/2);
			this._horLine.alpha = 0.5;
			this._bottomLayer.addChild(this._linesCont2);
			this._linesCont2.addChild(this._horLine);
			this._bottomLayer.addChild(this._linesCont);
			
			this.setOptions(options);
			this._mark.addEventListener(Event.TRIGGERED, showOpts);
		}
		private function setOptions(opts:Vector.<String>):void
		{
			var d:Number = Math.PI/3;
			var o:Number = (opts.length-1) * d;
			var a1:Number = (Math.PI - o) / 2;
			var a:Number = this._mark.width/2;
			var b:Number = this._mark.height/2;
			var r:Number = this._mark.height*1.2;
						
			for(var i:uint=0; i<opts.length; i++)
			{
				var _x:Number = a + r*Math.cos( -( (a1 + (i*d)) + Math.PI/2) );
				var _y:Number = b + r*Math.sin( -( (a1 + (i*d)) + Math.PI/2) );
				
				this._lines[i] = new Line(a, b, 2, 0xCB9866);
				this._lines[i].lineTo(_x, _y);
				
				this._options[i] = new Option(opts[i], this._pos, _x, _y);
				this._linesCont.addChild(this._lines[i]);
				this._bottomLayer.addChild(this._options[i]);
			}
			this._mark.addEventListener(Event.TRIGGERED, showOpts);
		}
		//****** HANDLERS
		private function showOpts():void
		{
			if(this._active)
			{
				//** PARA VERTICALLAYOUTSCREEN
				NavEvents.getInstance().dispatchCustomEvent("HIDE.OPTIONS", "options", {"id":this._id, "pos":this._pos});
			}
			else
			{
				//** PARA VERTICALLAYOUTSCREEN
				NavEvents.getInstance().dispatchCustomEvent("SHOW.OPTIONS", "options", {"id":this._id, "pos":this._pos});
			}
		}
		private function showLines():void
		{
			Starling.juggler.remove(this._lineTween);
			this._lineTween = new  Tween(this._linesCont, 0.4);
			this._lineTween.animate("alpha", 1);
			this._lineTween.onComplete = endTween;
			Starling.juggler.add(this._lineTween);
		}
		private function hideLines():void
		{
			Starling.juggler.remove(this._lineTween);
			this._lineTween = new  Tween(this._linesCont, 0.1);
			this._lineTween.animate("alpha", 0);
			this._lineTween.onComplete= endTween;
			Starling.juggler.add(this._lineTween);
		}
		private function endTween():void
		{
			Starling.juggler.remove(this._lineTween);
		}
		private function removeTween():void
		{
			Starling.juggler.remove(this._tween1);
			this._tween1 = null;
		}
		//*********** PUBLIC METHODS **************//
		public function hide():void
		{
			this.hideLines();
			for(var i:uint=0; i<this._options.length; i++)
			{
				this._options[i].hide();
			}
			this._active=false;
		}
		public function show():void
		{
			this.showLines();
			for(var i:uint=0; i<this._options.length; i++)
			{
				this._options[i].show();
			}
			this._active=true;
		}
		public function highlight():void
		{
			this._mark.touchable = false;
			this._tween1 = new Tween(this._linesCont2, 0.5);
			this._tween1.animate("alpha", 0.5);
			this._tween1.onComplete = removeTween; 
			Starling.juggler.add(this._tween1);
		}			
		public function downlight():void
		{
			this._tween1 = new Tween(this._linesCont2, 0.5);
			this._tween1.animate("alpha", 1);
			this._tween1.onComplete = removeTween; 
			Starling.juggler.add(this._tween1);
		}
		public function setTouchable():void
		{
			this._mark.touchable = true;
		}
		public function setUntouchable():void
		{
			this._mark.touchable = false;
		}
		public function disposeTemporarily():void
		{
			this._mark.removeEventListener(Event.TRIGGERED, showOpts);
			this._options = null;
		}
		//****** GETS
		public function get markHeight():Number
		{
			return(this._mark.height);
		}
		public function get options():Vector.<Option>
		{
			return(this._options);
		}	
	}
}