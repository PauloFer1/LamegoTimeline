package
{
	import com.tarambola.ErrorDisplay;
	import com.tarambola.controller.Controller;
	import com.tarambola.controller.NavEvents;
	import com.tarambola.model.Classes.Arq;
	import com.tarambola.model.Classes.Constants;
	import com.tarambola.model.Model;
	import com.tarambola.view.View;
	import com.tarambola.view.screens.ScreenSaver;
	import com.tarambola.view.tools.ui.VideoShadowBox;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.media.Video;
	import flash.system.Capabilities;
	import flash.ui.Mouse;
	import flash.utils.Timer;
	
	import starling.core.Starling;
	import starling.events.Event;
	import starling.utils.RectangleUtil;
	import starling.utils.ScaleMode;
	
	[SWF(frameRate="30", width="768", height="1360", backgroundColor="#AC0139")]
	public class LamegoTimeline extends Sprite
	{
		private var model:Model;
		private var view:View;
		private var controller:Controller;
		
		private var starling:Starling;
		
		private var timer:Timer;
		private var isMouse:uint=0;
		private var _video:VideoShadowBox;
		private var _saver:ScreenSaver;
		
		public function LamegoTimeline()
		{
			super();
			
			stage.nativeWindow.alwaysInFront=true;
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.EXACT_FIT;
			stage.nativeWindow.visible = true;
			
			this.addEventListener(flash.events.Event.ADDED_TO_STAGE, addToStage);
		}
		protected function addToStage(event:flash.events.Event):void
		{
			this.removeEventListener(flash.events.Event.ADDED_TO_STAGE, addToStage);
			
			this.stage.nativeWindow.x = (Capabilities.screenResolutionX - this.stage.nativeWindow.width) / 2;
			this.stage.nativeWindow.y = (Capabilities.screenResolutionY - this.stage.nativeWindow.height) / 2;
			
			var stageWidth:int   = stage.stageWidth;
			var stageHeight:int  = stage.stageHeight;
			
			Starling.multitouchEnabled = false;
			
			var viewPort:Rectangle = RectangleUtil.fit(
				new Rectangle(0, 0, stageWidth, stageHeight), 
				new Rectangle(0, 0, stageWidth, stageHeight), 
				ScaleMode.NONE);
			
			ErrorDisplay.getInstance().init(stage, this);
			this.model = new Model();
			this.controller = new Controller(this.model);
			Arq.getInstance().init(model, controller);
			
			this.starling = new Starling(View, stage, viewPort);
			Starling.current.stage.addEventListener("ALL.LOADED", removeInitBg);
			this.starling.stage.stageWidth = stageWidth;
			this.starling.stage.stageHeight = stageHeight;
			this.starling.antiAliasing = 1;
			this.starling.showStats = true;
			this.starling.showStatsAt("left", "bottom");
			
			this.starling.addEventListener(starling.events.Event.ROOT_CREATED, onRootCreated);
			
			this.timer = new Timer(500, 1);
			this.timer.addEventListener(TimerEvent.TIMER_COMPLETE, setWindow);
			this.timer.start();
			this.hideMouse();	
			//	stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
			
			NavEvents.getInstance().addEventListener("VIDEO.PLAY", playVideo);
			ScreenSaver.getInstance().setStage(stage);
		}
		private function onRootCreated():void
		{
			this.starling.removeEventListener(starling.events.Event.ROOT_CREATED, onRootCreated);
			this.model.init();
			this.starling.start();
		}
				
		private function removeInitBg():void
		{
			// TODO Auto Generated method stub
			
		}
		private function setWindow(evt:TimerEvent=null):void
		{
			this.timer.stop();
			this.timer.removeEventListener(TimerEvent.TIMER_COMPLETE, setWindow);
			//stage.displayState = StageDisplayState.NORMAL;
			stage.nativeWindow.activate();
			stage.nativeWindow.orderToBack();
			stage.nativeWindow.orderToFront();
			//Mouse.hide();
			//this.isMouse=0;
		}
		private function hideMouse():void
		{
			stage.nativeWindow.activate();
			stage.nativeWindow.orderToBack();
			stage.nativeWindow.orderToFront();
		//	Mouse.hide();
		//	this.isMouse=0;
		}
		private function playVideo(evt:Event):void
		{
			this._video = new VideoShadowBox(stage, evt.data.id);
			this.addChild(this._video);
		}
	}
}