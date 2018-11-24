package com.tarambola.view.screens
{
	import com.tarambola.controller.NavEvents;
	import com.tarambola.controller.TweenController;
	import com.tarambola.model.Classes.Arq;
	import com.tarambola.model.Classes.Constants;
	import com.tarambola.view.tools.ui.ContentBG;
	
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Content extends Sprite
	{
		private var _background:ContentBG;
		private var _info:Info;
		private var _fotos:GaleriaFotos;
		private var _videos:GaleriaVideos;
		private var _mais:Mais;
		private var _actScreen:Screen;
		private var _bottomLayer:Sprite;
		private var _topLayer:Sprite;
		
		private var _tween:Tween;		
		private var _screenTween:Tween;
		
		private var _closeBtn:Button;
		
		public function Content()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, initialize);
		}
		
		protected function initialize(event:Event):void
		{
			// INIT SCREENS
			this._info = new Info("info");
			this._fotos = new GaleriaFotos("fotos");
			this._videos = new GaleriaVideos("video");
			this._mais = new Mais("plus");
			
			
			// LAYOUT
			//this.buildLayout();
			
			// init content
			//this.initScreen();
		}
		public function buildLayout():void
		{
			this._bottomLayer = new Sprite();
			this._topLayer = new Sprite();
			this._background = new ContentBG();
			this.addChild(this._bottomLayer);
			this.addChild(this._topLayer);
			
			this._topLayer.addChild(this._info);
			this._topLayer.addChild(this._fotos);
			this._topLayer.addChild(this._videos);
			this._topLayer.addChild(this._mais);
			
			
			this._info.visible = false;
			this._fotos.visible = false;
			this._videos.visible = false;
			this._mais.visible = false;
			
			this._closeBtn = new Button(Arq.getInstance().model.asset.getTexture("close_btn_"+Constants.getInstance().actUI));
			this._closeBtn.addEventListener(Event.TRIGGERED, dispatchClose);		
			
			this.construct();
			
			this._bottomLayer.addChild(this._closeBtn);
			
			this.visible = false;
		}
		private function displayCloseBtn():void
		{
			if(Constants.getInstance().actUI == Constants.UI1)
			{
				if(this._actScreen != this._info)
				{
					this._closeBtn.x = this._background.x + this._background.actWidth - this._closeBtn.width/2 - 90;
					this._closeBtn.y = this._background.y + this._background.actHeight - this._closeBtn.height/2 - 90;
				}
				else
				{
					this._closeBtn.x = this._background.x + this._background.actHeight - this._closeBtn.width/2 - 155;
					this._closeBtn.y = this._background.y + this._background.actWidth - this._closeBtn.height/2 - 5;
				}
			}
			else
			{
				if(this._actScreen != this._mais)
				{
					this._closeBtn.x = this._background.x + this._background.actWidth - this._closeBtn.width/2 - 70;
					this._closeBtn.y = this._background.y + this._background.actHeight - this._closeBtn.height/2 - 90;
				}
				else
				{
					this._closeBtn.x = this._background.x + this._background.actHeight - this._closeBtn.width/2 - 70;
					this._closeBtn.y = this._background.y + this._background.actWidth - this._closeBtn.height/2 - 90;
				}
			}
			//this._closeBtn.x = this._background.x + this._background.actWidth - 100;
			//this._closeBtn.y = this._background.y + this._background.actHeight - 100;
		}
		private function construct():void
		{
			if(Constants.getInstance().actUI == Constants.UI2)
				this.x = 200;
			else
				this.x = 176;
			this.y = Starling.current.stage.stageHeight/2 - this._background.height/2;
			
			this._bottomLayer.addChild(this._background);
			
			this._topLayer.x=this._background.x;
			this._topLayer.y=this._background.y;
		}
		public function initScreen(screen:String):void
		{
			TweenController.getInstance().removeIfExist(this._tween);
			this.visible = true;
			this.alpha = 0;
			
			this.goto(screen);
			
			this._tween = new  Tween(this, 0.5);
			this._tween.animate("alpha", 1);
			this._tween.onComplete = endTween;
			Starling.juggler.add(this._tween);
			
		}
		public function goto(id:String):void
		{
			if(this._actScreen!=null && this._actScreen.name!=id)
			{
				TweenController.getInstance().removeIfExist(this._screenTween);
				this._screenTween = new  Tween(this._actScreen, 0.3);
				this._screenTween.animate("alpha", 0);
				this._screenTween.onCompleteArgs = [this._actScreen];
				this._screenTween.onComplete = endScreenTween;
				TweenController.getInstance().addTween(this._screenTween);
				Starling.juggler.add(this._screenTween);
				this._background.show(id);
				switch(id)
				{
					case "info":
					{
						this.gotoInfo();
						break;
					}
					case "fotos":
					{
						this.gotoFotos();
						break;
					}
					case "video":
					{
						this.gotoVideos();
						break;
					}
					case "plus":
					{
						this.gotoMais();
						break;
					}
				}
			}
			else if(this._actScreen==null )
			{
				this._background.show(id);
				switch(id)
				{
					case "info":
					{
						this.gotoInfo();
						break;
					}
					case "fotos":
					{
						this.gotoFotos();
						break;
					}
					case "video":
					{
						this.gotoVideos();
						break;
					}
					case "plus":
					{
						this.gotoMais();
						break;
					}
				}
			}
		}
		public function gotoInfo():void
		{
				//this._background.rotation = Math.PI/2;
				this._actScreen = this._info;
				this._info.init(this._background.width, this._background.height, Arq.getInstance().model.lists[Constants.getInstance().actItens].itens[Constants.getInstance().itemSelected].text.getString(Constants.getInstance().actLang));
				this._info.fadeIn();
				this.displayCloseBtn();
		}
		public function gotoFotos():void
		{
			
			this._background.rotation = 0;
			this._actScreen = this._fotos;
			this._fotos.init(this._background.width, this._background.height);
			this._fotos.alpha=0;
			this._fotos.visible=true;
			this._fotos.fadeIn();
			this.displayCloseBtn();
		}
		public function gotoVideos():void
		{
			this._background.rotation = 0;
			this._actScreen = this._videos;
			this._videos.init(this._background.width, this._background.height);
			this._videos.visible=true;
			this._videos.fadeIn();
			this.displayCloseBtn();
		}
		public function gotoMais():void
		{
			this._background.rotation = 0;
			this._actScreen = this._mais;
			this._mais.init(this._background.width, this._background.height);
			this._mais.fadeIn();
			this.displayCloseBtn();
		}
		
		//*********** HANLDERS ************//
		private function endTween(isRemove:Boolean=false):void
		{
			Starling.juggler.remove(this._tween);
			if(isRemove)
			{
				//this.touchable = false;
				this.visible = false;
				this._actScreen.visible=false;
				this._actScreen = null;
			}
			TweenController.getInstance().removeTween(this._tween);
			this._tween=null;
		}
		private function endScreenTween(screen:Screen):void
		{
			if(screen != null)
				screen.visible = false;
			Starling.juggler.remove(this._screenTween);
			TweenController.getInstance().removeTween(this._screenTween);
			this._screenTween=null;
		}
		//*********** PUBLIC METHODS ********//
		public function removeScreen():void
		{
			if(this._actScreen!=null)
			{
				TweenController.getInstance().removeIfExist(this._tween);
				this._tween = new  Tween(this, 0.3);
				this._tween.animate("alpha", 0);
				this._tween.onCompleteArgs = [true];
				this._tween.onComplete = endTween;
				TweenController.getInstance().addTween(this._tween);
				Starling.juggler.add(this._tween);
			}
		}
		public function disposeTemporarily():void
		{
			this.removeScreen();
			if(this._actScreen!=null)
			{
				//this._actScreen.dispose();
				//this._actScreen=null;
			}
		}
		private function dispatchClose():void
		{
			// PARA View
			NavEvents.getInstance().dispatchCustomEvent("CLOSE.CONTENT", "close_btn");
		}
	}
}