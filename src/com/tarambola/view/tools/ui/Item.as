package com.tarambola.view.tools.ui
{
	import com.tarambola.controller.NavEvents;
	import com.tarambola.model.Classes.Arq;
	import com.tarambola.model.Classes.Constants;
	import com.tarambola.model.Classes.Fonts;
	import com.tarambola.model.Classes.ItemModel;
	
	import flash.geom.Rectangle;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.Line;
	import starling.utils.VAlign;
	
	public class Item extends Sprite
	{
		private var _id:uint;
		private var _pos:uint;
		private var _options: Options;
		private var _title:TextField;
		private var _tween:Tween;
		private var _lineTween:Tween;
		
		private var _verLine:Line;
		
		private var _textTween:Tween;
		
		private var _last:Boolean;
		
		public function Item(item:ItemModel, pos:uint, last:Boolean=false)
		{
			super();
			// ******* WARNING - ID É A POSIÇÃO DO VECTOR 
			this._id = pos;
			this._pos = pos;
			this._options = new Options(pos, pos, item.getOptions(Constants.PT), last);
			this._last = last
			
			var font:BitmapFont = Fonts.getInstance().getFont(Constants.FONT_LIST_NAME);
			this._title = new TextField(500, Constants.ITEM_HEIGHT,	item.title.getString(Constants.getInstance().actLang), font.name, Constants.FONT_LIST_SIZE, Constants.FONT_LIST_COLOR);
			this._title.hAlign = HAlign.LEFT;
			this._title.vAlign = VAlign.CENTER;
			this._title.x = 215;
			this._title.y = 0;
			//this._title.border = true;
			
			this._options.x = Constants.MARGIN_LEFT_LIST;
			this._options.y = Constants.ITEM_HEIGHT/2 - this._options.markHeight/2;
			this.addChild(this._title);
			
			var _y:uint;
			if(this._pos==0)
				_y = Constants.ITEM_HEIGHT/2;
			else
				_y=0;
			this._verLine = new Line(63, _y, 1, 0xCB9866);
			this._verLine.alpha=0.5;
			if(this._last)
				this._verLine.lineTo(63, Constants.ITEM_HEIGHT/2);
			else
				this._verLine.lineTo(63, Constants.ITEM_HEIGHT);
			this.addChild(this._verLine);
			this.addChild(this._options);
			
			//this.addEventListener(Event.ENTER_FRAME, onRender);
			NavEvents.getInstance().addEventListener("OPTION.TOUCH", touchHandler);
		}
		//****** HANDLERS
		private function onRender():void
		{
			if(this.y < 486)
				this.alpha = 0.5;
			else
				this.alpha = 1;
		}
		private function removeTween():void
		{
			Starling.juggler.remove(this._textTween);
		}
		private function touchHandler(evt:Event):void
		{
			if(this._id == evt.data.pos)
			{
				// EVENT PARA VERTICAL LAYOUT
				NavEvents.getInstance().dispatchCustomEvent("ITEM.INTERACT", "item", {id: this._id});
			}
			for(var i:uint = 0; i<this._options.options.length; i++)
			{
				if(evt.data.id != this._options.options[i].id)
				{
					this._options.options[i].setInactive();
				}
			}
			this._options.setUntouchable();
		}
		private function removeHighTween1(error:String):void
		{
			Starling.juggler.remove(this._lineTween);
			this._lineTween=null;
		}
		private function removeHighTween2():void
		{
			Starling.juggler.remove(this._lineTween);
			this._lineTween=null;
		}
		private function removeDisableTween():void
		{
			Starling.juggler.remove(this._tween);
			this._tween = null;
		}
		//*********** PUBLIC METHODS ************//
		public function disposeTemporarily():void
		{
			this._options.disposeTemporarily();
		}
		public function hide():void
		{
			this.reset();
			Starling.juggler.remove(this._textTween);
			this._textTween = new Tween(this._title, 0.4);
			this._textTween.animate("fontSize", Constants.FONT_LIST_SIZE);
			this._textTween.onComplete = removeTween;
			Starling.juggler.add(this._textTween);
			this._options.hide();
		}
		public function show():void
		{
			Starling.juggler.remove(this._textTween);
			this._options.show();
			this._textTween = new Tween(this._title, 0.4);
			this._textTween.animate("fontSize", Constants.FONT_LIST_HIGH_SIZE);
			Starling.juggler.add(this._textTween);
		}
		public function get id():uint
		{
			return(this._id);
		}
		public function reset():void
		{
			for(var i:uint = 0; i<this._options.options.length; i++)
			{
				this._options.options[i].reset();
			}
		}
		public function highlight():void
		{
			this._options.highlight();
			this._lineTween = new Tween(this._verLine, 0.5);
			this._lineTween.animate("alpha", 0.2);
			this._lineTween.onComplete = removeHighTween1; 
			this._lineTween.onCompleteArgs = ["highlight 1111111"];
			Starling.juggler.add(this._lineTween);
		}
		public function downlight():void
		{
			this._options.downlight();
			this._lineTween = new Tween(this._verLine, 0.5);
			this._lineTween.animate("alpha", 0.5);
			this._lineTween.onComplete = removeHighTween2; 
			Starling.juggler.add(this._lineTween);
		}
		public function disable():void
		{
			this._tween = new Tween(this, 0.5);
			this._tween.animate("alpha", 0.4);
			this._tween.onComplete = removeDisableTween; 
			Starling.juggler.add(this._tween);
			this.touchable = false;
		}
		public function enable():void
		{
			this.downlight();
			this._tween = new Tween(this, 0.5);
			this._tween.animate("alpha", 1);
			this._tween.onComplete = removeDisableTween; 
			Starling.juggler.add(this._tween);
			this.touchable = true;
			this._options.setTouchable();
		}
		public function setTouchable():void
		{
			this._options.setTouchable();
			this.reset();
		}
		public function setUntouchable():void
		{
			this._options.setUntouchable();
		}
	}
}