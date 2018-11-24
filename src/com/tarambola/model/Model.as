package com.tarambola.model
{
	import br.com.stimuli.loading.BulkLoader;
	import br.com.stimuli.loading.BulkProgressEvent;
	
	import com.tarambola.HashMap;
	import com.tarambola.model.Classes.Constants;
	import com.tarambola.model.Classes.GalleryModel;
	import com.tarambola.model.Classes.ItemModel;
	import com.tarambola.model.Classes.ItensList;
	import com.tarambola.model.Classes.ItensModel;
	import com.tarambola.model.Classes.ScreensaverModel;
	import com.tarambola.model.Classes.StringLang;
	
	import flash.display.Bitmap;
	import flash.filesystem.File;
	import flash.system.Capabilities;
	
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.EventDispatcher;
	import starling.utils.AssetManager;

	public class Model extends starling.events.EventDispatcher
	{
		private var _assets:AssetManager;
		private var path:File;
		private var _xml:XML;
		private var _loader:BulkLoader;
		private var _configXML:XML;
		private var _screensaver:ScreensaverModel;

		private var _lists:Vector.<ItensList>; 

		public function Model()
		{
			this.path = File.applicationDirectory.resolvePath("files");
			
			this._lists = new Vector.<ItensList>;
			this._loader= new BulkLoader("Main");
			this._loader.addEventListener(BulkProgressEvent.COMPLETE, parseXML);
			
			this._screensaver = new ScreensaverModel();
		}
		public function init():void
		{
			this._assets = new AssetManager(Starling.current.contentScaleFactor);
			this._assets.verbose= Capabilities.isDebugger;
			
			this.loadXml();
		}
		private function loadXml():void
		{
			this._loader.add(this.path.resolvePath("images").resolvePath("screensaver.png").url, {type:"image", id:"saver"});
			this._loader.add(File.applicationDirectory.resolvePath("arq").resolvePath("xml").resolvePath("pt").resolvePath("epocas.xml").url, {type:"xml", id:"epocas"});
			this._loader.add(File.applicationDirectory.resolvePath("arq").resolvePath("xml").resolvePath("pt").resolvePath("marcadores.xml").url, {type:"xml", id:"marcadores"});
			this._loader.add(File.applicationDirectory.resolvePath("arq").resolvePath("xml").resolvePath("pt").resolvePath("imagens.xml").url, {type:"xml", id:"imagens"});
			this._loader.add(File.applicationDirectory.resolvePath("arq").resolvePath("xml").resolvePath("pt").resolvePath("videos.xml").url, {type:"xml", id:"videos"});
			this._loader.add(File.applicationDirectory.resolvePath("arq").resolvePath("xml").resolvePath("pt").resolvePath("saber_mais.xml").url, {type:"xml", id:"saber_mais"});
			this._loader.add(File.applicationDirectory.resolvePath("arq").resolvePath("xml").resolvePath("en").resolvePath("saber_mais.xml").url, {type:"xml", id:"saber_maisEN"});
			this._loader.add(File.applicationDirectory.resolvePath("arq").resolvePath("xml").resolvePath("es").resolvePath("saber_mais.xml").url, {type:"xml", id:"saber_maisES"});
			this._loader.add(File.applicationDirectory.resolvePath("arq").resolvePath("xml").resolvePath("en").resolvePath("marcadores.xml").url, {type:"xml", id:"marcadoresEN"});
			this._loader.add(File.applicationDirectory.resolvePath("arq").resolvePath("xml").resolvePath("es").resolvePath("marcadores.xml").url, {type:"xml", id:"marcadoresES"});
			this._loader.add(File.applicationDirectory.resolvePath("arq").resolvePath("xml").resolvePath("pt").resolvePath("galerias.xml").url, {type:"xml", id:"galerias"});
			this._loader.add(File.applicationDirectory.resolvePath("arq").resolvePath("xml").resolvePath("en").resolvePath("galerias.xml").url, {type:"xml", id:"galeriasEN"});
			this._loader.add(File.applicationDirectory.resolvePath("arq").resolvePath("xml").resolvePath("es").resolvePath("galerias.xml").url, {type:"xml", id:"galeriasES"});
			
			this._loader.add(File.applicationDirectory.resolvePath("arq").resolvePath("xml").resolvePath("pt").resolvePath("screensaver.xml").url, {type:"xml", id:"screensaver"});
			
			this._loader.add(File.applicationDirectory.resolvePath("files").resolvePath("config").resolvePath("config.xml").url, {type:"xml", id:"config"});
			this._loader.start();
		}
		//****** LOADER HANDLERS
		private function parseXML(evt:BulkProgressEvent):void
		{
			var epocasXML:XMLList = this._loader.getXML("epocas").contents.epocas;
			var marcadoresXML:XMLList = this._loader.getXML("marcadores").contents.marcadores;
			var marcadoresXMLEN:XMLList = this._loader.getXML("marcadoresEN").contents.marcadores;
			var marcadoresXMLES:XMLList = this._loader.getXML("marcadoresES").contents.marcadores;
			var imagensXML:XMLList = this._loader.getXML("imagens").contents.imagens;
			var videosXML:XMLList = this._loader.getXML("videos").contents.videos;
			var maisXML:XMLList = this._loader.getXML("saber_mais").contents.saber_mais;
			var maisXMLEN:XMLList = this._loader.getXML("saber_maisEN").contents.saber_mais;
			var maisXMLES:XMLList = this._loader.getXML("saber_maisES").contents.saber_mais;
			var galeriasXML:XMLList = this._loader.getXML("galerias").contents.galerias;
			var galeriasXMLEN:XMLList = this._loader.getXML("galeriasEN").contents.galerias;
			var galeriasXMLES:XMLList = this._loader.getXML("galeriasES").contents.galerias;
			var screensaverXML:XMLList = this._loader.getXML("screensaver").contents.screensaver;
			var epocas:HashMap = new HashMap();
			
			if(imagensXML.item.length()>0)
				var imagesCat:uint = imagensXML.item[0].@cat;
			if(videosXML.item.length()>0)
				var videosCat:uint = videosXML.item[0].@cat;
			if(maisXML.item.length()>0)
				var maisCat:uint = maisXML.item[0].@cat;
			if(galeriasXML.item.length()>0)
				var galeriasCat:uint = galeriasXML.item[0].@cat;
			
			//trace(epocasXML);
			//trace("xml-> " + epocasXML.contents.epocas.item.(@titulo=="Época"));
			//trace("---XX " + epocasXML.item.(@cat=="7").@id);

			var sc:XML = screensaverXML.item[0];
			this._screensaver.image = sc.@imagem;
			this._screensaver.video = sc.@video;
			this._screensaver.time = sc.@tempo;
			
			var i:uint=0;
			for each(var item:XML in epocasXML.item) {
				epocas.put(item.@id, item.@subtitulo);
				// NEW EPOCA <- LIST ITENS
				var it:ItensList = new ItensList();
				it.id=i;
				i++;
				it.posX = item.@distancia_horizontal;
				it.title = new StringLang(Constants.PT, item.@subtitulo);
				this._lists.push(it);
				// GET MARCADORES DA EPOCA
				var marca:XMLList = marcadoresXML.item.(@epoca==item.@id);
				for each(var m:XML in marca)
				{
					var itemModel:ItemModel = new ItemModel();
					it.itens.push(itemModel);
					itemModel.id = i;
					// **** ALL LANG ITEM TITLE & TEXT***//
					var title:StringLang = new StringLang(Constants.PT, m.@titulo);
					var text:StringLang = new StringLang(Constants.PT, m.@texto);
					
					var tEN:XMLList = marcadoresXMLEN.item.(@id==m.@id);
					if(tEN.toXMLString()!="")
					{
						title.add(Constants.EN, tEN.@titulo);
						text.add(Constants.EN, tEN.@texto);
					}
					var tES:XMLList = marcadoresXMLES.item.(@id==m.@id);
					if(tES.toXMLString()!="")
					{
						title.add(Constants.ES, tES.@titulo);
						text.add(Constants.ES, tES.@texto);
					}
					itemModel.title = title;
					itemModel.text = text;
					// GET IMAGENS DO MARCADOR
					var images:XMLList = m.items_relacionados.item_relacionado.(@cat==imagesCat);
					var imagesEN:XMLList = tEN.items_relacionados.item_relacionado.(@cat==imagesCat);
					var imagesES:XMLList = tES.items_relacionados.item_relacionado.(@cat==imagesCat);
					for each(var im:XML in images)
					{						
						var t:StringLang = new StringLang(Constants.PT, im.@titulo);
						var en:XMLList = imagesEN.(@id==im.@id);
						var es:XMLList = imagesES.(@id==im.@id);
						if(en.toXMLString()!="")
							t.add(Constants.EN, en.@titulo);
						if(es.toXMLString()!="")
							t.add(Constants.ES, es.@titulo);
						itemModel.addGalleryItem(t, im.@img_int);
					}
					// GET VIDEOS DO MARCADOR
					var videos:XMLList = m.items_relacionados.item_relacionado.(@cat==videosCat);
					var videosEN:XMLList = tEN.items_relacionados.item_relacionado.(@cat==videosCat);
					var videosES:XMLList = tES.items_relacionados.item_relacionado.(@cat==videosCat);
					for each(var vid:XML in videos)
					{
						var t2:StringLang = new StringLang(Constants.PT, im.@titulo);
						var en2:XMLList = imagesEN.(@id==vid.@id);
						var es2:XMLList = imagesES.(@id==vid.@id);
						if(en2.toXMLString()!="")
							t.add(Constants.EN, en2.@titulo);
						if(es2.toXMLString()!="")
							t.add(Constants.ES, es2.@titulo);
						itemModel.addVideoItem(t2, vid.@video, vid.@img_video);
					}
					// GET PLUS DO MARCADOR
					var saber_mais:XMLList = m.items_relacionados.item_relacionado.(@cat==maisCat);
					for each(var mais:XML in saber_mais)
					{
						var mXML:XMLList = maisXML.item.(@id==mais.@id);
						var mXMLEN:XMLList = maisXMLEN.item.(@id==mais.@id);
						var mXMLES:XMLList = maisXMLES.item.(@id==mais.@id);
						
						var pl:StringLang = new StringLang(Constants.PT, mXML.@texto);
						pl.add(Constants.EN, mXMLEN.@texto);
						pl.add(Constants.ES, mXMLES.@texto);
						itemModel.plus.text = pl;
						//GET ITEMS DAS GALERIAS
						var itGal:XMLList = mXML.items_relacionados.item_relacionado.(@cat==galeriasCat);
					
						for each(var iGal:XML in itGal)
						{
							var galXML:XMLList = galeriasXML.item.(@id==iGal.@id);
							var galXMLEN:XMLList = galeriasXMLEN.item.(@id==iGal.@id);
							var galXMLES:XMLList = galeriasXMLES.item.(@id==iGal.@id);
							
							var gal:GalleryModel = new GalleryModel();
							var titGal:StringLang = new StringLang(Constants.PT, iGal.@titulo);
							
							var titEn:XMLList = mXMLEN.items_relacionados.item_relacionado.(@id==iGal.@id);
							var titEs:XMLList = mXMLES.items_relacionados.item_relacionado.(@id==iGal.@id);
							titGal.add(Constants.EN, titEn.@titulo);
							titGal.add(Constants.ES, titEs.@titulo);
							gal.text = titGal;
							
							var imgGal:XMLList = galXML.items_relacionados.item_relacionado;
							for each(var img:XML in imgGal)
							{
								var imgGalEN:XMLList = galXMLEN.items_relacionados.item_relacionado.(@id == imgGal.@id);
								var imgGalES:XMLList = galXMLES.items_relacionados.item_relacionado.(@id == imgGal.@id);
								
								var tfoto:StringLang = new StringLang(Constants.PT, img.@titulo);
								tfoto.add(Constants.EN, imgGalEN.@titulo);
								tfoto.add(Constants.ES, imgGalES.@titulo);
								gal.addImage(tfoto, img.@img_int);
								//trace(img.@img_int);
							}
							itemModel.plus.galleries.push(gal);
						}
					}
				}
			}
			
			this._configXML = this._loader.getXML("config");
			this._screensaver.time = uint(this._configXML.screensaver.@tempo)*1000;
			
			this.loadAssets();
		}
		private function loadAssets():void
		{
			//****** INFO
			//******** AUDIO
			//******** TEXTURES ATLAS
			this._assets.enqueue(this.path.resolvePath("ui").resolvePath("crianca").resolvePath("ui.png"));
			this._assets.enqueue(this.path.resolvePath("ui").resolvePath("crianca").resolvePath("ui.xml"));
			//******** IMAGES
			for(var i:uint=1; i<6; i++)
			{
				this._assets.enqueue(this.path.resolvePath("background").resolvePath("bg_" + (i).toString() + ".png"));
				this._assets.enqueue(this.path.resolvePath("background").resolvePath("bg_" + (i).toString() + ".xml"));
			}
			this._assets.enqueue(this.path.resolvePath("images").resolvePath("mask3.png"));
			//******* PARTICLES
			//******* FONTS
			this._assets.enqueue(this.path.resolvePath("fonts").resolvePath("neo_sans_italic.png"));
			this._assets.enqueue(this.path.resolvePath("fonts").resolvePath("neo_sans_regular.png"));
			this._assets.enqueue(this.path.resolvePath("fonts").resolvePath("museu_700.png"));
			this._assets.enqueue(this.path.resolvePath("fonts").resolvePath("museu_500.png"));
			this._assets.enqueue(this.path.resolvePath("fonts").resolvePath("stanton.png"));
			
			
			this._assets.loadQueue( onProgress);
		}
		//*************
		//************* LISTENERS 
		private function onProgress(ratio:Number):void
		{
			if(ratio == 1.0)
				this.dispatchEvent(new Event("ALL.LOADED"));
		}
		//************
		//************ PUBLIC METHODS
		public function get asset():AssetManager
		{
			return(this._assets);
		}
		public function get lists():Vector.<ItensList>
		{
			return(this._lists);
		}
		public function getClosest(pos:Number):ItensList
		{
				for(var i:uint =0; i<this._lists.length; i++)
				{
					if( pos < (this._lists[i].posX+80) && pos > (this._lists[i].posX-80) )
					{
						return(this._lists[i]);
					}
				}
			
			return(null);
		}
		public function getTrad(name:String, lang:String):String
		{
			return(this._configXML.trad.child(name).child(lang));
		}
		public function get ScreenSaver():Bitmap
		{
			return(this._loader.getBitmap("saver"));
		}
		public function get screensaverModel():ScreensaverModel
		{
			return(this._screensaver);
		}
		public function hasLang():Boolean
		{
			for(var i:uint =0; i<this._lists.length; i++)
			{
				for(var k:uint=0; k<this._lists[i].itens.length; k++)
				{
					if(this._lists[i].itens[k].title.getString(Constants.getInstance().actLang)!=null && this._lists[i].itens[k].title.getString(Constants.getInstance().actLang)!="")
						return(true);
				}
			}
			return false;
		}
		
	}
}