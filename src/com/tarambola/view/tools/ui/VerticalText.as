package com.tarambola.view.tools.ui
{
	import com.tarambola.model.Classes.Arq;
	import com.tarambola.model.Classes.Fonts;
	
	import feathers.controls.PanelScreen;
	import feathers.controls.ScrollContainer;
	import feathers.events.FeathersEventType;
	import feathers.layout.VerticalLayout;
	
	import flash.display3D.Context3DBlendFactor;
	
	import starling.display.BlendMode;
	import starling.display.Image;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.RenderTexture;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	public class VerticalText extends PanelScreen
	{
		private var _text:TextField;
		
		public function VerticalText()
		{
			super();
			this.addEventListener(FeathersEventType.INITIALIZE, initializeHandler);
		}
		
		private function initializeHandler():void
		{
			const layout:VerticalLayout = new VerticalLayout();

			layout.gap = 0;
			layout.paddingTop = 8;
			layout.paddingRight = 2
			layout.paddingBottom = 0;
			layout.paddingLeft = 2;
			layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_LEFT;
			layout.verticalAlign = VerticalLayout.VERTICAL_ALIGN_TOP;
			layout.manageVisibility = true;
			layout.useVirtualLayout = true;
			layout.afterVirtualizedItemCount = 0;
			this.width =200;
			this.height = 300;
			
			
			this.layout = layout;
			
			this.verticalScrollPolicy = ScrollContainer.SCROLL_POLICY_ON;
			this.snapScrollPositionsToPixels = true;
			
			var font2:BitmapFont = Fonts.getInstance().getFont("NeoSans");
			this._text = new TextField(180,400, "Integer turpis est, aliquet sed rutrum a, hendrerit volutpat ante. In pulvinar bibendum velit, ac aliquet velit pharetra in. Integer turpis est, aliquet sed rutrum a, hendrerit vol is est, aliquet sed rutrum a, hendrerit volutpat ante. In pulvinar bibendum velit, ac aliquet velit pharetra in. Integer turpis est, aliquet sed rutrum a, hendrerit vol is est, aliquet sed rutrum a, hendrerit volutpat ante. In pulvinar bibendum velit, ac aliquet velit pharetra in. Integer turpis est, aliquet sed rutrum a, hendrerit vol is est, aliquet sed rutrum a, hendrerit volutpat ante. In pulvinar bibendum velit, ac aliquet velit pharetra in. Integer turpis est, aliquet sed rutrum a, hendrerit vol is est, aliquet sed rutrum a, hendrerit volutpat ante. In pulvinar bibendum velit, ac aliquet velit pharetra in. Integer turpis est, aliquet sed rutrum a, hendrerit vol is est, aliquet sed rutrum a, hendrerit volutpat ante. In pulvinar bibendum velit, ac aliquet velit pharetra in. Integer turpis est, aliquet sed rutrum a, hendrerit vol is est, aliquet sed rutrum a, hendrerit volutpat ante. In pulvinar bibendum velit, ac aliquet velit pharetra in. Integer turpis est, aliquet sed rutrum a, hendrerit vol is est, aliquet sed rutrum a, hendrerit volutpat ante. In pulvinar bibendum velit, ac aliquet velit pharetra in. Integer turpis est, aliquet sed rutrum a, hendrerit volutpat ante. In pulvinar bibendum velit, ac aliquet velit pharetra in. Integer turpis est, aliquet sed rutrum a", font2.name, 13, 0x5A4A42);
			this._text.hAlign = HAlign.LEFT;
			this._text.vAlign = VAlign.TOP;
			
			
			this.addChild(this._text);
		}
		public function setText(text:String, w:uint = 180):void
		{
			this._text.width = w;
			this._text.text = text;
			this._text.height = this._text.textBounds.height+10;
		}
		public function gotoStart():void
		{
			this.scrollToPosition(0, 0);
		}
	}
}