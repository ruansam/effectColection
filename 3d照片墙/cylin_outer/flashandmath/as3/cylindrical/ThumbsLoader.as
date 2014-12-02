/* ***********************************************************************
ActionScript 3 Tutorial by Barbara Kaskosz

http://www.flashandmath.com/

Last modified: January 23, 2010
************************************************************************ */

package flashandmath.as3.cylindrical { 
	
	import flash.display.Loader;
	
	import flash.display.Bitmap;
	
	import flash.display.BitmapData;
	
	import flash.events.Event;
	
	import flash.events.EventDispatcher;
	
	import flash.events.IOErrorEvent;
	
	import flash.net.URLRequest;
	
	
    public  class ThumbsLoader extends EventDispatcher {
		
		  public static const IMGS_LOADED:String = "imgsLoaded";
		  
		  public static const LOAD_ERROR:String = "loadError";
		
		  private var loadersArray:Array;
		  
		  private var numImgs:int;
		  
		  private var numLoaded:int;
		  
		  private var isError:Boolean;
		  
		  private var _bitmapsArray:Array;
		  
		  private var loadCanRun:Boolean;
	   
	      public function ThumbsLoader(){
		  
		
		   this.loadCanRun=true;
		  
	}
	
	
	
	public function loadImgs(imgsFiles:Array):void {
		
		   if(loadCanRun){
			   
			loadCanRun=false;
		
		    numLoaded=0;
			
			isError=false;
			
			numImgs=imgsFiles.length;
			
		    _bitmapsArray=[];
			
		    loadersArray=[];
		   
		   for(var i:int=0;i<numImgs;i++){
			   
			  loadersArray[i]=new Loader(); 
			  
			  loadersArray[i].contentLoaderInfo.addEventListener(Event.COMPLETE, imgLoaded);
			  
			  loadersArray[i].contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, errorOccured);
		
		      loadersArray[i].load(new URLRequest(imgsFiles[i]));
			   
		   }
		   
		   }
		
	}
	
	private function imgLoaded(e:Event):void {
		
		numLoaded+=1; 
	
		checkLoadStatus();
		
	}
	
	
	private function errorOccured(e:IOErrorEvent):void {
		
		isError=true;
	
		dispatchEvent(new Event(ThumbsLoader.LOAD_ERROR));
		
	}
	
	
	
	private function checkLoadStatus():void { 
		
		var i:int; 
		
		if(numLoaded==numImgs && isError==false){
			
			 for(i=0;i<numImgs;i++){
				
			  _bitmapsArray[i]=Bitmap(loadersArray[i].content).bitmapData;
		 
		   }
		  
		  for(i=0;i<numImgs;i++){
			  
			  loadersArray[i].contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, errorOccured);
			   
			  loadersArray[i].contentLoaderInfo.removeEventListener(Event.COMPLETE, imgLoaded);
		
		      loadersArray[i]=null;
			   
		   }
		   
		   loadersArray=[];
		   
		   loadCanRun=true;
		   
		   dispatchEvent(new Event(ThumbsLoader.IMGS_LOADED));
		   
		}
	
	}
	
	public function get bitmapsArray():Array {
		
		return _bitmapsArray;
		
	}
	
	
   }

}