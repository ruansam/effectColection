
/*
ActionScript 3 Tutorials by Barbara Kaskosz.

www.flashandmath.com

Last modified: January 23, 2010. 

*/


 
package flashandmath.as3.cylindrical {
	
	
	 import flash.display.Sprite;
	 
	 import flash.display.Shape;
	 
	 import flash.events.Event;
	 
	 import flash.geom.Rectangle;
	 
	 
	 public class LoadSpinner extends Sprite {
		 
		 
		 private var back:Shape;
		 
		 private var spinner:Shape;
		 
		 private var rectWidth:Number;
		 
		 private var rectHeight:Number;
		 
		 private var sticks:Vector.<Shape>;
		 
		 private var numSticks:int;
		 
		 private var count:int;
		 
        
		public function LoadSpinner(w:Number,h:Number) {
			
		  rectWidth=w;
		  
		  rectHeight=h;
		  
		  numSticks=12;
		  
		  count=0;
		  
		  sticks= new Vector.<Shape>(numSticks);
		  
		  var i:int;
		  
		  for(i=0;i<numSticks;i++){
				  
				sticks[i]=new Shape();
				
				this.addChild(sticks[i]);
				
				sticks[i].x=rectWidth/2;
				
				sticks[i].y=rectHeight/2;
				
		  }
			
		  drawBack();
		  
		  drawSpinner(count);
		     
		}
		
		 private function drawBack():void {
			 
			this.graphics.lineStyle(1,0x666666,0.7);
			
			this.graphics.beginFill(0x666666,0.5);
			
			this.graphics.drawRect(0,0,rectWidth,rectHeight);
			
			this.graphics.endFill();
			 
			
			
		 }
		 
		  private function drawSpinner(k:int):void {
			  
			 
			  var minRad:Number=10;
			  
			  var maxRad:Number=20;
			  
			  var ang=Math.PI*2/numSticks;
			  
			  var i:int;
			  
			  for(i=0;i<numSticks;i++){
				  
				sticks[i].graphics.clear();
				
				if(i==k){
				
				  sticks[i].graphics.lineStyle(1,0xCC3300);
				
				} else {
					
				   sticks[i].graphics.lineStyle(1,0x999999);
				   
				}
				
				sticks[i].graphics.moveTo(minRad*Math.cos(i*ang),minRad*Math.sin(i*ang));
				
				sticks[i].graphics.lineTo(maxRad*Math.cos(i*ang),maxRad*Math.sin(i*ang));
				  
			  }
			  
			  
			  
		  }
		  
		  
		  
		  public function stopSpinner():void {
			  
			  this.removeEventListener(Event.ENTER_FRAME,doSpin);
			  
			  count=0;
			  
			  drawSpinner(0);
			  
		  }
		  
		  public function startSpinner():void {
			  
			  this.addEventListener(Event.ENTER_FRAME,doSpin);
			  
		  }
		  
		  private function doSpin(e:Event):void {
			  
			  count+=1;
			  
			  count=count%numSticks;
			  
			  drawSpinner(count);
			  
			  
			  
		  }
		
		
	}
	
	
}

