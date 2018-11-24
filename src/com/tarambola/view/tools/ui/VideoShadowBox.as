package com.tarambola.view.tools.ui
{
	import com.tarambola.Draw;
	import com.tarambola.controller.NavEvents;
	import com.tarambola.model.Classes.Arq;
	import com.tarambola.model.Classes.Constants;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	
	public class VideoShadowBox extends Sprite
	{
		private var _player:VideoPlayer;
		private var _closeBtn:CloseBtn;
		
		public function VideoShadowBox(stage:Stage, id:uint)
		{
			super();
			var bg:Shape = Draw.dRect(stage.stageWidth, stage.stageHeight, 0x000000);
			bg.alpha = 0.7;
			this.addChild(bg);
			this._player =new VideoPlayer(Constants.videosPath.resolvePath(Arq.getInstance().model.lists[Constants.getInstance().actItens].itens[Constants.getInstance().itemSelected].videoGallery[id].path).url);
			this._player.x = stage.stageWidth/2 - this._player.width/2;
			this._player.y = stage.stageHeight/2 - this._player.height/2;
			
			this.addChild(this._player);
			
			this._closeBtn = new CloseBtn();
			this._closeBtn.addEventListener(MouseEvent.CLICK, close);
			this._closeBtn.y = this._player.y - this._closeBtn.height-5;
			this._closeBtn.x = this._player.x + this._player.width;
			this.addChild(this._closeBtn);
		}
		
		protected function close(event:MouseEvent):void
		{
			this._closeBtn.removeEventListener(MouseEvent.CLICK, close);
			NavEvents.getInstance().dispatchCustomEvent("VIDEO.CLOSE", "videoshadow");
			this._player._stop();
			this.parent.removeChild(this);
		}
	}
}