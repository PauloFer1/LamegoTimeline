package com.tarambola.view
{
	import com.tarambola.DelayCall;
	import com.tarambola.ErrorDisplay;
	import com.tarambola.controller.Controller;
	import com.tarambola.controller.DistanceController;
	import com.tarambola.controller.NavEvents;
	import com.tarambola.controller.TweenController;
	import com.tarambola.model.Classes.*;
	import com.tarambola.model.Classes.Arq;
	import com.tarambola.model.Classes.Constants;
	import com.tarambola.model.Classes.Fonts;
	import com.tarambola.model.Model;
	import com.tarambola.view.screens.Content;
	import com.tarambola.view.screens.LangScreen;
	import com.tarambola.view.screens.ScreenSaver;
	import com.tarambola.view.screens.ShadowBox;
	import com.tarambola.view.screens.VersionScreen;
	import com.tarambola.view.screens.VerticalLayoutScreen;
	import com.tarambola.view.tools.bg.Background;
	
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	//import feathers.themes.AeonDesktopTheme.AeonDesktopTheme;
	
	import flash.system.Capabilities;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.events.TouchEvent;
	
	
	
	public class View extends Sprite
	{
		private var model:Model;
		private var controller: Controller;
		
		// STAGE VARS
		private var bgs:Vector.<Image>;
		
		// SCREENS
		private var _content:Content;
		private var _langScreen:LangScreen;
		private var _versionScreen:VersionScreen;
		
		// LAYOUT
		private static const LIST:String = "list";
		private static const VERTICAL_SETTINGS:String = "verticalSettings";
		private var _navigator:ScreenNavigator;
		private var _shadow:ShadowBox;
		private var _topLayer:Sprite;
		private var _bottomLayer:Sprite;
		private var _background:Background;
		
		// FLAGS
		private var _hasContent:Boolean = false;
		
		
		public function View()
		{
			super();
			
			if(!Capabilities.isDebugger)
				Arq.getInstance().model.addEventListener("ALL.LOADED", preInit);
			else
				Arq.getInstance().model.addEventListener("ALL.LOADED", initApp);
		}
		protected function preInit(event:Event=null):void
		{
			NavEvents.getInstance().addEventListener("CONTROLLER.READY", initApp); 
			Arq.getInstance().controller.init();	
		}	
		protected function initApp(event:Event=null):void
		{
			ScreenSaver.getInstance().init();
			Starling.current.stage.dispatchEvent(event);			
			
			Arq.getInstance().model.removeEventListener("ALL.LOADED", initApp);
			
			// INIT FONTS
			Fonts.getInstance().init();
			
			// INIT SCREENS
			this._content = new Content();
			this._navigator = new ScreenNavigator();
			this._langScreen = new LangScreen();
			this._versionScreen = new VersionScreen();
			
			// LAYOUT
			this.buildLayout();
			
			// EVENTS
			NavEvents.getInstance().addEventListener("OPTION.TOUCH", showOpt);
			NavEvents.getInstance().addEventListener("CLOSE.CONTENT", closeContent);
			NavEvents.getInstance().addEventListener("LANG.SELECTED", selectVers);
			NavEvents.getInstance().addEventListener("INIT.VERSION", startApp);
			NavEvents.getInstance().addEventListener("START.SCREEN", restart);
			NavEvents.getInstance().addEventListener("REMOVE.SCREEN", removeScreen);
			Starling.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKey);
			Starling.current.stage.addEventListener(TouchEvent.TOUCH, resetSaver);
			
			this.addEventListener(Event.ENTER_FRAME, move);
			
			//INITIALIZE GAME
			//this.startApp();			
			this.selectLang();
		}
		private function buildLayout():void
		{
			this._background = new Background();
			this.addChild(this._background);
			this._shadow = new ShadowBox();
			this._bottomLayer = new Sprite();
			this._topLayer = new Sprite();
			this.addChild(this._shadow);
			this.addChild(this._bottomLayer);
			this.addChild(this._topLayer);
			
			this._content.visible=false;
			this._navigator.visible =false;
			
			this._bottomLayer.addChild(this._navigator);
			this._topLayer.addChild(this._content);
			this._topLayer.addChild(this._versionScreen);
			this._topLayer.addChild(this._langScreen);
			
		}
		private function removeScreen():void
		{
			ErrorDisplay.getInstance().showError("VERSÃO " + Constants.VERSION);
			this._langScreen.init();	
		}
		private function restart():void
		{
			if(this._hasContent)
				this.removeContent();
			this._langScreen.remove();
			this._navigator.visible=false;
			this._navigator.dispose();
			this._navigator =null;
			this._navigator= new ScreenNavigator();
			this._bottomLayer.addChild(this._navigator);
			this.selectLang();
			this._content = null;
			this._content = new Content();
			this._topLayer.addChildAt(this._content,0);
		}
		private function selectVers():void
		{
			this._langScreen.remove();
			this._versionScreen.init();
		}
		private function selectLang():void
		{
			
		}
		private function startApp(evt:Event = null):void
		{		
			this._content.buildLayout();
			this.showList();
		}
		private function showList():void
		{
			this._navigator.visible = true;
			//this.addChild(this._navigator);
			if(Arq.getInstance().model.getClosest(this.convertToMm(this._background.x))!=null)
			{
				Constants.getInstance().actItens = Arq.getInstance().model.getClosest(this.convertToMm(this._background.x)).id;
			}
			this._navigator.addScreen(LIST, new ScreenNavigatorItem(VerticalLayoutScreen));
			this._navigator.showScreen("list");
		}
		private function showContent(id:String):void
		{
			//this._shadow.show();
			this._content.initScreen(id);
			this._hasContent = true;
		}
		private function removeContent():void
		{
			//this._shadow.hide();
			this._content.disposeTemporarily();
			this._hasContent = false;
		}
		//********************* HANDLERS
		private function resetSaver():void
		{
			ScreenSaver.getInstance().reset();			
		}
		private function showOpt(evt:Event):void
		{
			if(!this._hasContent)
				this.showContent(evt.data.id);
			else
				this._content.goto(evt.data.id);
		}
		private function closeContent():void
		{
			if(this._hasContent)
				this.removeContent();
		}
		private function onKey(evt:KeyboardEvent):void
		{
			if(evt.keyCode == 39)
			{
				DistanceController.getInstance().increase();
			}
			else if(evt.keyCode == 37)
			{
				DistanceController.getInstance().decrease();
			}
		}
		private function move():void
		{
			//ScreenSaver.getInstance().reset();
			this._background.x = - this.convertToPx(DistanceController.getInstance().distance);

			var it:ItensList = Arq.getInstance().model.getClosest(DistanceController.getInstance().distance);
			if(!TweenController.getInstance().hasTween() && it!=null && Constants.getInstance().actItens!=it.id)
			{
				trace("GET LIST");
				Constants.getInstance().actItens = it.id;
				//PARA VERTICALLAYOUTSCREEN
				NavEvents.getInstance().dispatchCustomEvent("CHANGE.ITENS", "view");
				this.removeContent();
				this._shadow.show();
			}
			else if(!TweenController.getInstance().hasTween() && it == null && Constants.getInstance().actItens!= -1)
			{
				trace("NULLLLLL");
				Constants.getInstance().actItens = -1;
				//PARA VERTICALLAYOUTSCREEN
				NavEvents.getInstance().dispatchCustomEvent("REMOVE.ITENS", "view");
				this.removeContent();
				this._shadow.hide();
			}
		}
		private function convertToMm(px:Number):Number
		{
			return( Math.ceil(Math.abs((500*px)/750)) );
		}
		private function convertToPx(mm:Number):Number
		{
			return( Math.ceil(Math.abs((750*mm)/500)) );
		}
	}
}