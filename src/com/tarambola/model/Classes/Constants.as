package com.tarambola.model.Classes
{
	import flash.filesystem.File;

	public class Constants
	{
		static private var _instance:Constants;
		
		public static const STAGE_WIDTH:int  = 768;
		public static const STAGE_HEIGHT:int = 1280;
		
		public static const VERSION:Number = 0.1;
		
		private var _scale:Number;
		private var _scaleY:Number;
		
		private var _realWidth:uint;
		private var _realHeight:uint;
		private var _actItens:Number=-1;
		private var _itemSelected:uint=0;
		
		//****** PUBLIC CONSTS ********//
		
		//******* FONTS
		public static const FONT_LIST_SIZE:uint = 35;
		public static const FONT_LIST_HIGH_SIZE:uint = 46;
		public static const FONT_LIST_NAME:String = "NeoSans-Italic";
		public static const FONT_LIST_NAME2:String = "Museo500-Regular";
		public static const FONT_LIST_COLOR:uint = 0xE5DFD3;
		
		//******** LAYOUT
		public static const ITEM_HEIGHT:uint = 158;
		public static const MARGIN_LEFT_LIST:uint = 132;
		public static const MARGIN_TOP_LIST:uint = 476;
		
		//******* LANG
		public static const PT:String = "pt";
		public static const EN:String = "en";
		public static const ES:String = "es";
		
		public static const UI1:String = "ui1";
		public static const UI2:String = "ui2";
		
		
		public var actLang:String = PT;
		public var actUI:String = UI1; 
		public var isMoving:Boolean = false;
		public var isTouchable:Boolean = true;
		
		//********* PATHS
		public static const imagesPath:File = File.applicationDirectory.resolvePath("arq").resolvePath("img");
		public static const videosPath:File = File.applicationDirectory.resolvePath("arq").resolvePath("fich");

		
		public function Constants(SingletonEnforcer:SingletonEnforcer)
		{
		}
		public static function getInstance():Constants
		{
			if(Constants._instance == null)
			{
				Constants._instance = new Constants(new SingletonEnforcer());
			}
			return(Constants._instance);
		}
		//SETS
		public function set scale(width:Number):void
		{
			this._scale = width/STAGE_WIDTH;
		}
		public function set scaleY(height:Number):void
		{
			this._scaleY = height/STAGE_HEIGHT;
		}
		
		public function set realWidth(w:uint):void
		{
			this._realWidth = w;
		}
		public function set realHeight(h:uint):void
		{
			this._realHeight = h;
		}
		public function set actItens(id:Number):void
		{
			this._actItens = id;
		}
		public function set itemSelected(id:uint):void
		{
			this._itemSelected = id;
		}
		//GETS
		public function get itemSelected():uint
		{
			return(this._itemSelected);
		}
		public function get actItens():Number
		{
			return(this._actItens);
		}
		public function get scale():Number
		{
			return(this._scale);
		}
		public function get scaleY():Number
		{
			return(this._scaleY);
		}
		public function get realWidth():uint
		{
			return(this._realWidth);
		}
		public function get realHeight():uint
		{
			return(this._realHeight);
		}
	}
}
class SingletonEnforcer {}