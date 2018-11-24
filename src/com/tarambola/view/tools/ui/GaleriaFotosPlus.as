package com.tarambola.view.tools.ui
{
	import com.tarambola.controller.NavEvents;
	import com.tarambola.model.Classes.Arq;
	import com.tarambola.model.Classes.Constants;
	import com.tarambola.model.Classes.Fonts;
	import com.tarambola.model.Classes.GalleryItem;
	import com.tarambola.model.Classes.GalleryModel;
	import com.tarambola.model.Classes.ImageModel;
	
	import feathers.controls.List;
	import feathers.data.ListCollection;
	import feathers.layout.HorizontalLayout;
	
	import flash.filesystem.File;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.ResizeEvent;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	public class GaleriaFotosPlus extends Sprite
	{
		protected var _list:List;
		protected var _originalImageWidth:Number;
		protected var _originalImageHeight:Number;
		
		private var _arrowLeft:Button;
		private var _arrowRight:Button;
		private var _title:TextField;
		private var _backBtn:Button;
		
		public function GaleriaFotosPlus()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			this.addEventListener(Event.ENTER_FRAME, update);
		}
		//************* PRIVATE METHODS ************//
		protected function layout():void
		{

			this._list.width = 220;
			this._list.height = 210;
		}
		//************* HANDLERS **************//
		private function update():void
		{
			if(this._list.horizontalPageIndex+1==this._list.horizontalPageCount)
				this._arrowRight.visible=false;
			else
				this._arrowRight.visible=true;
			if(this._list.horizontalPageIndex==0)
				this._arrowLeft.visible=false;
			else
				this._arrowLeft.visible=true;
			if(this._list.horizontalPageIndex==0)
				this._arrowLeft.visible=false;
			else
				this._arrowLeft.visible=true;
		}
		private function showPrevious():void
		{
			if((this._list.horizontalPageIndex-1)>=0)
			{
				this._list.scrollToPageIndex((this._list.horizontalPageIndex-1),0,0.4);
			}
		}
		
		private function showNext():void
		{
			if((this._list.horizontalPageIndex+1)<=this._list.horizontalPageCount)
			{
				this._list.scrollToPageIndex((this._list.horizontalPageIndex+1),0,0.4);
			}
		}
		protected function addedToStageHandler(event:Event=null):void
		{
			var font:BitmapFont = Fonts.getInstance().getFont("Museo700-Regular");
			this._title = new TextField(200, 100, "SABER MAIS", font.name, 16, 0X991C24);
			this._title.hAlign = HAlign.CENTER;
			this._title.vAlign = VAlign.TOP;
			
			
			this._arrowLeft = new Button(Arq.getInstance().model.asset.getTexture("seta_lado_"+Constants.getInstance().actUI));
			this._arrowRight = new Button(Arq.getInstance().model.asset.getTexture("seta_lado_"+Constants.getInstance().actUI));
			this._arrowLeft.addEventListener(Event.TRIGGERED, showPrevious);
			this._arrowRight.addEventListener(Event.TRIGGERED, showNext);
			this._arrowLeft.pivotX = this._arrowLeft.width/2;
			this._arrowRight.pivotX = this._arrowLeft.width/2;
			this._arrowLeft.pivotY = this._arrowLeft.height/2;
			this._arrowRight.pivotY = this._arrowLeft.height/2;
			this._backBtn = new Button(Arq.getInstance().model.asset.getTexture("voltar_btn_"+Constants.getInstance().actUI));
			this.addChild(this._backBtn);
			this._backBtn.addEventListener(Event.TRIGGERED, goBack);
			
			this._arrowLeft.rotation = Math.PI;
			
			this.addChild(this._title);
			this.addChild(this._arrowLeft);
			this.addChild(this._arrowRight);
			
			this.stage.addEventListener(ResizeEvent.RESIZE, stage_resizeHandler);
			
			const listLayout:HorizontalLayout = new HorizontalLayout();
			listLayout.verticalAlign = HorizontalLayout.VERTICAL_ALIGN_JUSTIFY;
			listLayout.hasVariableItemDimensions = true;
			listLayout.manageVisibility = true;
			listLayout.useVirtualLayout = true;
			
			this._list = new List();
			this._list.layout = listLayout;
			this._list.horizontalScrollPolicy = List.SCROLL_POLICY_ON;
			this._list.snapToPages = true;
			this._list.itemRendererType = GalleryItemRenderer;
			this.addChild(this._list);
			
			this._arrowLeft.x = 50;
			this._arrowRight.x = 435;
			this._arrowLeft.y=200;
			this._arrowRight.y=200;
			this._title.y = 50;
			
			this.layout();
		}
		protected function stage_resizeHandler(event:ResizeEvent):void
		{
			this.layout();
		}
		//***************** HANDLERS ******************//
		private function goBack():void
		{
			NavEvents.getInstance().dispatchCustomEvent("BACK.PLUS", "fotosplus");
		}
		//***************** PUBLIC METHODS ***************//
		public function init(id:uint, w:uint, h:uint):void
		{
			var font:BitmapFont;
			if(Constants.getInstance().actUI == Constants.UI1)
			{
				this._arrowLeft.x = 20;
				this._arrowRight.x=330;
				this._arrowLeft.y=110;
				this._arrowRight.y=108;
				this._title.y = 20;
				
				font = Fonts.getInstance().getFont("Museo700-Regular");
				this._title.text = Arq.getInstance().model.getTrad("mais", Constants.getInstance().actLang);
				this._title.fontName = font.name;
				this._title.color = 0X991C24;
				this._title.fontSize = 16;
				this._title.alpha = 1;
				this._title.height = this._title.textBounds.height + 5;
				
				this._backBtn.x = 0;
				this._backBtn.y = 204;
				
				this._title.x = w/2 - this._title.width/2;
				this._title.y = 0;
				this._title.height = this._title.textBounds.height +10;
				
				this._list.x = w/2 - this._list.width/2;
				this._list.y = this._title.y + this._title.textBounds.height+10;
			}
			else
			{
				this._arrowLeft.x = -30;
				this._arrowRight.x=322;
				this._arrowLeft.y=180;
				this._arrowRight.y=180;
				this._title.y = 20;
				
				font = Fonts.getInstance().getFont("StantonICG");
				
				this._title.fontName = font.name;
				this._title.color = 0x000000;
				this._title.fontSize = 32;
				this._title.alpha = 0.8;
				this._title.height = 100;
				this._title.text = Arq.getInstance().model.getTrad("mais", Constants.getInstance().actLang);
				this._backBtn.x = -50;
				this._backBtn.y = h-this._backBtn.height-18;
				
				this._list.x = w/2 - this._list.width/2 - 30; 
				this._list.y = this._title.y + this._title.textBounds.height + 40;
				this._title.x = 40;
			}
			
			
			
			if(this._list.dataProvider!= null)
			{
				this._list.dataProvider.removeAll();
			}
			const items:Vector.<GalleryItem> = new <GalleryItem>[];

			
			var gallery:GalleryModel = Arq.getInstance().model.lists[Constants.getInstance().actItens].itens[Constants.getInstance().itemSelected].plus.galleries[id];
			for(var i:int = 0; i <gallery.gallery.length; i++)
			{
				items.push(new GalleryItem("OK", Constants.imagesPath.resolvePath(gallery.gallery[i].path).url, gallery.gallery[i].text.getString(Constants.getInstance().actLang)));
			}
			
			this._list.dataProvider = new ListCollection(items);
			this._list.selectedIndex = 0;
			this._list.dataProvider.updateItemAt(0);
			
			this._list.scrollToPageIndex(0,0);
			
		}
	}
}