package com.tarambola.view.screens
{
	import com.tarambola.ErrorDisplay;
	import com.tarambola.controller.NavEvents;
	import com.tarambola.controller.TweenController;
	import com.tarambola.model.Classes.Arq;
	import com.tarambola.model.Classes.Constants;
	import com.tarambola.model.Classes.VerticalLayoutSettings;
	import com.tarambola.view.tools.ui.Item;
	import com.tarambola.view.tools.ui.ItemList;
	
	import feathers.controls.Button;
	import feathers.controls.PanelScreen;
	import feathers.controls.ScrollContainer;
	import feathers.controls.Scroller;
	import feathers.events.FeathersEventType;
	import feathers.layout.VerticalLayout;
	import feathers.system.DeviceCapabilities;
	
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.events.Event;

	public class VerticalLayoutScreen extends PanelScreen
	{
		private var settings:VerticalLayoutSettings;
		
		private var _seta:Image;
		
		private var _current:Number=-1;
		private var _currentPos:Number=-1;
		private var _itens:Vector.<Item>;
		private var _tween:Tween;
		
		//FLAGS
		private var isLocked:Boolean=false;
		private var _isShow:Boolean = false;
		
		public function VerticalLayoutScreen()
		{
			super();
			this.addEventListener(FeathersEventType.INITIALIZE, initializeHandler);
			NavEvents.getInstance().addEventListener("HIDE.OPTIONS", hideOptionsHandler);
			NavEvents.getInstance().addEventListener("SHOW.OPTIONS", showOptionsHandler);
			NavEvents.getInstance().addEventListener("ITEM.INTERACT", highlightItem); 
			NavEvents.getInstance().addEventListener("CLOSE.CONTENT", closeContent); 
			NavEvents.getInstance().addEventListener("CHANGE.ITENS", changeItens);
			NavEvents.getInstance().addEventListener("REMOVE.ITENS", removeItens);
			NavEvents.getInstance().addEventListener("START.SCREEN", disposeTotally);
			this.addEventListener(Event.ENTER_FRAME, checkSeta);
			this.setAlpha();
		}		
		//********** INITIALIZE VERTICAL SCREEN ****************//
		protected function initializeHandler(event:Event):void
		{
			this.removeEventListener(FeathersEventType.INITIALIZE, initializeHandler);
			
			const layout:VerticalLayout = new VerticalLayout();
			this.settings = new VerticalLayoutSettings();
			layout.gap = this.settings.gap;
			layout.paddingTop = this.settings.paddingTop;
			layout.paddingRight = this.settings.paddingRight;
			layout.paddingBottom = this.settings.paddingBottom;
			layout.paddingLeft = this.settings.paddingLeft;
			layout.horizontalAlign = this.settings.horizontalAlign;
			layout.verticalAlign = this.settings.verticalAlign;
			layout.manageVisibility = true;
			layout.useVirtualLayout = true;
			layout.afterVirtualizedItemCount = 0;
			this.y=Constants.MARGIN_TOP_LIST;
							
			this.layout = layout;
			this._seta = new Image(Arq.getInstance().model.asset.getTexture("seta_lado_"+Constants.getInstance().actUI));
			this._seta.rotation = Math.PI/2;
			this._seta.y = Starling.current.stage.stageHeight - this._seta.height - 60;
			this._seta.x = Starling.current.stage.stageWidth - this._seta.width - 20;
			this._seta.visible=false;
			this._seta.alpha=0.5;
			this.parent.addChild(this._seta);
			//when the scroll policy is set to on, the "elastic" edges will be
			//active even when the max scroll position is zero
			this.verticalScrollPolicy = ScrollContainer.SCROLL_POLICY_ON;
			this.snapScrollPositionsToPixels = true;

		//	this._verticalScrollPosition = 1000;
			this.populate();
		}
		private function downlightItens(id:uint):void
		{
			for(var i:uint=0; i< this._itens.length; i++)
			{
				if(this._itens[i].id != id)
					this._itens[i].enable();
				else
					this._itens[i].downlight();
			}
		}
		private function disposeTemporarilly():void
		{
			if(this._itens!=null)
			{
				for(var i:uint=0; i<this._itens.length; i++)
				{
					this.removeChild(this._itens[i], true);
					this._itens[i] = null;
				}
				this._itens = null;
			}
		}
		private function disposeTotally():void
		{
			NavEvents.getInstance().removeEventListener("HIDE.OPTIONS", hideOptionsHandler);
			NavEvents.getInstance().removeEventListener("SHOW.OPTIONS", showOptionsHandler);
			NavEvents.getInstance().removeEventListener("ITEM.INTERACT", highlightItem); 
			NavEvents.getInstance().removeEventListener("CLOSE.CONTENT", closeContent); 
			NavEvents.getInstance().removeEventListener("CHANGE.ITENS", changeItens);
			NavEvents.getInstance().removeEventListener("REMOVE.ITENS", removeItens);
			NavEvents.getInstance().removeEventListener("START.SCREEN", disposeTotally);
			this.disposeTemporarilly();
			this.dispose();
		}
		//************ PUBLIC METHODS ************//
		public function populate():void
		{
			this.alpha=0;
			this.y=0;
			this.height = Starling.current.stage.stageHeight - this.y;
			this._itens = new Vector.<Item>;
			if(Constants.getInstance().actItens!=-1)
			{
				for(var i:int = 0; i < Arq.getInstance().model.lists[Constants.getInstance().actItens].itens.length; i++)
				{
					if(Arq.getInstance().model.lists[Constants.getInstance().actItens].itens[i].title.getString(Constants.getInstance().actLang)!=null && Arq.getInstance().model.lists[Constants.getInstance().actItens].itens[i].title.getString(Constants.getInstance().actLang)!="")
					{
						var last:Boolean;
						if(i == Arq.getInstance().model.lists[Constants.getInstance().actItens].itens.length-1)
							last = true;
						else
							last = false;
						this._itens[i] = new Item(Arq.getInstance().model.lists[Constants.getInstance().actItens].itens[i], i, last);
						this.addChild(this._itens[i]);
					}
				}
				if(this._itens.length==0)
					ErrorDisplay.getInstance().showError("NÃO EXISTE ITENS!");
				this._tween = new  Tween(this, 0.5);
				this._tween.animate("alpha", 1);
				this._tween.onComplete = endTweenPop;
				Starling.juggler.add(this._tween);
			}
		}
		//*********** HANLDLERS ************//
		private function checkSeta():void
		{
			if((this.viewPort.y+this._viewPort.height) > (Starling.current.stage.stageHeight) && this._isShow)
				this._seta.visible=true;
			else
				this._seta.visible=false;
		}
		private function removeItens():void
		{
			this._isShow=false;
			Constants.getInstance().isTouchable = false;
			Starling.juggler.remove(this._tween);
			this._tween=null;
			this._tween = new  Tween(this, 0.5);
			this._tween.animate("alpha", 0);
			this._tween.onComplete = endTweenRemove;
			TweenController.getInstance().removeAndAdd(this._tween);
			Starling.juggler.add(this._tween);
			this.resetAll();
		}
		private function changeItens():void
		{
			Constants.getInstance().isTouchable = false;
			this._currentPos=-1;
			this._tween = new  Tween(this, 0.5);
			this._tween.animate("alpha", 0);
			this._tween.onComplete = endTween;
			TweenController.getInstance().removeAndAdd(this._tween);
			Starling.juggler.add(this._tween);
		}
		private function endTweenRemove():void
		{
			Starling.juggler.remove(this._tween);
			TweenController.getInstance().removeTween(this._tween);
			this._tween = null;
			this.disposeTemporarilly();
			Constants.getInstance().isTouchable = true;
		}
		private function endTween():void
		{
			Starling.juggler.remove(this._tween);
			TweenController.getInstance().removeTween(this._tween);
			this._tween = null;
			this.disposeTemporarilly();
			this.populate();
			Constants.getInstance().isMoving = false;
		}
		private function endTweenPop():void
		{
			this._isShow=true;
			Starling.juggler.remove(this._tween);
			this._tween = null;
			Constants.getInstance().isTouchable = true;
		}
		private function showOptionsHandler(evt:Event):void
		{
			if(!this._isDraggingVertically)
			{
				if(this._currentPos!=-1){
					this._itens[this._currentPos].hide();
				}
				if(this._current != evt.data.id){
					try
					{
						this._itens[evt.data.id].show();
					} 
					catch(error:Error) 
					{
						ErrorDisplay.getInstance().showError(error.message);	
					}
				}
				this._currentPos = evt.data.pos;
				this._current = evt.data.id;
				this.isEnabled = false;
				Constants.getInstance().itemSelected = evt.data.id;
			}
		}
		private function highlightItem(evt:Event):void
		{
			for(var i:uint=0; i< this._itens.length; i++)
			{
				Starling.juggler.removeTweens(this._itens[i]);	
				if(this._itens[i].id != evt.data.id){
					this._itens[i].disable();
				}
				else{
					this._itens[i].highlight();
				}
			}
		}
		private function hideOptionsHandler(evt:Event):void
		{
			if(!this._isDraggingVertically && this._currentPos!=-1)
			{
				this._itens[this._currentPos].hide();
				this._currentPos = -1;
				this._current = -1;
				this.isEnabled = true;
				
				this.downlightItens(evt.data.id);
			}
		}
		private function closeContent():void
		{
			if(this._currentPos!=-1)
			{
				this._itens[this._currentPos].setTouchable();
				this.downlightItens(this._currentPos);
			}
		}
		private function openContent():void
		{
			this._itens[this._currentPos].setUntouchable();
		}
		//************* PUBLIC METHOS *************//
		/*public function resetOptions():void
		{
			if(this._currentPos!=-1)
				this._itens[this._currentPos].reset();
		}*/
		public function resetAll():void
		{
			this._current = -1;
			this._currentPos = -1;
			for(var i:uint=0; i<this._itens.length; i++)
			{
				this._itens[i].reset();
			}
		}
		public function setAlpha():void
		{
			//this.alpha=0.2;
		}

	}
}
