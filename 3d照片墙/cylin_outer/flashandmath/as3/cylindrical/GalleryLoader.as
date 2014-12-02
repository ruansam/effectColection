/* ***********************************************************************
ActionScript 3 Tutorial by Barbara Kaskosz

http://www.flashandmath.com/

Last modified: January 23, 2010
************************************************************************ */

package flashandmath.as3.cylindrical { 
	
	import flash.display.Loader;
	
	import flash.display.BitmapData;
	
	import flash.display.Bitmap;
	
	import flash.events.EventDispatcher;
	
	import flash.events.Event;
	
	import flash.events.IOErrorEvent;
	
	import flash.net.URLRequest;
	
	import flash.net.URLLoader;
	
	
    public class GalleryLoader extends EventDispatcher {
		
		  public static const ALL_LOADED:String = "allLoaded";
		  
		  public static const XMLLOAD_ERROR:String = "xmlLoadError";
		  
		  public static const IMGSLOAD_ERROR:String = "imgsLoadError";
		   
		  private var xmlRequest:URLRequest;
		  
		  private var xmlLoader:URLLoader;
		  
		  private var xmlContent:XML;
		  
		  private var numImgs:int;
		    
		  private var isError:Boolean;
		  
		  private var _bmpDataArray:Array;
		  
		  private var _capsArray:Array;
		  
		  private var _picsArray:Array;
		  
		  private var _picWidth:Number;
		  
		  private var _picHeight:Number;
		  
		  private var _radius:Number;
		  
		  private var _numCols:int;
		  
		  private var _colLen:int;
		  
		  private var _pxSpace:Number;
		  
		  private var thumbsToLoad:Array;
		  
		  private var thumbsLoader:ThumbsLoader;
		  
		  
	     public function GalleryLoader(xml:String){
			  
		     xmlRequest=new URLRequest(xml);
		  
	             }
	
	
	   public function loadXML():void {
		   
		   xmlLoader=new URLLoader();
		   
		   xmlLoader.addEventListener(Event.COMPLETE, xmlLoadComplete);
		   
           xmlLoader.addEventListener(IOErrorEvent.IO_ERROR, xmlError);
		
		   xmlLoader.load(xmlRequest);
		
	    }
		
	   private function xmlLoadComplete(e:Event):void {
	
	     xmlContent = new XML(xmlLoader.data);
	
	     xmlLoader.removeEventListener(Event.COMPLETE, xmlLoadComplete);
		   
         xmlLoader.removeEventListener(IOErrorEvent.IO_ERROR, xmlError);
		 
		 procXML();
		 
     }
	 
	 private function procXML():void {
		 
		 var i:int;
		 
		 var j:int;
		 
		 _numCols=xmlContent.col.length();
		 
		 _colLen=xmlContent.col[0].tile.length();
		 
		 _radius=Number(xmlContent.props.@radius);
		 
		 _pxSpace=Number(xmlContent.props.@pxspace);
		 
		 _picWidth=Number(xmlContent.props.@picwidth);
		 
		 _picHeight=Number(xmlContent.props.@picheight);
		 
		 thumbsToLoad=[];
		 
		 _bmpDataArray=[];
		  
		 _picsArray=[];
		 
		 _capsArray=[];
		 
		 for(i=0;i<_numCols;i++){
			 
			 _bmpDataArray[i]=new Vector.<BitmapData>(colLen);
			 
			 _picsArray[i]=new Vector.<String>(colLen);
			 
			 _capsArray[i]=new Vector.<String>(colLen);
			 
			 for(j=0;j<_colLen;j++){
				 
				 thumbsToLoad.push(xmlContent.col[i].tile[j].thumb.toString());
				 
				 _picsArray[i][j]=xmlContent.col[i].tile[j].pic.toString();
				 
				 _capsArray[i][j]=xmlContent.col[i].tile[j].cap.toString();
				 
			 } 
		 }
		 
		 
		 thumbsLoader=new ThumbsLoader();
		 
		 thumbsLoader.addEventListener(ThumbsLoader.IMGS_LOADED,imgsDone);
		 
		 thumbsLoader.addEventListener(ThumbsLoader.LOAD_ERROR,imgsError);
		 
		 thumbsLoader.loadImgs(thumbsToLoad);
		
	 }
	 
	 private function imgsError(e:Event):void {
		
		dispatchEvent(new Event(GalleryLoader.IMGSLOAD_ERROR));
		
	}
	
	private function imgsDone(e:Event):void {
		
		 var i:int;
		 
		 var j:int;
		
		thumbsLoader.removeEventListener(ThumbsLoader.IMGS_LOADED,imgsDone);
		 
		thumbsLoader.removeEventListener(ThumbsLoader.LOAD_ERROR,imgsError);
		
		for(i=0;i<_numCols;i++){
			 
			 for(j=0;j<_colLen;j++){
				 
				 _bmpDataArray[i][j]=thumbsLoader.bitmapsArray[i*colLen+j].clone();
				 
				 thumbsLoader.bitmapsArray[i*colLen+j].dispose();
				 
				 
			 }
			
		}
		
		dispatchEvent(new Event(GalleryLoader.ALL_LOADED));
		
		
	}

     

	private function xmlError(e:IOErrorEvent):void {
		
	
		dispatchEvent(new Event(GalleryLoader.XMLLOAD_ERROR));
		
	}
	
	
	
	public function get bmpDataArray():Array {
		
		return _bmpDataArray;
		
	}
	
	public function get picsArray():Array {
		
		return _picsArray;
		
	}
	
	public function get capsArray():Array {
		
		return _capsArray;
		
	}
	
	public function get radius():Number {
		
		return _radius;
		
	}
	
	public function get numCols():int {
		
		return _numCols;
		
	}
	
	public function get colLen():int {
		
		return _colLen;
		
	}
	
	public function get pxSpace():int {
		
		return _pxSpace;
		
	}
	
	public function get picWidth():Number {
		
		return _picWidth;
		
	}
	
	public function get picHeight():Number {
		
		return _picHeight;
		
	}
	
	
   }

}