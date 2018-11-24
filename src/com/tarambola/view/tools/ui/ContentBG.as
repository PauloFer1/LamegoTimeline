package com.tarambola.view.tools.ui
{
	import com.tarambola.model.Classes.Arq;
	import com.tarambola.model.Classes.Constants;
	
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class ContentBG extends Sprite
	{
		private var _actBG:Image;
		private var _realBG:Image;
		private var _papiro:Image;
		private var _papiro2:Image;
		private var _amarelo:Image;
		private var _azul:Image;
		private var _verde:Image;
		private var _roxo:Image;
		
		private var _tween:Tween;
		
		public function ContentBG()
		{
			super();
			
			this._roxo = new Image(Arq.getInstance().model.asset.getTexture("roxo_ui2"));
			this._amarelo = new Image(Arq.getInstance().model.asset.getTexture("amarelo_ui2"));
			this._azul = new Image(Arq.getInstance().model.asset.getTexture("azul_ui2"));
			this._verde = new Image(Arq.getInstance().model.asset.getTexture("verde_ui2"));
			
			this._papiro = new Image(Arq.getInstance().model.asset.getTexture("papiro_ui1"));
			
			this._amarelo.visible = this._roxo.visible = this._azul.visible = this._verde.visible = this._papiro.visible = false;
			
			this.addChild(this._roxo);
			this.addChild(this._amarelo);
			this.addChild(this._azul);
			this.addChild(this._verde);
			this.addChild(this._papiro);
			
			this._roxo.pivotX = this._roxo.width/2;
			this._roxo.pivotY = this._roxo.height/2;
			this._roxo.x = this._roxo.width/2;
			this._roxo.y = this._roxo.height/2;
			
			this._amarelo.pivotX = this._amarelo.width/2;
			this._amarelo.pivotY = this._amarelo.height/2;
			this._amarelo.x = this._amarelo.width/2;
			this._amarelo.y = this._amarelo.height/2;
			
			this._azul.pivotX = this._azul.width/2;
			this._azul.pivotY = this._azul.height/2;
			this._azul.x = this._azul.width/2;
			this._azul.y = this._azul.height/2;
			
			this._verde.pivotX = this._verde.width/2;
			this._verde.pivotY = this._verde.height/2;
			this._verde.x = this._verde.width/2;
			this._verde.y = this._verde.height/2;
			
			this._papiro.pivotX = this._papiro.width/2;
			this._papiro.pivotY = this._papiro.height/2;
			this._papiro.x = this._papiro.width/2;
			this._papiro.y = this._papiro.height/2;
			
		}
		public function show(id:String):void
		{
			if(Constants.getInstance().actUI == Constants.UI1)
			{
				if(id=="info"){
					this._papiro.rotation = Math.PI/2;
					if(this._actBG!=null && this._actBG!=this._papiro)
					{
						this._realBG = this._papiro;
						this._papiro.rotation = Math.PI/2;
						this._tween = new  Tween(this._actBG, 0.3);
						this._tween.animate("alpha", 0);
						this._tween.onComplete = endTween;
						this._tween.onCompleteArgs = [this._papiro];
						Starling.juggler.add(this._tween);	
					}
					else if(this._actBG!=this._papiro)
					{
						this._papiro.rotation = Math.PI/2;
						this._realBG = this._papiro;
						this._actBG = this._papiro;
						this._actBG.visible = true;
						this._tween = new  Tween(this._actBG, 0.3);
						this._tween.animate("alpha", 1);
						this._tween.onComplete = endTween2;
						Starling.juggler.add(this._tween);	
					}
				}
				else{
					this._papiro.rotation = 0;
					if(this._actBG!=null && this._actBG!=this._papiro)
					{
						
						this._realBG = this._papiro;
						this._tween = new  Tween(this._actBG, 0.3);
						this._tween.animate("alpha", 0);
						this._tween.onComplete = endTween;
						this._tween.onCompleteArgs = [this._papiro];
						Starling.juggler.add(this._tween);	
					}
					else if(this._actBG!=this._papiro)
					{
						this._papiro.rotation = 0;
						this._realBG = this._papiro;
						this._actBG = this._papiro;
						this._actBG.visible = true;
						this._tween = new  Tween(this._actBG, 0.3);
						this._tween.animate("alpha", 1);
						this._tween.onComplete = endTween2;
						Starling.juggler.add(this._tween);	
					}
				}
			}
			else
			{
				if(id=="info"){
					if(this._actBG!=null && this._actBG!=this._roxo){
						this._realBG = this._roxo;
						this._tween = new  Tween(this._actBG, 0.3);
						this._tween.animate("alpha", 0);
						this._tween.onComplete = endTween;
						this._tween.onCompleteArgs = [this._roxo];
						Starling.juggler.add(this._tween);	}
					else if (this._actBG!=this._roxo){
						this._realBG = this._roxo;
						this._actBG = this._roxo;
						this._actBG.visible = true;
						this._tween = new  Tween(this._actBG, 0.3);
						this._tween.animate("alpha", 1);
						this._tween.onComplete = endTween2;
						Starling.juggler.add(this._tween);	}
				}
				else if(id=="video"){
					if(this._actBG!=null && this._actBG!=this._amarelo){
						this._realBG = this._amarelo;
						this._tween = new  Tween(this._actBG, 0.3);
						this._tween.animate("alpha", 0);
						this._tween.onComplete = endTween;
						this._tween.onCompleteArgs = [this._amarelo];
						Starling.juggler.add(this._tween);	}
					else if(this._actBG!=this._amarelo){
						this._realBG = this._amarelo;
						this._actBG = this._amarelo;
						this._actBG.visible = true;
						this._tween = new  Tween(this._actBG, 0.3);
						this._tween.animate("alpha", 1);
						this._tween.onComplete = endTween2;
						Starling.juggler.add(this._tween);	}
					
				}
				else if(id=="fotos"){
					if(this._actBG!=null && this._actBG!=this._azul){
						this._realBG = this._azul;
						this._tween = new  Tween(this._actBG, 0.3);
						this._tween.animate("alpha", 0);
						this._tween.onComplete = endTween;
						this._tween.onCompleteArgs = [this._azul];
						Starling.juggler.add(this._tween);	}
					else if(this._actBG!=this._azul){
						this._realBG = this._azul;
						this._actBG = this._azul;
						this._actBG.visible = true;
						this._tween = new  Tween(this._actBG, 0.3);
						this._tween.animate("alpha", 1);
						this._tween.onComplete = endTween2;
						Starling.juggler.add(this._tween);	}
				}
				else if(id=="plus"){
					if(this._actBG!=null && this._actBG!=this._verde){
						this._realBG = this._verde;
						this._tween = new  Tween(this._actBG, 0.3);
						this._tween.animate("alpha", 0);
						this._tween.onComplete = endTween;
						this._tween.onCompleteArgs = [this._verde];
						Starling.juggler.add(this._tween);	}
					else if(this._actBG!=this._verde){
						this._realBG = this._verde;
						this._actBG = this._verde;
						this._actBG.visible = true;
						this._tween = new  Tween(this._actBG, 0.3);
						this._tween.animate("alpha", 1);
						this._tween.onComplete = endTween2;
						Starling.juggler.add(this._tween);	}
				}
			}
		}
		
		private function endTween(bg:Image):void
		{
			this._actBG.visible = false;
			Starling.juggler.remove(this._tween);
			bg.alpha=0;
			bg.visible=true;
			this._actBG = bg
			this._tween = new  Tween(this._actBG, 0.3);
			this._tween.animate("alpha", 1);
			this._tween.onComplete = endTween2;
			Starling.juggler.add(this._tween);	
		}
		private function endTween2():void
		{
			Starling.juggler.remove(this._tween);
		}
		public function get actWidth():uint
		{
			return(this._realBG.width);
		}
		public function get actHeight():uint
		{
			return(this._realBG.height);
		}
	}
}