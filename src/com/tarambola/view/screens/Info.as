package com.tarambola.view.screens
{
	import com.tarambola.model.Classes.Arq;
	import com.tarambola.model.Classes.Constants;
	import com.tarambola.model.Classes.Fonts;
	import com.tarambola.view.tools.ui.VerticalText;
	
	import feathers.controls.Button;
	import feathers.controls.IScrollBar;
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.controls.ScrollBar;
	import feathers.controls.Scroller;
	import feathers.controls.Slider;
	
	import flash.display3D.Context3DBlendFactor;
	
	import starling.animation.Tween;
	import starling.display.BlendMode;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.extensions.pixelmask.PixelMaskDisplayObject;
	import starling.filters.FragmentFilter;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	public class Info extends Screen
	{
		private var _title:TextField;
		
		private var _scrollText:VerticalText;
		private var _maskIMG:Image;
		private var _mask:PixelMaskDisplayObject;
		
		
		public function Info(name:String)
		{
			super(name);
			
			this.addEventListener(Event.ADDED_TO_STAGE, build);
			
		}
		public function build():void
		{
			this.alpha=0;
			
			var font:BitmapFont;
			if(Constants.getInstance().actUI == Constants.UI1)
				font = Fonts.getInstance().getFont("Museo700-Regular");
			else
				font = Fonts.getInstance().getFont("StantonICG");
			this._title = new TextField(200, 100, "A importância do Comércio", font.name, 16, 0X991C24);
			this._title.hAlign = HAlign.CENTER;
			this._title.vAlign = VAlign.TOP;
			
			this.addChild(this._title);
			//new AeonDesktopTheme();
			this._scrollText = new VerticalText();
				 
			this._scrollText.maxHeight = 300;
			this._scrollText.clipContent = false;
			this._scrollText.scrollBarDisplayMode = Scroller.SCROLL_BAR_DISPLAY_MODE_FIXED;
			this._scrollText.verticalScrollBarFactory = function():IScrollBar{
				var s:ScrollBar = new ScrollBar();
				s.thumbFactory = function():Button{
					var button:Button = new Button();
					button.defaultSkin = new Image( Arq.getInstance().model.asset.getTexture("scroller_"+Constants.getInstance().actUI) );
					button.downSkin = new Image( Arq.getInstance().model.asset.getTexture("scroller_"+Constants.getInstance().actUI) );
					button.height = 20;
					button.maxHeight = 20;
					button.alpha=0.5;
					return button;
				};
				s._fixedHeight = 50;
				s.direction = ScrollBar.DIRECTION_VERTICAL;
				s.alpha=0.5;
				return s;
			};
			
			this._maskIMG = new Image(Arq.getInstance().model.asset.getTexture("mask3"));
			this._maskIMG.width = 300;
			this._maskIMG.height = 300;
			this._mask = new PixelMaskDisplayObject();
			this._mask.mask = this._maskIMG;
			this._mask.addChild(this._scrollText);
			this.addChild(this._mask);
		}
		//************* PUBLIC METHODS ***********//
		public function init(w:uint, h:uint, text:String):void
		{
			var font:BitmapFont;
			var t:String = Arq.getInstance().model.lists[Constants.getInstance().actItens].itens[Constants.getInstance().itemSelected].title.getString(Constants.getInstance().actLang);
			if(t==null || t=="")
				this._title.text = "-";
			else
				this._title.text = t;
			if(Constants.getInstance().actUI == Constants.UI1)
			{
				font = Fonts.getInstance().getFont("Museo700-Regular");
				this._title.fontName = font.name;
				this._title.color = 0X991C24;
				this._title.fontSize = 17;
				this._title.alpha = 1;
				this._title.y = 20;
				this._title.x = h/2 - this._title.width/2;
				this._title.height = this._title.textBounds.height + 10;
				this._scrollText.width = 200;
				this._scrollText.height = 270;
				this._scrollText.y = 0
				this._scrollText.x = 0;
				if(text==null || text=="")
					this._scrollText.setText("-", 190);
				else
					this._scrollText.setText(text, 190);
				
				this._mask.y = this._title.y + this._title.textBounds.height + 10;
				//this._mask.x = h/2 - this._scrollText.width/2;
				this._mask.x=180;
			}
			else
			{
				font = Fonts.getInstance().getFont("StantonICG");
				font.lineHeight = 48;
				this._title.fontName = font.name;
				this._title.color = 0x000000;
				this._title.fontSize = 32;
				this._title.alpha = 0.8;
				this._title.y = 80;
				this._title.x = w/2 - this._title.width/2 - 10;
				this._title.height = this._title.textBounds.height + 20;
				this._scrollText.width = 280;
				this._scrollText.height = 200 - this._title.textBounds.height;
				//this._scrollText.y = this._title.y + this._title.textBounds.height + 10;
				//this._scrollText.x = w/2 - this._scrollText.width/2 - 10;
				if(text==null || text=="")
					this._scrollText.setText("-", 260);
				else
					this._scrollText.setText(text, 260);
				
				this._mask.y = this._title.y + this._title.textBounds.height + 10;
				this._mask.x = 120;//w/2 - this._scrollText.width/2 - 10;
			}
			
			this._maskIMG.width = this._scrollText.width+10;
			this._maskIMG.height = this._scrollText.height;
			this._mask.mask = this._maskIMG;
			
			this.visible = true;
		}
	}
}