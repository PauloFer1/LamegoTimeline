package com.tarambola.view.tools.ui
{
	import feathers.controls.ImageLoader;
	import feathers.controls.List;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.core.FeathersControl;
	
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import starling.animation.Tween;
	import starling.events.Touch;

	public class VerticalGalleryItemRenderes extends FeathersControl implements IListItemRenderer
	{
		private static const HELPER_POINT:Point = new Point();
		private static const HELPER_TOUCHES_VECTOR:Vector.<Touch> = new <Touch>[];
		
		private static const CACHED_BOUNDS:Dictionary = new Dictionary(false);
		
		protected var image:ImageLoader;
		protected var touchPointID:int = -1;
		protected var fadeTween:Tween;
		private var _index:int = -1;
		protected var _owner:List;
		protected var _isSelected:Boolean;
		private var _data:GalleryItem;
		private var _text:TextField;
		
		public function VerticalGalleryItemRenderes()
		{
		}
	}
}