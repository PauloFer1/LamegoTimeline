package com.tarambola.view.screens
{
	import com.tarambola.controller.NavEvents;
	import com.tarambola.model.Classes.Arq;
	import com.tarambola.model.Classes.Constants;
	import com.tarambola.view.tools.ui.VideoPlayer;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class ScreenSaver extends Sprite
	{
		static private var _instance:ScreenSaver;
		
		private var _stage:Stage;
		private var _timer:Timer;
		private var _image:Bitmap;
		public var _isTimer:uint=1;
		private var _player:VideoPlayer;
		
		public function ScreenSaver(SingletonEnforcer:SingletonEnforcer)
		{
					
		}
		public static function getInstance():ScreenSaver
		{
			if(ScreenSaver._instance == null)
			{
				ScreenSaver._instance = new ScreenSaver(new SingletonEnforcer());
			}
			return(ScreenSaver._instance);
		}
		public function setStage(stage:Stage):void
		{
			this._stage = stage;			
			this._stage.addChild(this);
		}
		public function init():void
		{
			this._player = new VideoPlayer(Constants.videosPath.resolvePath(Arq.getInstance().model.screensaverModel.video).url, false);
			this._player.x = this._stage.stageWidth/2 - this._player.width/2;
			this._player.y = this._stage.stageHeight/2 - this._player.height/2 + 30;	
			this._image = Arq.getInstance().model.ScreenSaver;
			this._timer = new Timer(Arq.getInstance().model.screensaverModel.time, 1);
			this._timer.addEventListener(TimerEvent.TIMER_COMPLETE, gotoInit);
			this._stage.addEventListener(MouseEvent.CLICK, resetTimer);
			this._timer.start();
			this.addChild(this._image);
			this.addChild(this._player);
		}
		protected function gotoInit(event:TimerEvent):void
		{
			if(this._isTimer==0)
			{
				this.addChild(this._image);
				this.addChild(this._player);
				NavEvents.getInstance().dispatchCustomEvent("START.SCREEN", "screensaver");
				this._timer.stop();
				this._isTimer=1;
				this._player._play();
			}
		}
		protected function resetTimer(event:MouseEvent=null):void
		{
			if(this._isTimer==0)
			{
				this._timer.stop();
				this._timer.reset();
				this._timer.start();
			}
			else
			{
				this.mouseChildren = false;
				this.removeChild(this._image);
				this.removeChild(this._player);
				this._player._stop();
				this._timer.stop();
				this._timer.reset();
				this._timer.start();
				this._isTimer=0;
				NavEvents.getInstance().dispatchCustomEvent("REMOVE.SCREEN", "screensaver");
			}
		}
		public function reset():void
		{
			if(this._isTimer==0)
			{
				this._timer.stop();
				this._timer.reset();
				this._timer.start();
			}
		}
	}
}
class SingletonEnforcer {}