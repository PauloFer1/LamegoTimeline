package com.tarambola.view.tools.ui
{
	import com.tarambola.controller.NavEvents;
	import com.tarambola.controller.TweenController;
	import com.tarambola.model.Classes.Arq;
	import com.tarambola.model.Classes.Constants;
	
	import flash.events.MouseEvent;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class Option extends Sprite
	{
		private var _x:Number;
		private var _y:Number;
		
		private var _hideX:Number;
		private var _hideY:Number;
		/* id:
				info || fotos || video || plus */
		private var _id:String;
		private var _pos:uint;
		private var _image:Image;
		private var _imageSel:Image;
		private var _option:Image;
		
		private var _tween:Tween;
		private var _tweenActive:Tween;
		private var _tween2:Tween;
		
		public function Option(id:String, pos:uint, _x:Number, _y:Number)
		{
			super();
			this.touchable=false;
			this._id = id;
			this._pos=pos;
			this._option = new Image(Arq.getInstance().model.asset.getTexture(id+"_"+Constants.getInstance().actUI));
			
			if(Constants.getInstance().actUI == Constants.UI1)
			{
				this._image = new Image(Arq.getInstance().model.asset.getTexture("opt_btn_ui1"));
		/*		this._image.x = this._imageSel.width/2 - this._image.width/2;
				this._image.y = this._imageSel.height/2 - this._image.height/2;
				this._option.x = this._imageSel.width/2 - this._option.width/2;
				this._option.y = this._imageSel.height/2 - this._option.height/2;
			*/	
				this._image.pivotX = this._image.width/2;
				this._image.pivotY = this._image.height/2;
				this._image.x =  this._image.width/2;
				this._image.y =  this._image.height/2;
				
				
				this._imageSel = new Image(Arq.getInstance().model.asset.getTexture("opt_btn_sel_ui1"));
				this._imageSel.pivotX = this._imageSel.width/2;
				this._imageSel.pivotY = this._imageSel.height/2;
				this._imageSel.x =  this._imageSel.width/2;
				this._imageSel.y =  this._imageSel.height/2;
				this._option.x = this._imageSel.width/2 - this._option.width/2;
				this._option.y = this._imageSel.height/2 - this._option.height/2;
			}
			else
			{
				switch(id)
				{
					case "info":
					{
						this._image = new Image(Arq.getInstance().model.asset.getTexture("opt_info_ui2"));
						break;
					}
					case "fotos":
					{
						this._image = new Image(Arq.getInstance().model.asset.getTexture("opt_fotos_ui2"));
						break;
					}
					case "video":
					{
						this._image = new Image(Arq.getInstance().model.asset.getTexture("opt_video_ui2"));
						break;
					}
					case "plus":
					{
						this._image = new Image(Arq.getInstance().model.asset.getTexture("opt_mais_ui2"));
						break;
					}
					default:
					{
						break;
					}
				}
				this._image.pivotX = this._image.width/2;
				this._image.pivotY = this._image.height/2;
				this._image.x =  this._image.width/2-11;
				this._image.y =  this._image.height/2-11;
				this._image.scaleX = this._image.scaleY = 0.7;
				this._option.x = this._image.width/2 - this._option.width/2;
				this._option.y = this._image.height/2 - this._option.height/2;
				
			}
		//	this._imageSel.alpha =0;
			
			
			
			this.alpha = 0;
			
			if(Constants.getInstance().actUI == Constants.UI1)
				this.addChild(this._imageSel);
			this.addChild(this._image);
			this.addChild(this._option);
			
			
			this.x = 3;
			this.y = 3;
			this._x =_x; //- this.width/2;
			this._y =_y; //- this.height/2;
			
			this.pivotX = this.width/2;
			this.pivotY = this.height/2;
			
			this.addEventListener(TouchEvent.TOUCH, touchHandler);
		}
		
		private function setActive():void
		{
			if(Constants.getInstance().actUI == Constants.UI1)
			{
				TweenController.getInstance().removeIfExist(this._tweenActive);
				this._tweenActive = new Tween(this._image, 0.4);
				this._tweenActive.animate("alpha", 0);
				this._tweenActive.onComplete = removeTweenActive;
				TweenController.getInstance().addTween(this._tweenActive);
				Starling.juggler.add(this._tweenActive);
				
			}
			else
			{
				TweenController.getInstance().removeIfExist(this._tweenActive);
				this._tweenActive = new Tween(this._image, 0.4, Transitions.EASE_OUT_BOUNCE);
				this._tweenActive.scaleTo(1);
				this._tweenActive.onComplete = removeTweenActive;
				TweenController.getInstance().addTween(this._tweenActive);
				Starling.juggler.add(this._tweenActive);
			}
		}
		//************* HANLDERS *************//
		private function touchHandler(evt:TouchEvent):void
		{
			if(!TweenController.getInstance().hasTween())
			{
				var touches:Vector.<Touch> = evt.getTouches(this, TouchPhase.ENDED);
				if(touches.length>0)
				{
					Constants.getInstance().isTouchable=false;
					this.setActive();
					// EVENT PARA ITEM e VIEW
					NavEvents.getInstance().dispatchCustomEvent("OPTION.TOUCH", "option", {id:this._id, pos:this._pos});
				}
			}
		}
		private function removeTween(flag:uint):void
		{
			Constants.getInstance().isTouchable=true;
			Starling.juggler.remove(this._tween);
			TweenController.getInstance().removeTween(this._tween);
			this._tween=null;
		}
		private function removeTweenActive():void
		{
			Constants.getInstance().isTouchable=true;
			Starling.juggler.remove(this._tweenActive);
			TweenController.getInstance().removeTween(this._tweenActive);
			this._tweenActive=null;
		}
		//********** PUBLIC METHODS ***********//
		public function show():void
		{
			TweenController.getInstance().removeIfExist(this._tween);
			Starling.juggler.remove(this._tween);
			this._tween = new Tween(this, 0.5, Transitions.EASE_OUT_ELASTIC);
			this._tween.animate("x", this._x);
			this._tween.animate("y", this._y);
			this._tween.animate("alpha", 1);
			this._tween.onComplete = removeTween; 
			this._tween.onCompleteArgs = [0];
			TweenController.getInstance().addTween(this._tween);
			Starling.juggler.add(this._tween);
			this.touchable=true;
		}
		public function hide():void
		{
			Starling.juggler.remove(this._tween);
			TweenController.getInstance().removeIfExist(this._tween);
			this._tween = new Tween(this, 0.1, Transitions.LINEAR);
			this._tween.animate("x", 3);
			this._tween.animate("y", 3);
			this._tween.animate("alpha", 0);
			this._tween.onComplete = removeTween;
			this._tween.onCompleteArgs = [0];
			TweenController.getInstance().addTween(this._tween);
			Starling.juggler.add(this._tween);
			this.touchable=false;
		}
		public function setInactive():void
		{
			if(Constants.getInstance().actUI == Constants.UI1)
			{
				TweenController.getInstance().removeIfExist(this._tween);
				this._tween = new Tween(this._image, 0.4);
				this._tween.animate("alpha", 1);
				this._tween.onComplete = removeTween;
				Starling.juggler.add(this._tween);
				TweenController.getInstance().addTween(this._tween);
				this._tween.onCompleteArgs = [0];
				
			}
			else
			{
				TweenController.getInstance().removeIfExist(this._tween);
				this._tween = new Tween(this._image, 0.4, Transitions.EASE_OUT_BOUNCE);
				this._tween.scaleTo(0.7);
				this._tween.onComplete = removeTween;
				Starling.juggler.add(this._tween);
				TweenController.getInstance().addTween(this._tween);
				this._tween.onCompleteArgs = [0];
			}
		}
		public function reset():void
		{
			this._image.alpha = 1;
		}
		//***** GETS
		public function get id():String
		{
			return(this._id);
		}
	}
}