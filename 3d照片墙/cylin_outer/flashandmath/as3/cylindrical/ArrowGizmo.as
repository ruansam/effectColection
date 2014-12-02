
/*
ActionScript 3 Tutorials by Barbara Kaskosz.

www.flashandmath.com

Last modified: January 23, 2010. 

*/


 
package flashandmath.as3.cylindrical {
	
	
	 import flash.display.Sprite;
  
     
	 public class ArrowGizmo extends Sprite {
		 
        
		public function ArrowGizmo() {
			 
		  drawGizmo();
		  
		  this.buttonMode=true;
		     
		}
		
		
		private function drawGizmo():void {
			
			this.graphics.lineStyle();
			
			this.graphics.beginFill(0x666666,0.7);
			
			this.graphics.moveTo(0,-40)
			
			this.graphics.lineTo(0,40);
			
			this.graphics.lineTo(16,0);
			
			this.graphics.lineTo(0,-40);
			
			this.graphics.endFill();
			
		}
		
		
		
	}
	
	
}

