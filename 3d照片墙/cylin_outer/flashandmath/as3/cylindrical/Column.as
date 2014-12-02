
/*
ActionScript 3 Tutorials by Barbara Kaskosz.

www.flashandmath.com

Last modified: January 23, 2010. 

*/


 
package flashandmath.as3.cylindrical {
	
	
	 import flash.display.Sprite;
	 
	 import flash.display.Bitmap;
	 
	 import flash.display.BitmapData;
  
     
	 public class Column extends Sprite {
		 
        internal var numThumbs:int;
		
		internal var thumbWidth:Number;
		
		internal var thumbHeight:Number;
		
		internal var thumbsVec:Vector.<Bitmap>;
	
		internal var holdersVec:Vector.<Sprite>;
		
		internal var pxSpace:int;

		public var colHeight:Number;
		
		public var colWidth:Number;
		
		public var rad:Number;
		
		public var picsVec:Vector.<String>;
		
		public function Column(thumbs:Vector.<BitmapData>,px,r) {
			
		  var i:int;
		
		  pxSpace=px;
		  
		  numThumbs=thumbs.length;
		  
		  thumbWidth=thumbs[0].width;
			 
		  thumbHeight=thumbs[0].height;
		  
		  holdersVec=new Vector.<Sprite>();
			 
		  thumbsVec=new Vector.<Bitmap>();
			 
		  picsVec=new Vector.<String>();
		  
		  colHeight=thumbHeight*numThumbs+(numThumbs-1)*pxSpace;
		  
		  colWidth=thumbWidth;
		  
		  rad=r;
		     
		  for(i=0;i<numThumbs;i++){
			  
			  thumbsVec[i]= new Bitmap(thumbs[i].clone());
			  
			  thumbs[i].dispose()
			  
			  thumbsVec[i].scaleX=thumbWidth/(thumbWidth+1);
			  
			  thumbsVec[i].scaleY=thumbHeight/(thumbHeight+1);
			  
			  holdersVec[i]=new Sprite();
			  
			  holdersVec[i].scaleX=(thumbWidth+1)/(thumbWidth+2);
			  
			  holdersVec[i].scaleY=(thumbHeight+1)/(thumbHeight+2);
			  
			  holdersVec[i].addChild(thumbsVec[i]);
			  
			  thumbsVec[i].x=-thumbWidth/2;
			  
			  this.addChild(holdersVec[i]);
			  
			  holdersVec[i].x=0;
			  
			  holdersVec[i].y=i*thumbHeight+i*pxSpace-colHeight/2;
			  
			  holdersVec[i].z=-rad;
			   
		  }
		  
		  
		     
		}
		
		
	}
	
	
}

