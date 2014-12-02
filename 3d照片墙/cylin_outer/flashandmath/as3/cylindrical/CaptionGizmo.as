
/*
ActionScript 3 Tutorials by Barbara Kaskosz.

www.flashandmath.com

Last modified: January 23, 2010. 

*/


 
package flashandmath.as3.cylindrical {
	
	
	 import flash.display.Sprite;
	 
	 import flash.text.TextField;
	 
	 import flash.text.TextFieldType;
	 
	 import flash.text.TextFieldAutoSize;
	 
	 import flash.text.TextFormat;
	 
	 import flash.text.TextFormatAlign;
  
     
	 public class CaptionGizmo extends Sprite {
		 
		 
		 public var captionTextBox:TextField;
		 
		
		public function CaptionGizmo(cl:Number) {
			
		  setUpText(cl);
		     
		}
		
		internal function setUpText(c:Number):void {
			
			var format:TextFormat=new TextFormat();
			
			captionTextBox=new TextField();
			
			captionTextBox.type=TextFieldType.DYNAMIC;
			
			captionTextBox.multiline=true;
			
			captionTextBox.mouseEnabled=false;
			
			captionTextBox.width=300;
			
			format.align=TextFormatAlign.CENTER;
			
		    format.color=c;
		
		    format.size=12;
		
		    format.font="Arial";
		
		    captionTextBox.defaultTextFormat=format;
		
		    captionTextBox.text="";
			
			this.addChild(captionTextBox);
			
			
		}
		
		
	}
	
	
}

