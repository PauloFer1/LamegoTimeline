package com.tarambola.view.tools.ui
{
	
	import com.greensock.TweenLite;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.AsyncErrorEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.NetDataEvent;
	import flash.events.NetStatusEvent;
	import flash.filesystem.File;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.DropShadowFilter;
	import flash.media.SoundTransform;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	
	import flashx.textLayout.debug.assert;
	
	public class VideoPlayer extends Sprite
	{
		private var _stage:Stage;
		
		private var ns:NetStream;
		private var options:VideoBar;
		private var isPlay:uint=0;
		private var isMute:uint=0;
		private var metadata:Object;
		private var duration:Number=0;
		private var firstPlay:uint=1;
		private var showOpt:Boolean;
		private var vid:Video;
		
		public function VideoPlayer(caminho:String, showOpt:Boolean=true)
		{
			var video:Video;
			var ratio:uint=0;
			var id:uint=0;
			var nc:NetConnection = new NetConnection();
			nc.connect(null);
			this.ns = new NetStream(nc);
			this.ns.client = {};
			this.ns.client.onMetaData = onmetadata;
			this.vid = new Video();
			
			if(showOpt)
				this.options =new VideoBar();			
			
			//ns.client={onMetaData:function(obj:Object):void{} }
			ns.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
			//******************** APP ROMANO MEDIEVAL
			ns.play(caminho);
			//******************** APP PRÉ HISTORIA
			//ns.play(File.applicationDirectory.resolvePath("files").resolvePath("videos2").resolvePath(caminho).url);
			ns.addEventListener(NetStatusEvent.NET_STATUS, loop);
			ns.addEventListener(NetDataEvent.MEDIA_TYPE_DATA, onmetadata);
			ns.pause();
			
			vid.attachNetStream(ns);
			vid.width = 553;
			addChild(vid);
			
			if(showOpt)
			{
				this.options.y=vid.height;
				this.options.playButton.addEventListener(MouseEvent.CLICK, playHandler);
				this.options.muteBtn.addEventListener(MouseEvent.CLICK, muteHandler);
				this.addChild(this.options);
				
				this.options.totalBar.addEventListener(MouseEvent.CLICK, seekBar);
				this.addEventListener(Event.ENTER_FRAME, update);
			}
		}
		
		protected function seekBar(event:MouseEvent):void
		{
			var seek:Number =mouseX - this.options.totalBar.x + 20;
			this.ns.seek((seek*this.duration)/this.options.totalBar.width-3);
			
			this.options.progressBar.width = this.ns.time*this.options.totalBar.width / this.duration ;
		}
		private function onmetadata(obj:Object):void
		{
			this.metadata=obj;
			for(var o:* in  obj)
			{
				if(o=="duration")
					this.duration=obj[o];
			}
			if(this.firstPlay==1)
			{
				this._playExt();
				this.firstPlay=0;
				var r:Number = 800/this.vid.videoWidth;
				this.vid.y = this.vid.height/2 - (this.vid.videoHeight*r)/2;
				this.vid.width = 800;
				this.vid.height = this.vid.videoHeight * r;
				if(this.showOpt)
				{
					this.options.y=vid.y + vid.height;
				}
			}
		}
		protected function loop(event:NetStatusEvent):void
		{
			if(event.info.code == "NetStream.Play.Stop")
			{
				this.isPlay=0;
				this.dispatchEvent(new Event("STARTSCREEN"));
				if(this.showOpt)
				{
					this.options.playButton.gotoAndStop(1);
					this.options.progressBar.width=1;
				}
				this.ns.seek(0);
				this.ns.pause();
			}
		}
		private function update(evt:Event):void
		{
			if(this.showOpt)
				this.options.progressBar.width = this.ns.time*this.options.totalBar.width / this.duration ;
			var scds:uint=this.ns.time % 60;
			var mnts:uint=(this.ns.time/60) % 60;
			var ss:String;
			if(scds<10)
				ss="0" + scds.toString();
			else
				ss=scds.toString();
			if(mnts<10)
				this.options.texto.text = "0" + mnts + ":" + ss;
			else
				this.options.texto.text = mnts + ":" + ss;
		}
		protected function pauseHandler(event:MouseEvent):void
		{
			this.ns.pause();
			
		}
		
		protected function playHandler(event:MouseEvent):void
		{
			if(this.isPlay==0)
			{
				this.ns.resume();
				this.isPlay=1;
				this.options.playButton.gotoAndStop(2);
				this.dispatchEvent(new Event("STOPSCREEN"));
			}
			else
			{
				this.ns.pause();
				this.isPlay=0;
				this.options.playButton.gotoAndStop(1);
				this.dispatchEvent(new Event("STARTSCREEN"));
			}
		}
		protected function muteHandler(event:MouseEvent):void
		{
			var s:SoundTransform;
			if(this.isMute==0)
			{
				s = new SoundTransform(0);
				this.ns.soundTransform=s;
				this.isMute=1;
				this.options.muteBtn.gotoAndStop(2);
			}
			else
			{
				s = new SoundTransform(1);
				this.ns.soundTransform=s;
				this.isMute=0;
				this.options.muteBtn.gotoAndStop(1);
			}
		}
		private function asyncErrorHandler(event:AsyncErrorEvent):void
		{
			
		}
		public function _play():void
		{
			this.ns.seek(0);
			this.ns.resume();
		}
		public function _playExt():void
		{
			this.options.playButton.gotoAndStop(2);
			this.ns.seek(0);
			this.ns.resume();
			this.isPlay=1;
		}
		public function _stop():void
		{
			this.ns.pause();
		}
		public function get _isPlay():uint
		{
			return(this.isPlay);
		}
		
	}
	
}