package com.tarambola.controller
{
	import com.tarambola.ErrorDisplay;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TimerEvent;
	import flash.net.Socket;
	import flash.utils.Timer;

	public class DistanceController
	{
		static private var _instance:DistanceController;
		
		private const MIN_VALUE:uint = 180 - MIN_VALUE; 
		private const MAX_VALUE:uint = 5800;
		private var _distance:uint = MIN_VALUE;
		
		private var _socket:Socket;
		private var _timer:Timer;
		private var _isConnected:Boolean =false;
		private var _isFirst:Boolean = true;
		private var _isTimer:Boolean = false;
		private var _tragic:Boolean = false;
		private var _tragicDist:Number;
		
		private var _distancetimer:Timer;
		
		public function DistanceController(SingletonEnforcer:SingletonEnforcer)
		{
		}
		public static function getInstance():DistanceController
		{
			if(DistanceController._instance == null)
			{
				DistanceController._instance = new DistanceController(new SingletonEnforcer());
			}
			return(DistanceController._instance);
		}
		//********* PUBLIC METHODS ***********//
		public function init():void
		{
			this._distancetimer = new Timer(2000);
			this._distancetimer.addEventListener(TimerEvent.TIMER, distanceHandler);
			
			this._timer = new Timer(2000);
			this._socket = new Socket("localhost", 8000);
			this._timer.addEventListener(TimerEvent.TIMER, retry);
			this._timer.start();
			this._socket.addEventListener(Event.CLOSE, closeHandler);
			this._socket.addEventListener(Event.CONNECT, connectHandler);
			this._socket.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			this._socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			this._socket.addEventListener(ProgressEvent.SOCKET_DATA, socketDataHandler);
			
			//ErrorDisplay.getInstance().buildContinuos();
		}
		//*************** HANDLERS ****************//
		protected function retry(event:TimerEvent):void
		{
			if(!this._isConnected)
				this._socket.connect("localhost", 8000);
		}
		private function closeHandler(event:Event):void 
		{
			ErrorDisplay.getInstance().showError("Close Socket!");
		}
		private function connectHandler(event:Event):void 
		{
			this._timer.stop();
			ErrorDisplay.getInstance().showError("Connect Socket!");
			NavEvents.getInstance().dispatchCustomEvent("CONTROLLER.READY", "distancecontroller");
			this._isConnected = true;
		}
		private function ioErrorHandler(event:IOErrorEvent):void 
		{
			ErrorDisplay.getInstance().showError("IO ERROR: " + event);
		}
		
		private function securityErrorHandler(event:SecurityErrorEvent):void 
		{
			ErrorDisplay.getInstance().showError("Security Error: " + event);
		}
		private function socketDataHandler(event:ProgressEvent):void 
		{
			var dist:uint = Math.abs(Number(this._socket.readUTFBytes(this._socket.bytesAvailable))/10);
			dist = dist*10;
			if(this._isFirst)
			{
				this._distance=dist;
				this._isFirst = false;
			}
			if(Math.abs(dist - this._distance) > 10 && Math.abs(dist - this._distance) < 100 && dist < MAX_VALUE && dist > MIN_VALUE)
			{
				this._distancetimer.reset();
				this._distancetimer.stop();
				this._tragic = false;
				this._isTimer=false;
				//ErrorDisplay.getInstance().showContinuos("Distância OK: " + dist.toString());
			//	ErrorDisplay.getInstance().showError("DISTANCIA OK: " + dist.toString());
				this._distance = dist;
			}
			else if(!this._isTimer && Math.abs(dist - this._distance) > 100 && this._tragic==false && dist < MAX_VALUE && dist > MIN_VALUE){
				this._isTimer = true;
				this._tragic = true;
				//ErrorDisplay.getInstance().showContinuos("ELSE");
				this._distancetimer.start();
				this._tragicDist = dist ;
			}
			else if(Math.abs(dist - this._distance) < 10)
			{
				this._distancetimer.reset();
				this._distancetimer.stop();
				this._tragic = false;
				this._isTimer=false;
			}
		}
		protected function distanceHandler(event:TimerEvent):void
		{
			this._distancetimer.reset();
			this._distancetimer.stop();
			this._tragic = false;
			this._isTimer=false;
			this._distance = this._tragicDist;
			//ErrorDisplay.getInstance().showContinuos("Distância TRAGIC: " + this._distance.toString());
			//ErrorDisplay.getInstance().showError("DISTANCIA TRAGIC: " + this._distance.toString());
		}
		public function get distance():uint
		{
			return((this._distance-MIN_VALUE));
		}
		public function set distance(dist:uint):void
		{
			this._distance = dist;
		}
		public function increase():void
		{
			if(this._distance<this.MAX_VALUE)
				this._distance+=10;
		}
		public function decrease():void
		{
			if(this._distance>0)
				this._distance-=10;
		}
	}
}
class SingletonEnforcer {}