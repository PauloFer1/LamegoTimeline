package com.tarambola.view.tools.ui
{
	import com.tarambola.controller.NavEvents;
	import com.tarambola.model.Classes.Arq;
	import com.tarambola.model.Classes.Constants;
	import com.tarambola.model.Classes.Fonts;
	import com.tarambola.model.Classes.GalleryItem;
	import com.tarambola.model.Classes.GalleryVideoItem;
	
	import feathers.controls.ImageLoader;
	import feathers.controls.List;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.core.FeathersControl;
	import feathers.events.FeathersEventType;
	
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.TextureSmoothing;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	public class GalleryVideoItemRenderer extends FeathersControl implements IListItemRenderer
	{
		private static const HELPER_POINT:Point = new Point();
		private static const HELPER_TOUCHES_VECTOR:Vector.<Touch> = new <Touch>[];
		
		/**
		 * This will only work in a single list. If this item renderer needs to
		 * be used by multiple lists, this data should be stored differently.
		 */
		private static const CACHED_BOUNDS:Dictionary = new Dictionary(false);
		
		protected var image:ImageLoader;
		protected var touchPointID:int = -1;
		protected var fadeTween:Tween;
		private var _index:int = -1;
		protected var _owner:List;
		protected var _isSelected:Boolean;
		private var _data:GalleryVideoItem;
		private var _text:TextField;
		private var _playBtn:Image;
		
		
		public function GalleryVideoItemRenderer()
		{
			super();
			this.width=220;
			this.height = 210;
			this.isQuickHitAreaEnabled = true;
			this.addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
		}
		//**************** OVERRIDES ****************//
		override protected function initialize():void
		{
			this.image = new ImageLoader();
			this.image.smoothing = TextureSmoothing.BILINEAR;
			this.image.addEventListener(Event.COMPLETE, image_completeHandler);
			this.image.addEventListener(FeathersEventType.ERROR, image_errorHandler);
			this.addChild(this.image);
			
			var font2:BitmapFont = Fonts.getInstance().getFont("NeoSans");
			this._text = new TextField(220,40, "", font2.name, 13, 0x5A4A42);
			this._text.hAlign = HAlign.CENTER;
			this._text.vAlign = VAlign.TOP;
			this._text.y = 162;
			this.addChild(this._text);
			
			this._playBtn = new Image(Arq.getInstance().model.asset.getTexture("play_btn_"+Constants.getInstance().actUI));
			this._playBtn.x = 90;
			this._playBtn.y = 65;
			this.addChild(this._playBtn);
			this._playBtn.touchable = true;
			this._playBtn.addEventListener(TouchEvent.TOUCH, playVideo);
			this.isQuickHitAreaEnabled = false;
		}
		override protected function draw():void
		{
			const dataInvalid:Boolean = this.isInvalid(INVALIDATION_FLAG_DATA);
			const selectionInvalid:Boolean = this.isInvalid(INVALIDATION_FLAG_SELECTED);
			var sizeInvalid:Boolean = this.isInvalid(INVALIDATION_FLAG_SIZE);
			
			if(dataInvalid)
			{
				if(this.fadeTween)
				{
					this.fadeTween.advanceTime(Number.MAX_VALUE);
				}
				if(this._data)
				{
					this.image.visible = false;
					this.image.source = this._data.thumb;
					this._text.text = this._data.text;
					if(this.image.isLoaded)
					{
						this.image.visible = true;
					}
				}
				else
				{
					this.image.source = null;
				}
			}
			
			sizeInvalid = this.autoSizeIfNeeded() || sizeInvalid;
			
			if(sizeInvalid)
			{
				this.image.width = 220;
				this.image.height = 160;
			}
		}
		//**************** PRIVATE METHODS ***************//
		protected function autoSizeIfNeeded():Boolean
		{
			const needsWidth:Boolean = isNaN(this.explicitWidth);
			const needsHeight:Boolean = isNaN(this.explicitHeight);
			if(!needsWidth && !needsHeight)
			{
				return false;
			}
			
			this.image.width = this.image.height = NaN;
			this.image.validate();
			var newWidth:Number = this.explicitWidth;
			if(needsWidth)
			{
				if(this.image.isLoaded)
				{
					if(!CACHED_BOUNDS.hasOwnProperty(this._index))
					{
						CACHED_BOUNDS[this._index] = new Point();
					}
					var boundsFromCache:Point = Point(CACHED_BOUNDS[this._index]);
					//also save it to a cache so that we can reuse the width and
					//height values later if the same image needs to be loaded
					//again.
					newWidth = boundsFromCache.x = this.image.width;
				}
				else
				{
					if(CACHED_BOUNDS.hasOwnProperty(this._index))
					{
						//if the image isn't loaded yet, but we've loaded it at
						//least once before, we can use a cached value to avoid
						//jittering when the image resizes
						boundsFromCache = Point(CACHED_BOUNDS[this._index]);
						newWidth = boundsFromCache.x;
					}
					else
					{
						//default to 100 if we've never displayed an image for
						//this index yet.
						newWidth = 100;
					}
					
				}
			}
			var newHeight:Number = this.explicitHeight;
			if(needsHeight)
			{
				if(this.image.isLoaded)
				{
					if(!CACHED_BOUNDS.hasOwnProperty(this._index))
					{
						CACHED_BOUNDS[this._index] = new Point();
					}
					boundsFromCache = Point(CACHED_BOUNDS[this._index]);
					newHeight = boundsFromCache.y = this.image.height;
				}
				else
				{
					if(CACHED_BOUNDS.hasOwnProperty(this._index))
					{
						boundsFromCache = Point(CACHED_BOUNDS[this._index]);
						newHeight = boundsFromCache.y;
					}
					else
					{
						newHeight = 100;
					}
				}
			}
			return this.setSizeInternal(newWidth, newHeight, false);
		}
		//**************** HANDLERS ****************//
		protected function fadeTween_onComplete():void
		{
			this.fadeTween = null;
		}
		protected function removedFromStageHandler(event:Event):void
		{
			this.touchPointID = -1;
		}
		
		protected function owner_scrollHandler(event:Event):void
		{
			this.touchPointID = -1;
		}
		protected function image_completeHandler(event:Event):void
		{
			this.image.alpha = 0;
			this.image.visible = true;
			this.fadeTween = new Tween(this.image, 0.25, Transitions.EASE_OUT);
			this.fadeTween.fadeTo(1);
			this.fadeTween.onComplete = fadeTween_onComplete;
			Starling.juggler.add(this.fadeTween);
			this.invalidate(INVALIDATION_FLAG_SIZE);
		}
		
		protected function image_errorHandler(event:Event):void
		{
			this.invalidate(INVALIDATION_FLAG_SIZE);
		}
		private function playVideo(event:TouchEvent):void
		{
			const touches:Vector.<Touch> = event.getTouches(this);
			if(touches.length == 0)
			{
				//hover has ended
				return;
			}
			if(this.touchPointID >= 0)
			{
				var touch:Touch;
				for each(var currentTouch:Touch in touches)
				{
					if(currentTouch.id == this.touchPointID)
					{
						touch = currentTouch;
						break;
					}
				}
				if(!touch)
				{
					return;
				}
				if(touch.phase == TouchPhase.ENDED)
				{
					this.touchPointID = -1;
					
					touch.getLocation(this.stage, HELPER_POINT);
					//check if the touch is still over the target
					const isInBounds:Boolean = this.contains(this.stage.hitTest(HELPER_POINT, true));
					if(isInBounds)
					{
						NavEvents.getInstance().dispatchCustomEvent("VIDEO.PLAY", "videorenderer", {id:this.index});
						this.isSelected = true;
					}
					return;
				}
			}
			else
			{
				for each(touch in touches)
				{
					if(touch.phase == TouchPhase.BEGAN)
					{
						this.touchPointID = touch.id;
						return;
					}
				}
			}
		}
		//**************** GETS & SETS ***************//
		public function get data():Object
		{
			return this._data;
		}
		
		public function set data(value:Object):void
		{
			if(this._data == value)
			{
				return;
			}
			this.touchPointID = -1;
			this._data = GalleryVideoItem(value);
			this.invalidate(INVALIDATION_FLAG_DATA);
		}
		
		public function get index():int
		{
			return this._index;
		}
		
		public function set index(value:int):void
		{
			if(this._index == value)
			{
				return;
			}
			this._index = value;
			this.invalidate(INVALIDATION_FLAG_DATA);
		}
		
		public function get owner():List
		{
			return List(this._owner);
		}
		
		public function set owner(value:List):void
		{
			if(this._owner == value)
			{
				return;
			}
			if(this._owner)
			{
				this._owner.removeEventListener(Event.SCROLL, owner_scrollHandler);
			}
			this._owner = value;
			if(this._owner)
			{
				this._owner.addEventListener(Event.SCROLL, owner_scrollHandler);
			}
			this.invalidate(INVALIDATION_FLAG_DATA);
		}
		
		public function get isSelected():Boolean
		{
			return this._isSelected;
		}
		
		public function set isSelected(value:Boolean):void
		{
			if(this._isSelected == value)
			{
				return;
			}
			this._isSelected = value;
			this.dispatchEventWith(Event.CHANGE);
		}
	}
}