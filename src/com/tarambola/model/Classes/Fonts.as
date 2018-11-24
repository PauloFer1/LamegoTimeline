package com.tarambola.model.Classes
{
	
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;

	public class Fonts
	{
		[Embed(source="../../../../files/fonts/neo_sans_italic.fnt", mimeType="application/octet-stream")]
		public static const SeagramConfig:Class;
		
		[Embed(source="../../../../files/fonts/museu_700.fnt", mimeType="application/octet-stream")]
		public static const MuseuConfig:Class;
		
		[Embed(source="../../../../files/fonts/museu_500.fnt", mimeType="application/octet-stream")]
		public static const Museu500Config:Class;
		
		[Embed(source="../../../../files/fonts/neo_sans_regular.fnt", mimeType="application/octet-stream")]
		public static const NeoConfig:Class;
		
		[Embed(source="../../../../files/fonts/stanton.fnt", mimeType="application/octet-stream")]
		public static const StantonConfig:Class;
					
		static private var _instance:Fonts;
		
		private var _fonts:Vector.<BitmapFont>;
		
		public function Fonts(SingletonEnforcer:SingletonEnforcer)
		{
		}
		public static function getInstance():Fonts
		{
			if(Fonts._instance == null)
			{
				Fonts._instance = new Fonts(new SingletonEnforcer());
			}
			return(Fonts._instance);
		}
		public function init():void
		{
			this._fonts = new Vector.<BitmapFont>;
			
			this._fonts.push(new BitmapFont(Arq.getInstance().model.asset.getTexture("neo_sans_italic"), XML(new SeagramConfig())));
			this._fonts.push(new BitmapFont(Arq.getInstance().model.asset.getTexture("museu_700"), XML(new MuseuConfig())));
			this._fonts.push(new BitmapFont(Arq.getInstance().model.asset.getTexture("museu_500"), XML(new Museu500Config())));
			this._fonts.push(new BitmapFont(Arq.getInstance().model.asset.getTexture("neo_sans_regular"), XML(new NeoConfig())));
			this._fonts.push(new BitmapFont(Arq.getInstance().model.asset.getTexture("stanton"), XML(new StantonConfig())));
			
			this._fonts[0].smoothing = TextureSmoothing.BILINEAR;
			this._fonts[1].smoothing = TextureSmoothing.BILINEAR;
			this._fonts[2].smoothing = TextureSmoothing.BILINEAR;
			this._fonts[3].smoothing = TextureSmoothing.BILINEAR;
			this._fonts[4].smoothing = TextureSmoothing.BILINEAR;
			
			TextField.registerBitmapFont(this._fonts[0]);
			TextField.registerBitmapFont(this._fonts[1]);
			TextField.registerBitmapFont(this._fonts[2]);
			TextField.registerBitmapFont(this._fonts[3]);
			TextField.registerBitmapFont(this._fonts[4]);
		}
		public function getFont(name:String):BitmapFont
		{
			for(var i:uint=0; i<this._fonts.length; i++)
			{
				if(name==this._fonts[i].name)
					return(this._fonts[i]);
			}
			return(null);
		}
	}
}
class SingletonEnforcer {}