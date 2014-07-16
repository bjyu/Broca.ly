package elements
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.ImageDecodingPolicy;
	import flash.system.LoaderContext;
	
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class WebImage extends Image
	{
		private var m_loader:Loader;
		private var _url:String;

		public function get url():String
		{
			return _url;
		}

		public function set url(value:String):void
		{
			_url = value;
		}

		
		public function WebImage(url:String)
		{
			super(Assets.getTexture("space"));
			
			_url = url;
			
		}
		
		public function loadImage():void
		{
			m_loader = new Loader();
			var loaderContext:LoaderContext = new LoaderContext();
			loaderContext.imageDecodingPolicy = ImageDecodingPolicy.ON_LOAD;
			// var imageSrc:String = "http://cfs6.tistory.com/upload_control/download.blog?fhandle=YmxvZzY0NTE2QGZzNi50aXN0b3J5LmNvbTovYXR0YWNoLzAvMjkuanBn";
			m_loader.load(new URLRequest(_url), loaderContext);
			m_loader.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE, onLoadComplete);
		}
		
		protected function onLoadComplete(event:flash.events.Event):void
		{
			this.texture = Texture.fromBitmap(Bitmap(LoaderInfo(event.target).content));
			m_loader.contentLoaderInfo.removeEventListener(flash.events.Event.COMPLETE, onLoadComplete);
			m_loader = null;
			
			width = texture.width;
			height = texture.height;
			
			this.dispatchEvent(new starling.events.Event("imageLoaded"));
		}
	}
}