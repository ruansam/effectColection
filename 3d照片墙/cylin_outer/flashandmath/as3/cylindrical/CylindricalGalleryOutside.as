
/*
ActionScript 3 Tutorials by Barbara Kaskosz.

www.flashandmath.com

Last modified: January 23, 2010. 

*/


 
package flashandmath.as3.cylindrical {
	
	
	 import flash.display.Sprite;
	 
	 import flash.display.BitmapData;
	 
	 import flash.display.Loader;
	 
	 import flash.events.Event;
	 
	 import flash.events.MouseEvent;
	 
	 import flash.events.IOErrorEvent;
	 
	 import flash.geom.PerspectiveProjection;
	 
	 import flash.geom.Point;
	 
	 import flash.geom.ColorTransform;
	 
	 import flash.filters.GlowFilter;
	 
	 import flash.net.URLRequest;
	 
     
	 public class CylindricalGalleryOutside extends Sprite {
		 
 
		private var numCols:int;
		
		private var thumbWidth:Number;
		
		private var thumbHeight:Number;
		
		private var thumbsArray:Array;
		
		private var pxSpace:int;

		private var colHeight:Number;
		
		private var colWidth:Number;
		
		private var rad:Number;
		
		private var containerHeight:Number;
		
		private var containerWidth:Number;
		
		private var colsVec:Vector.<Column>;
		
		private var colLen:int;
		
		private var angle:Number;
		
		private var galLoader:GalleryLoader;
		
		private var notReady:Boolean;
		
		private var container:Sprite;
		
		private var capsArray:Array;
		
		private var picsArray:Array;
		
		private var picWidth:Number;
		
		private var picHeight:Number;
		
		private var horAddOn:Number;
		
		private var pp:PerspectiveProjection;
		
		private var photoHolder:Sprite;
		
		private var loader:Loader;
		
		private var holdersRefArray:Array;
		
		private var isLoading:Boolean;
		
		private var rotateRight:Boolean=false;

        private var rotateLeft:Boolean=false;
		
		private var rightArrow:ArrowGizmo;
		 
		private var leftArrow:ArrowGizmo;
		
		private var captionGizmo:CaptionGizmo;
		
		private var captionGizmoOver:CaptionGizmo;
		
		private var loadText:LoadText;
		
		private var loadSpinner:LoadSpinner;
		
		private var colorText:Number;
		
		private var colorGlow:Number;
		
		private var diffAng:Number;
		
		private var widthOfStage:Number;
		
		private var fW:Number;
		
		private var offsetBack:Number;
		
		private var minLight:Number;
		
		
		
		public function CylindricalGalleryOutside(xmldata:String,w:Number=700,tc:Number=0x999999,gc:Number=0xCC3300,ob:Number=50) {
			
		  notReady=true;
		  
		  colorText=tc;
		  
		  colorGlow=gc;
		  
		  widthOfStage=w;
		  
		  offsetBack=ob;
		  
		  fW=55;
		  
		  minLight=0.05;
			 
		  galLoader=new GalleryLoader(xmldata);
		  
		  galLoader.addEventListener(GalleryLoader.XMLLOAD_ERROR, xmlError);

          galLoader.addEventListener(GalleryLoader.IMGSLOAD_ERROR, imgsError);

          galLoader.addEventListener(GalleryLoader.ALL_LOADED, loadEnded);
		  
		  loadText=new LoadText(colorGlow);
		 
		  this.addChild(loadText);
		  
		  loadText.mouseEnabled=false;
		  
		  loadText.x=70;
		  
		  loadText.y=0;
		 
		  loadText.visible=true;
		  
		  loadSpinner=new LoadSpinner(300,200);
		 
		  this.addChild(loadSpinner);
		  
		  loadSpinner.x=70;
		  
		  loadSpinner.y=70;
		 
		  loadSpinner.visible=true;
		  
		  loadSpinner.startSpinner();
		  
		  galLoader.loadXML();
		      
		}
		
	 private function xmlError(e:Event):void {
	
	     galLoader.removeEventListener(GalleryLoader.XMLLOAD_ERROR, xmlError);

         galLoader.removeEventListener(GalleryLoader.ALL_LOADED, loadEnded);
		 
		 galLoader.removeEventListener(GalleryLoader.IMGSLOAD_ERROR, imgsError);
		 
		 loadText.loadTextBox.text="There has been an error loading the XML file. The server\nmay be busy. Try refreshing the page.";
		 
		 loadSpinner.visible=false;
	
	     loadSpinner.stopSpinner();
	
      }

	private function imgsError(e:Event):void {
	
	   galLoader.removeEventListener(GalleryLoader.XMLLOAD_ERROR, xmlError);

       galLoader.removeEventListener(GalleryLoader.ALL_LOADED, loadEnded);
	
	   galLoader.removeEventListener(GalleryLoader.IMGSLOAD_ERROR, imgsError);
	   
	   loadText.loadTextBox.text="There has been an error loading thumbnails. The server\nmay be busy. Try refreshing the page.";
	   
	   loadSpinner.visible=false;
	
	   loadSpinner.stopSpinner();
	
        }

	 private function loadEnded(e:Event):void {
	
	     galLoader.removeEventListener(GalleryLoader.XMLLOAD_ERROR, xmlError);

         galLoader.removeEventListener(GalleryLoader.ALL_LOADED, loadEnded);
	
	     galLoader.removeEventListener(GalleryLoader.IMGSLOAD_ERROR, imgsError);
		 
		 loadSpinner.stopSpinner();
		  
		 this.removeChild(loadSpinner);
		
		 initApp();
		 
		  
}

   private function initApp():void {
	   
	      var i:int;
		  
		  var j:int;
		  
		  var fL:Number=widthOfStage/(2*Math.tan((Math.PI/180)*(fW/2)));
		  
		  pxSpace=galLoader.pxSpace;
		  
		  numCols=galLoader.numCols;
		  
		  colLen=galLoader.colLen;
		  
		  picWidth=galLoader.picWidth;
		  
		  picHeight=galLoader.picHeight;
		  
		  thumbsArray=[];
		  
		  picsArray=[];
		  
		  capsArray=[];
		  
		  for(i=0;i<numCols;i++){
			  
			  thumbsArray[i]=new Vector.<BitmapData>(colLen);
			  
			  picsArray[i]=new Vector.<String>(colLen);
			  
			  capsArray[i]=new Vector.<String>(colLen);
			  
			  for(j=0;j<colLen;j++){
			 
			  thumbsArray[i][j]=galLoader.bmpDataArray[i][j].clone();
			  
			  galLoader.bmpDataArray[i][j].dispose();
			  
			  picsArray[i][j]=galLoader.picsArray[i][j];
			  
			  capsArray[i][j]=galLoader.capsArray[i][j];
			  
			  }
			    
		  }
		  
		  
		  thumbWidth=thumbsArray[0][0].width;
			 
		  thumbHeight=thumbsArray[0][0].height;
		  
		  colsVec=new Vector.<Column>();
		  
		  colHeight=thumbHeight*colLen+(colLen-1)*pxSpace;
		  
		  colWidth=thumbWidth;
		  
		  rad=galLoader.radius;
		  
		  angle=360/numCols;
		  
		  container=new Sprite();
		  
		  this.addChild(container);
		  
		  horAddOn=60;
		  
		  containerWidth=horAddOn+Math.ceil(2*rad*fL/(fL+rad+offsetBack)); 
		     
		  containerHeight=colHeight;
		  
		  container.x=containerWidth/2;
		  
		  container.y=containerHeight/2;
		  
		  diffAng=Math.round((Math.asin(rad/(fL+rad+offsetBack))*180/Math.PI)*1000)/1000;
		    
		  for(i=0;i<numCols;i++){
			  
			  colsVec[i]= new Column(thumbsArray[i],pxSpace,rad);
			  
			  colsVec[i].scaleX=colWidth/(colWidth+1);
			  
			  colsVec[i].scaleY=colHeight/(colHeight+1);
			  
			  container.addChild(colsVec[i]);
			  
			  colsVec[i].y=0;
			  
			  colsVec[i].x=0;
			  
			  colsVec[i].z=rad+offsetBack;
			    
			  colsVec[i].rotationY=angle*i;
			 
		  }
		  
		  
		   holdersRefArray=[];
		  
		   for(i=0;i<numCols;i++){
			  
			  holdersRefArray[i]=new Vector.<Sprite>(colLen);
			  
			  for(j=0;j<colLen;j++){
			  
			  holdersRefArray[i][j]=colsVec[i].holdersVec[j];
			  
			  holdersRefArray[i][j].name=String(i)+"_"+String(j);
			  
			  holdersRefArray[i][j].addEventListener(MouseEvent.ROLL_OVER,thumbOver);
			  
			  holdersRefArray[i][j].addEventListener(MouseEvent.ROLL_OUT,thumbOut);
			  
			  holdersRefArray[i][j].addEventListener(MouseEvent.CLICK,thumbClick);
			  
			  }
			    
		  }
		  
		 pp=new PerspectiveProjection();

         pp.fieldOfView=fW;

         pp.projectionCenter=new Point(0,0);

         container.transform.perspectiveProjection=pp;
		  
		 photoHolder=new Sprite();

         this.addChild(photoHolder);
		 
		 loader=new Loader();

         photoHolder.addChild(loader);
		 
         photoHolder.x=containerWidth/2-picWidth/2;

         photoHolder.y=containerHeight/2-picHeight/2;
		 
		 loader.contentLoaderInfo.addEventListener(Event.COMPLETE,donePhotoLoad);
	
	     loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,photoLoadError);
		 
		 photoHolder.addEventListener(MouseEvent.CLICK,photoClick);
		 
		 photoHolder.visible=false;
		 
		 rightArrow=new ArrowGizmo();
		  
		 leftArrow=new ArrowGizmo();
		  
		 leftArrow.rotation=180;
		  
		 leftArrow.x=-containerWidth/2-30;
		  
		 rightArrow.x=containerWidth/2+30;
		  
		 leftArrow.y=0;
		  
		 rightArrow.y=0;
		  
		 container.addChild(leftArrow);
		  
		 container.addChild(rightArrow);
		 
		 leftArrow.visible=false;
		 
		 rightArrow.visible=false;
		 
		 captionGizmo=new CaptionGizmo(colorText);
		 
		 this.addChild(captionGizmo);
		 
		 captionGizmo.mouseEnabled=false;
		  
		 captionGizmo.x=containerWidth/2-captionGizmo.width/2;
		 
		 captionGizmo.y=containerHeight-captionGizmo.height;
		 
		 captionGizmo.y=photoHolder.y+picHeight+30;
		 
		 captionGizmo.visible=false;
		 
		 captionGizmoOver=new CaptionGizmo(colorText);
		 
		 this.addChild(captionGizmoOver);
		 
		 captionGizmoOver.mouseEnabled=false;
		  
		 captionGizmoOver.x=containerWidth/2-captionGizmoOver.width/2;
		 
		 captionGizmoOver.y=containerHeight+20;
		 
		 captionGizmoOver.visible=false;
		  
		 loadText.visible=false;
		
		 isLoading=false;
		 
		 notReady=false;
		 
		 doRotate(0);
		 
		 rotateRight=false;
		 
		 rotateLeft=false;
		 
		 this.addEventListener(Event.ENTER_FRAME,onEnter);
		 
		 rightArrow.addEventListener(MouseEvent.ROLL_OVER, rightOver);
		 
		 rightArrow.addEventListener(MouseEvent.ROLL_OUT, rightOut);
		 
		 leftArrow.addEventListener(MouseEvent.ROLL_OVER, leftOver);
		 
		 leftArrow.addEventListener(MouseEvent.ROLL_OUT, leftOut);
		 
		 leftArrow.visible=true;
		 
		 rightArrow.visible=true;
		 
		 this.addChild(loadSpinner);
		 
		 loadSpinner.visible=false;
		
		 loadSpinner.x=containerWidth/2-150;
		
		 loadSpinner.y=containerHeight/2-100;
		  
   }
   
   private function photoLoadError(e:IOErrorEvent):void {
	   
	loadText.visible=true;
	
	loadText.loadTextBox.text="There has been an error loading the image. The server\nmay be busy. Try refreshing the page.";
	
	loadSpinner.visible=false;
	
	loadSpinner.stopSpinner();
	
   }
   
   private function donePhotoLoad(e:Event):void {
	
	loadSpinner.visible=false;
	
	loadSpinner.stopSpinner();
	
	photoHolder.visible=true;
	
	isLoading=false;
	
	captionGizmo.visible=true;
	
  }
  
    private function rightOver(e:MouseEvent):void {
	
	  rotateRight=true;
	
    }
	
	private function rightOut(e:MouseEvent):void {
	
	  rotateRight=false;
	
    }
	
	private function leftOver(e:MouseEvent):void {
	
	  rotateLeft=true;
	
    }
	
	private function leftOut(e:MouseEvent):void {
	
	  rotateLeft=false;
	
    }
	
	private function onEnter(e:Event):void {
		
	  if(isLoading || notReady){
		  
		  return;
		  
	  }
	
	  if (rotateRight){
		
	    this.doRotate(-0.5);
	  }
		
		
     if (rotateLeft){
	  
	    this.doRotate(0.5);
	  
      }
	
}
  
    private function thumbOver(e:MouseEvent):void {
	
	  var a:Array=parseIndices(e.target.name);
	  
	  holdersRefArray[a[0]][a[1]].filters=[new GlowFilter(colorGlow)];
	  
	  captionGizmoOver.visible=true;
	  
	  captionGizmoOver.captionTextBox.text=capsArray[Number(a[0])][Number(a[1])];
	  
    }
	
	private function thumbOut(e:MouseEvent):void {
	
	  var a:Array=parseIndices(e.target.name);
	  
	  holdersRefArray[a[0]][a[1]].filters=[];
	  
	  captionGizmoOver.visible=false;
	  
	  captionGizmoOver.captionTextBox.text="";

    }
	
	private function thumbClick(e:MouseEvent):void {
		
	 if(isLoading || notReady){
		 
		 return;
		 
	 }
	 
	 if(this.contains(container)){
		
		this.removeChild(container);
	}
	 
	 isLoading=true;
	 
	 loadSpinner.visible=true;
	
	 loadSpinner.startSpinner();
	 
	 var a:Array=parseIndices(e.target.name);
	 
	 loader.load(new URLRequest(picsArray[Number(a[0])][Number(a[1])]));
	  
	 captionGizmo.captionTextBox.text=capsArray[Number(a[0])][Number(a[1])];
	  
    }
	
	private function photoClick(e:MouseEvent):void {
		
	 if(isLoading || notReady){
		 
		 return;
		 
	 }
		 
	  photoHolder.visible=false;
	   
	  captionGizmo.visible=false;
	  
	  captionGizmo.captionTextBox.text="";
	  
	  if(!this.contains(container)){
		
		this.addChild(container);
	}
	  

    }
	
	
	private function parseIndices(s:String):Array {
		
		var a:Array=[];
		
		a=s.split("_");
		
		return [Number(a[0]), Number(a[1])];
		
	}


	
		
	public function doRotate(ang:Number):void {
		
		    if(isLoading || notReady){
		 
		            return;
		 
	          }
			
			if(!this.contains(container)){
				
				return;
				
			}
			
			var i:int;
			
			var dim:Number;
			
			 for(i=0;i<numCols;i++){
				 
			   colsVec[i].rotationY+=ang;
			   
			   colsVec[i].rotationY=colsVec[i].rotationY%360;
			  
			   if((colsVec[i].rotationY>90-diffAng && colsVec[i].rotationY<270+diffAng) || (colsVec[i].rotationY<-(90-diffAng) && colsVec[i].rotationY>-(270+diffAng))){
		
		              if(container.contains(colsVec[i])){
						  
						  container.removeChild(colsVec[i]);
						  
					  }
		
	                 } else {    
							   if(!container.contains(colsVec[i])){
		
		                         container.addChild(colsVec[i]);
								 
								
							   }
								   
	                         }
							 
				
	               if(container.contains(colsVec[i])){
					   
					   dim=Math.pow(minLight+(1-minLight)*Math.cos(colsVec[i].rotationY*Math.PI/180),2);
					   
					   colsVec[i].transform.colorTransform=new ColorTransform(dim,dim,dim);
					  
					   
				   }
			 }
			
		}
		
		
		
	}
	
	
}

