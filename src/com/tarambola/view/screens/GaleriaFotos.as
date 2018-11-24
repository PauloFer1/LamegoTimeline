package com.tarambola.view.screens
{
	import com.tarambola.model.Classes.Arq;
	import com.tarambola.model.Classes.Constants;
	import com.tarambola.model.Classes.Fonts;
	import com.tarambola.model.Classes.GalleryItem;
	import com.tarambola.model.Classes.ImageModel;
	import com.tarambola.view.tools.ui.GalleryItemRenderer;
	
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.data.ListCollection;
	import feathers.layout.HorizontalLayout;
	
	import flash.filesystem.File;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	import starling.events.ResizeEvent;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	public class GaleriaFotos extends Screen
	{
		private var _path:File;
		protected var _list:List;
		protected var _originalImageWidth:Number;
		protected var _originalImageHeight:Number;
		
		private var _arrowLeft:Button;
		private var _arrowRight:Button;
		private var _title:TextField;
		
		private var _actPage:uint=0;
		
		public function GaleriaFotos(name:String)
		{
			super(name);
			this.alpha = 0;
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			this.addEventListener(Event.ENTER_FRAME, update);
		}
		//************* PRIVATE METHODS ************//
		protected function layout():void
		{
			//this.x = 90;
			//this.y = 50;
			
			this._list.width = 220;
			this._list.height = 210;
		}
		//************* HANDLERS **************//
		protected function addedToStageHandler(event:Event=null):void
		{
			var font:BitmapFont = Fonts.getInstance().getFont("Museo700-Regular");
			this._title = new TextField(200, 100, Arq.getInstance().model.getTrad("galeria", Constants.getInstance().actLang), font.name, 16, 0X991C24);
			this._title.hAlign = HAlign.CENTER;
			this._title.vAlign = VAlign.TOP;

			
			this._arrowLeft = new Button(Arq.getInstance().model.asset.getTexture("seta_lado_"+Constants.getInstance().actUI));
			this._arrowRight = new Button(Arq.getInstance().model.asset.getTexture("seta_lado_"+Constants.getInstance().actUI));
			this._arrowLeft.addEventListener(Event.TRIGGERED, showPrevious);
			this._arrowRight.addEventListener(Event.TRIGGERED, showNext);
			this._arrowLeft.visible=false;
			this._arrowLeft.pivotX = this._arrowLeft.width/2;
			this._arrowRight.pivotX = this._arrowLeft.width/2;
			this._arrowLeft.pivotY = this._arrowLeft.height/2;
			this._arrowRight.pivotY = this._arrowLeft.height/2;
			this._arrowLeft.rotation = Math.PI;
			this._path = File.applicationDirectory.resolvePath("files").resolvePath("images");
			
			if(Constants.getInstance().actUI==Constants.UI1)
			{
				this._arrowLeft.x = 130;
				this._arrowRight.x=408;
				this._arrowLeft.y=180;
				this._arrowRight.y=180;
				this._title.y = 20;
			}
			else{
				this._arrowLeft.x = 0;
				this._arrowRight.x=430;
				this._arrowLeft.y=192;
				this._arrowRight.y=160;
				this._title.y = 40;
			}
			
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
			
			this.layout();
		}
		
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
		protected function stage_resizeHandler(event:ResizeEvent):void
		{
			this.layout();
		}
		//***************** PUBLIC METHODS ***************//
		public function init(w:uint, h:uint):void
		{
			var font:BitmapFont;
			if(Constants.getInstance().actUI == Constants.UI1)
			{
				this._arrowLeft.x = 130;
				this._arrowRight.x=408;
				this._arrowLeft.y=170;
				this._arrowRight.y=170;
				this._title.y = 20;
				
				font = Fonts.getInstance().getFont("Museo700-Regular");
				this._title.text = Arq.getInstance().model.getTrad("galeria", Constants.getInstance().actLang);
				this._title.fontName = font.name;
				this._title.color = 0X991C24;
				this._title.fontSize = 16;
				this._title.alpha = 1;
				this._title.height = 100;
				this._title.y = 60;
			}
			else
			{
				this._arrowLeft.x =64;
				this._arrowRight.x=450;
				this._arrowLeft.y=180;
				this._arrowRight.y=180;
				this._title.y = 76;
				
				font = Fonts.getInstance().getFont("StantonICG");
				this._title.fontName = font.name;
				this._title.color = 0x000000;
				this._title.fontSize = 32;
				this._title.alpha = 0.8;
				this._title.text = Arq.getInstance().model.getTrad("galeria", Constants.getInstance().actLang);
				this._title.height = this._title.getBounds(this).height + 10;
			}
			
			if(this._list.dataProvider!= null)
			{
				this._list.dataProvider.removeAll();
			}
			const items:Vector.<GalleryItem> = new <GalleryItem>[];
			
			var gallery:Vector.<ImageModel> = Arq.getInstance().model.lists[Constants.getInstance().actItens].itens[Constants.getInstance().itemSelected].gallery;
			for(var i:int = 0; i <gallery.length; i++)
			{
				items.push(new GalleryItem(gallery[i].text.getString(Constants.getInstance().actLang), Constants.imagesPath.resolvePath(gallery[i].path).url, gallery[i].text.getString(Constants.getInstance().actLang)));
			}
			
			this._list.dataProvider = new ListCollection(items);
			this._list.selectedIndex = 0;
			this._list.dataProvider.updateItemAt(0);
			this._title.x = w/2 - this._title.width/2;
			this._list.x = w/2 - this._list.width/2;
			this._list.y = this._title.y + this._title.textBounds.height +10;
			
			if(this._list.horizontalPageCount==0)
				this._arrowRight.visible=false;
			
			this._list.scrollToPageIndex(0,0);
		}
	}
}