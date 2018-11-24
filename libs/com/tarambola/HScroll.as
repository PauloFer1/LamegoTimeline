﻿package com.tarambola {	import com.greensock.TweenLite;	import com.greensock.TweenMax;		import flash.display.DisplayObject;	import flash.display.MovieClip;	import flash.display.Shape;	import flash.display.Sprite;	import flash.display.Stage;	import flash.events.Event;	import flash.events.MouseEvent;	import flash.geom.Point;	import flash.system.ApplicationDomain;	import flash.utils.getQualifiedClassName;
	public class HScroll extends MovieClip {        // Constant variables        private static var DECAY:Number = 0.9;        private static var MOUSE_DOWN_DECAY:Number = 0.5;        private static var SPEED_SPRINGNESS:Number = 0.2;        private static var BOUNCING_SPRINGESS:Number = 0.5;		// variables        private var _mouseDown:Boolean = false;        private var _velocity:Number = 0;        private var _mouseDownY:Number = 0;        private var _mouseDownPoint:Point = new Point();        private var _lastMouseDownPoint:Point = new Point();		private var maskC:Shape;        		        // elements        private var canvasHei:Number = 0;		private var canvas:Sprite;		private var scrollEl:DisplayObject;		private var _stage:Stage;				private var div:Number;		private var inc:uint=0;		private var isVelo:uint=0;				private var aBol:Array; //array de bolas do numero de fotos		private var bolCont:MovieClip;		private var currB:uint=1;		private var ini:uint=0;		private var nBolas:uint;		private var hand:MovieClip;		//canvas -- onde vai andar (addChild) o interior a fazer scroll, é criado uma mascara com as medidas deste canvas		//scrollElem -- interior que faz scroll		// st -- Stage necessário para o funcionamento correcto da classe		// nBolas -- paginação das "fotos" ou o que estiver a fazer scroll		public function HScroll(canvas:Sprite, scrollElem:DisplayObject, st:Stage, nBolas:uint=0,  hand:MovieClip=null) :void		{			this.nBolas=nBolas;			this._stage=st;			this.maskC = new Draw().dRect(canvas.width, canvas.height);			this.maskC.alpha=0;			this.hand=hand;			this.div = Math.round((scrollElem.width/this.maskC.width));			this.canvas = canvas;				if(this.nBolas>0)				{					this.bolCont=new MovieClip();					this.aBol= new Array();					for(var i:uint=0; i<this.div; i++)					{						this.aBol[i]=new Bola();						this.aBol[i].x = i* (aBol[i].width+10);						this.bolCont.addChild(this.aBol[i]);					}					this.canvas.addChild(this.bolCont);					this.bolCont.y=canvas.y+canvas.height+3;					this.bolCont.x=canvas.x+canvas.width/2 - this.bolCont.width/2+3;					TweenMax.to(aBol[0].ins, 1, {tint:0x3399FF ,glowFilter:{color:0x3399FF, alpha:1, blurX:5, blurY:5}});				}											this.canvas.buttonMode = true;				this.canvasHei = this.canvas.width;								var MyClass:DisplayObject = scrollElem;				this.scrollEl = scrollElem;//new MyClass();				this.canvas.addChild(this.scrollEl);				this.canvas.addChild(this.maskC);				/*this.maskC.x=xMask;				this.maskC.y=yMask;*/				this.scrollEl.mask=maskC;				//addChild(this.canvas);								// add handlers				if(scrollElem.width>maskC.width+1)				{					this.canvas.addEventListener(MouseEvent.MOUSE_DOWN, on_mouse_down);					addEventListener(Event.ENTER_FRAME, on_enter_frame);				}				this.showHand();		}		private function showHand():void		{			if(this.hand!=null && this.nBolas>0)			{				this.hand.x=this.maskC.width/2-this.hand.width/2;				this.hand.y=this.maskC.height/2-this.hand.height/2;				this.canvas.addChild(this.hand);				this.canvas.addEventListener(MouseEvent.MOUSE_DOWN, removeHand);			}		}		private function removeHand(evt:MouseEvent):void		{			this.canvas.removeEventListener(MouseEvent.MOUSE_DOWN, removeHand);			this.canvas.removeChild(this.hand);		}			private function setBol(i:uint):void		{			if(this.nBolas>0)			{				for(var j:uint=0; j<this.aBol.length; j++)				{					TweenMax.to(aBol[j].ins, 0.8, {tint:0xffffff ,glowFilter:{color:0x7B7B7B, alpha:0, blurX:0, blurY:0}});				}				TweenMax.to(aBol[i].ins, 0.8, {tint:0x3399FF ,glowFilter:{color:0x3399FF, alpha:1, blurX:5, blurY:5}});			}		}				private function on_enter_frame(e:Event):void{            // decay the velocity            if(_mouseDown) _velocity *= MOUSE_DOWN_DECAY;            else _velocity *= DECAY;				if((this.scrollEl.x<-((this.maskC.width * this.inc) + this.maskC.width/2 ) || this.scrollEl.x+(this.maskC.width * this.inc) > (this.maskC.width/2 ) ) )//|| Math.abs(_velocity)>4 )					{						goto(this.inc);					}						else if(this.inc>=0 && this.inc<this.div)			{				if(this.scrollEl.x<-((this.maskC.width * this.inc) + this.maskC.width/2 ) )					{						goto(this.inc);					}			}			            // if not mouse down, then move the element with the velocity            if (!_mouseDown)            {                var textHeight:Number = this.scrollEl.width;                var _X:Number = this.scrollEl.x;                var bouncing:Number = 0;                // calculate a bouncing when the text moves over the canvas size                if (_X > 0)                {                    bouncing = -_X * BOUNCING_SPRINGESS;                }				else if( _X + textHeight < this.canvasHei)				{                    bouncing = (this.canvasHei - textHeight - _X) * BOUNCING_SPRINGESS;                }				//-------------------descomentar esta linha para ficar com boucing (não recomendado para galerias)               // this.scrollEl.x = _X + _velocity + bouncing;            }		}				// when mouse button up        private function on_mouse_down(e:MouseEvent):void        {            if (!_mouseDown)            {                // get some initial properties                _mouseDownPoint = new Point(e.stageX, e.stageY);                _lastMouseDownPoint = new Point(e.stageX, e.stageY);				                _mouseDown = true;                _mouseDownY = this.scrollEl.x;								// add some more mouse handlers                _stage.addEventListener(MouseEvent.MOUSE_UP, on_mouse_up);                _stage.addEventListener(MouseEvent.MOUSE_MOVE, on_mouse_move);            }        }        // when mouse is moving        private function  on_mouse_move(e:MouseEvent):void        {            if (_mouseDown)            {                // update the element position                var point:Point = new Point(e.stageX, e.stageY);                this.scrollEl.x = _mouseDownY + (point.x - _mouseDownPoint.x);								/*if( this.scrollEl.x>0 || this.scrollEl.x < -(this.scrollEl.width -this.maskC.width+0))					on_mouse_up(new MouseEvent(MouseEvent.MOUSE_UP));*/				                // update the velocity                _velocity += ((point.x - _lastMouseDownPoint.x) * SPEED_SPRINGNESS);                _lastMouseDownPoint = point;            }        }		private function goto(i:uint):void		{			 if( (_mouseDownPoint.x - _lastMouseDownPoint.x) > 0 && this.ini==0) //&& this.inc<this.div && this.isVelo==0)//&& Math.abs(_velocity) > 5)			 {				 if(this.inc<this.div-1 && this.isVelo==0)				 {					 _velocity=0;					 this.inc++;					 if(this.nBolas>0)						this.setBol(this.inc);					_stage.removeEventListener(MouseEvent.MOUSE_UP, on_mouse_up);					_stage.removeEventListener(MouseEvent.MOUSE_MOVE, on_mouse_move);					TweenLite.to(this.scrollEl, 0.3, {x:-(this.inc*this.maskC.width), onComplete:function():void{isVelo=0;}});// 5 Martelanço 				 }				 else if(this.isVelo==0)				 {					 this.ini=1;					  _velocity=0;					 this.inc=0;					 if(this.nBolas>0)						this.setBol(this.inc);					_stage.removeEventListener(MouseEvent.MOUSE_UP, on_mouse_up);					_stage.removeEventListener(MouseEvent.MOUSE_MOVE, on_mouse_move);					TweenLite.to(this.scrollEl, 0.3, {x:-(this.inc*this.maskC.width), onComplete:function():void{isVelo=0;ini=0;}});// 5 Martelanço 									}							 }			 else if( this.isVelo==0 && this.ini==0)			 {				 if(this.inc>0)				 {					 _velocity=0;					 this.inc--;					 if(this.nBolas>0)					 	this.setBol(this.inc);					_stage.removeEventListener(MouseEvent.MOUSE_UP, on_mouse_up);					_stage.removeEventListener(MouseEvent.MOUSE_MOVE, on_mouse_move);					TweenLite.to(this.scrollEl, 0.3, {x:-(this.inc*this.maskC.width), onComplete:function():void{isVelo=0;}}); // -2 Martelanço 				 }				 else				{					 this.ini=1;					 _velocity=0;					 this.inc=this.div-1;					 if(this.nBolas>0)					 	this.setBol(this.inc);					_stage.removeEventListener(MouseEvent.MOUSE_UP, on_mouse_up);					_stage.removeEventListener(MouseEvent.MOUSE_MOVE, on_mouse_move);					TweenLite.to(this.scrollEl, 0.3, {x:-(this.inc*this.maskC.width), onComplete:function():void{isVelo=0;ini=0;}}); // -2 Martelanço 				}							}								_mouseDown = false;		}		private function gotoInic():void		{                _stage.removeEventListener(MouseEvent.MOUSE_UP, on_mouse_up);                _stage.removeEventListener(MouseEvent.MOUSE_MOVE, on_mouse_move);				TweenLite.to(this.scrollEl, 0.3, {x:-(this.inc*this.maskC.width)}); 					_velocity=0;				_mouseDown = false;		}        // clear everythign when mouse up        private function  on_mouse_up(e:MouseEvent):void        {				if(Math.abs(_velocity) >3)				{					goto(this.inc);					this.isVelo=1;				}				else				{					gotoInic();					this.isVelo=0;				}            if (_mouseDown)            {                _mouseDown = false;                _stage.removeEventListener(MouseEvent.MOUSE_UP, on_mouse_up);                _stage.removeEventListener(MouseEvent.MOUSE_MOVE, on_mouse_move);            }        }		public function startIn(id:uint):void		{			removeEventListener(Event.ENTER_FRAME, on_enter_frame);			this.scrollEl.x=-(id*this.maskC.width);			this.inc=id;			addEventListener(Event.ENTER_FRAME, on_enter_frame);			this.setBol(id);		}	}}

