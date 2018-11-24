package com.tarambola.view.tools.bg
{
	import com.tarambola.model.Classes.Arq;
	
	import flash.geom.Point;
	
	import starling.core.Starling;
	import starling.display.BlendMode;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Background extends Sprite
	{
		private var _images:Vector.<Image>;
		
		public function Background()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, build);
			this.addEventListener(Event.ENTER_FRAME, update);
		}
		private function update():void
		{
			for(var i:uint=0; i<this._images.length; i++)
			{
				var __x:Number = this._images[i].globalToLocal(new Point(this.parent.x, this.parent.y)).x;
				if(__x < (100 + this._images[i].width) && __x > -(Starling.current.stage.stageWidth+100))
					this._images[i].visible = true;
				else
					this._images[i].visible = false;
			}
		}
		protected function build(event:Event):void
		{
			this._images = new Vector.<Image>;
			
			for(var i:uint =0; i<15; i++)
			{
				this._images[i] = new Image(Arq.getInstance().model.asset.getTexture("lona-" + (i+1).toString()));
				if(i>0)
					this._images[i].x = this._images[i-1].x + this._images[i-1].width;
				this.addChild(this._images[i]);
				this._images[i].blendMode = BlendMode.NONE;
				this._images[i].touchable = false;
				this._images[i].visible = false;
			}
		}
	}
}