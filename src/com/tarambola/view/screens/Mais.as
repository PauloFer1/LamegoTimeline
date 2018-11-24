package com.tarambola.view.screens
{
	import com.tarambola.controller.NavEvents;
	import com.tarambola.model.Classes.Arq;
	import com.tarambola.model.Classes.Constants;
	import com.tarambola.model.Classes.Fonts;
	import com.tarambola.model.Classes.GalleryModel;
	import com.tarambola.model.Classes.PlusItem;
	import com.tarambola.view.tools.ui.GaleriaFotosPlus;
	import com.tarambola.view.tools.ui.PlusItemRenderer;
	import com.tarambola.view.tools.ui.VerticalText;
	
	import feathers.controls.Button;
	import feathers.controls.IScrollBar;
	import feathers.controls.List;
	import feathers.controls.ScrollBar;
	import feathers.controls.Scroller;
	import feathers.data.ListCollection;
	import feathers.layout.VerticalLayout;
	
	import flash.filesystem.File;
	import flash.geom.Point;
	
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.extensions.pixelmask.PixelMaskDisplayObject;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	public class Mais extends Screen
	{
		private var _title:TextField;
		
		private var _scrollText:VerticalText;
		private var _maskIMG:Image;
		private var _maskIMG2:Image;
		private var _mask:PixelMaskDisplayObject;
		private var _mask2:PixelMaskDisplayObject;
		private var _list:List;
		private var _tween:Tween;
		private var _galeria:GaleriaFotosPlus;
		private var _size:Point = new Point(0,0);
		
		private var _container:Sprite;
		
		public function Mais(name:String)
		{
			super(name);
			this.addEventListener(Event.ADDED_TO_STAGE, build);
			NavEvents.getInstance().addEventListener("GALLERY.SELECTED", gotoGallery);
			NavEvents.getInstance().addEventListener("BACK.PLUS", removeGallery);
		}
		public function build():void
		{
			this.y = 60;
			this.x = 95;
			this.alpha=0;
			this._galeria = new GaleriaFotosPlus();
			this._galeria.visible= false;
			this._galeria.alpha=0;
			this._container = new Sprite();
			
			var font:BitmapFont = Fonts.getInstance().getFont("Museo700-Regular");
			this._title = new TextField(200, 100, "SABER MAIS", font.name, 16, 0X991C24);
			this._title.hAlign = HAlign.CENTER;
			this._title.vAlign = VAlign.TOP;
			this._title.height = this._title.textBounds.height+10;
			
			
			this._title.x = 0;
			this._title.y = 20;
		
			this._maskIMG = new Image(Arq.getInstance().model.asset.getTexture("mask3"));
			this._maskIMG2 = new Image(Arq.getInstance().model.asset.getTexture("mask3"));
			this._mask = new PixelMaskDisplayObject();
			this._mask2 = new PixelMaskDisplayObject();
			this._maskIMG2.width=185;
			this._maskIMG2.height = 160;
			this._maskIMG.width=185;
			this._maskIMG.height = 300;
			
			this.addChild(this._container);
			this.addChild(this._galeria);
			this._container.addChild(this._title);
			this._scrollText = new VerticalText();
			
			this._scrollText.maxHeight = 200;
			this._scrollText.height = 100;
			this._scrollText.clipContent = true;
			this._scrollText.scrollBarDisplayMode = Scroller.SCROLL_BAR_DISPLAY_MODE_FIXED;
			this._scrollText.verticalScrollBarFactory = function():IScrollBar{
				var s:ScrollBar = new ScrollBar();
				s.thumbFactory = function():Button{
					var button:Button = new Button();
					button.defaultSkin = new Image( Arq.getInstance().model.asset.getTexture("scroller_"+Constants.getInstance().actUI) );
					button.downSkin = new Image( Arq.getInstance().model.asset.getTexture("scroller_"+Constants.getInstance().actUI) );
					button.alpha=0.5;
					return button;
				};
				s.direction = ScrollBar.DIRECTION_VERTICAL;
				s.scaleY = 1;
				s.height=20;
				s.maxHeight=20;
				s.thumbProperties.height = 20;
				s._fixedHeight = 50;
				return s;
			};
			
			this._container.addChild(this._scrollText);
			this._scrollText.height = 180;
			this._scrollText.width = 160;
			//this._scrollText.y = this._title.textBounds.height+30;
			this._mask.addChild(this._scrollText);
			this._scrollText.clipContent=false;
			this._container.addChild(this._mask);
			this._mask.mask = this._maskIMG;
			this._mask.y = this._title.textBounds.height+30;
			//if(Constants.getInstance().actItens!= -1)
				//this._scrollText.setText(Arq.getInstance().model.lists[Constants.getInstance().actItens].itens[Constants.getInstance().itemSelected].plus.text.getString(Constants.getInstance().actLang), 150);
			
			const listLayout:VerticalLayout = new VerticalLayout();
			listLayout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_JUSTIFY;
			listLayout.hasVariableItemDimensions = false;
			listLayout.manageVisibility = true;
			listLayout.useVirtualLayout = true;
			
			this._list = new List();
			this._list.clipContent=false;
			this._list.layout = listLayout;
			this._list.verticalScrollPolicy = List.SCROLL_POLICY_ON;
			this._list.snapScrollPositionsToPixels = true;
			this._list.itemRendererType = PlusItemRenderer;
		//	this._list.x = 180;
			//this._list.y = 20;
			this._list.height = 180;
		//	this._container.addChild(this._list);
			this._mask2.addChild(this._list);
			this._container.addChild(this._mask2);
			this._mask2.mask = this._maskIMG2;
			this._mask2.y = 20;
			this._mask2.x = 180;
		
		}
		//************* PUBLIC METHODS ***********//
		public function setText():void
		{
		//	this._scrollText.setText(Arq.getInstance().model.lists[Constants.getInstance().actItens].itens[Constants.getInstance().itemSelected].plus.text.getString(Constants.getInstance().actLang), 150);
		//	trace("TEXT-> " + Arq.getInstance().model.lists[Constants.getInstance().actItens].itens[Constants.getInstance().itemSelected].plus.text.getString(Constants.getInstance().actLang));
		}
		public function init(w:uint, h:uint):void
		{
			var font:BitmapFont;
			var t:String;
			if(Constants.getInstance().actUI == Constants.UI1)
			{
				font = Fonts.getInstance().getFont("Museo700-Regular");
				this._title.text = Arq.getInstance().model.getTrad("mais", Constants.getInstance().actLang);
				this._title.fontName = font.name;
				this._title.color = 0X991C24;
				this._title.fontSize = 16;
				this._title.alpha = 1;
				this._title.y = 0;
				this._title.x = 52;
				this._title.height = 100;
				t=Arq.getInstance().model.lists[Constants.getInstance().actItens].itens[Constants.getInstance().itemSelected].plus.text.getString(Constants.getInstance().actLang);
				if(t==null || t=="")
					t="-";
				this._scrollText.setText(t, 160);
				this._scrollText.width = 180;
				this._scrollText.height = 190 - this._title.textBounds.height;
				this._maskIMG.height = this._scrollText.height;
				//this._scrollText.y = this._title.y + this._title.textBounds.height + 15;
				this._mask.y = this._title.y + this._title.textBounds.height + 15;
				this._scrollText.x = 0;
				
				//this._list.x = 185;
				//this._list.y = 30;
				this._mask2.x = 185;
				this._mask2.y = 30;
				this._list.height = 180;
			}
			else
			{
				font = Fonts.getInstance().getFont("StantonICG");
				this._title.text = Arq.getInstance().model.getTrad("mais", Constants.getInstance().actLang);
				this._title.fontName = font.name;
				this._title.color = 0x000000;
				this._title.fontSize = 32;
				this._title.alpha = 0.8;
				this._title.y = 20;
				this._title.x = 40;
				this._title.height = 100;
				this._title.width=200;
				this._scrollText.width = 260;
				this._scrollText.height = 180 - this._title.textBounds.height;
				//this._scrollText.y = this._title.y + this._title.textBounds.height + 15;
				this._mask.y = this._title.y + this._title.textBounds.height + 15;
				//this._scrollText.x = 10;
				this._mask.x = 10;
				t=Arq.getInstance().model.lists[Constants.getInstance().actItens].itens[Constants.getInstance().itemSelected].plus.text.getString(Constants.getInstance().actLang);
				if(t==null || t=="")
					t="-";
				this._scrollText.setText(t, 240);
				//this._title.height = this._title.textBounds.height + 100;
				
				//this._list.x = 40;
				//this._list.y = this._scrollText.height + 15;
				this._mask2.x = 40;
				this._mask2.y = this._scrollText.height + 15;
				this._list.height = 180;
				this._maskIMG.height = this._scrollText.height;
				this._mask2.y = this._scrollText.y + this._scrollText.height + 70;
				this._mask2.x=20;
			}
			
			this._maskIMG.width = this._scrollText.width+10;
			this._mask.mask = this._maskIMG;
			
			this._maskIMG2.width = 260;
			this._mask2.mask = this._maskIMG2;
			
			this.setText();
			this._size = new Point(w-this.x*2,h-this.y*2);
			this.visible = true;
			if(this._list.dataProvider!= null)
			{
				this._list.dataProvider.removeAll();
			}
			const items:Vector.<PlusItem> = new <PlusItem>[];
			var gallery:Vector.<GalleryModel> = Arq.getInstance().model.lists[Constants.getInstance().actItens].itens[Constants.getInstance().itemSelected].plus.galleries;
			for(var i:int = 0; i <gallery.length; i++)
			{
				if(gallery[i].gallery.length > 0 )
					items.push(new PlusItem(i, gallery[i].text.getString(Constants.getInstance().actLang), Constants.imagesPath.resolvePath(gallery[i].gallery[0].path).url));
			}
			
			this._list.dataProvider = new ListCollection(items);
			this._list.selectedIndex = 0;
			this._list.dataProvider.updateItemAt(0);
		/*	this._title.x = w/2 - this._title.width/2;
			this._title.y = 60;
			this._title.height = this._title.textBounds.height +10;
			this._list.x = w/2 - this._list.width/2;
			this._list.y = this._title.y + this._title.height;*/
			
						
			this._list.scrollToPosition(0,0);
			this._scrollText.gotoStart();
			this.removeGallery();
		}
		//************** HANDLERS ****************//
		private function gotoGallery(event:Event):void
		{
			this._galeria.x=50;
			this._tween = new  Tween(this._container, 0.2);
			this._tween.animate("alpha", 0);
			this._tween.moveTo(-50, 0);
			this._tween.onComplete = endTween;
			Starling.juggler.add(this._tween);
			this._galeria.init(event.data.id, this._size.x, this._size.y);
			this._galeria.visible=true;
		}
		
		private function endTween():void
		{
			this._container.visible=false;
			Starling.juggler.remove(this._tween);
			
			this._tween = new  Tween(this._galeria, 0.2);
			this._tween.animate("alpha", 1);
			this._tween.moveTo(0,0);
			this._tween.onComplete = endTweenFinal;
			Starling.juggler.add(this._tween);
		}
		private function endTweenFinal():void
		{
			Starling.juggler.remove(this._tween);			
		}
		private function removeGallery():void
		{
			this._tween = new  Tween(this._galeria, 0.2);
			this._tween.animate("alpha", 0);
			this._tween.moveTo(50, 0);
			this._tween.onComplete = endTweenBack;
			Starling.juggler.add(this._tween);
		}
		
		private function endTweenBack():void
		{
			this._container.visible=true;
			this._galeria.visible=false;
			Starling.juggler.remove(this._tween);
			
			this._tween = new  Tween(this._container, 0.2);
			this._tween.animate("alpha", 1);
			this._tween.moveTo(0,0);
			this._tween.onComplete = endTweenFinalBack;
			Starling.juggler.add(this._tween);
		}
		
		private function endTweenFinalBack():void
		{
			Starling.juggler.remove(this._tween);
			this._tween=null;
		}
	}
}