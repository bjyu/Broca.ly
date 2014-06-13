package 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	import starling.events.Event;
	import starling.events.EventDispatcher;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class Assets
	{
		
		private static var gameTextures:Dictionary = new Dictionary();
		public static var gameTextureAtlas:TextureAtlas;
		public static var dispatcher:EventDispatcher = new EventDispatcher();
		
		
		public static function getAtlas(texture:Texture):void
		{
			
			if (gameTextureAtlas == null)
			{
				var xml:XML;
				var loader:URLLoader = new URLLoader();
//				loader.load(new URLRequest("DynamicAtlasTest.xml"));
				loader.load(new URLRequest("KakaoAtlas.xml"));
				
				loader.addEventListener(flash.events.Event.COMPLETE,
					function(event:flash.events.Event):void
					{
						xml = new XML(event.target.data);
						gameTextureAtlas = new TextureAtlas(texture, xml);
						
						dispatcher.dispatchEvent(new starling.events.Event("loaded"));
					}
				);
			}
			
//			return gameTextureAtlas;
		}
		
		public static function addEventListener(type:String, listener:Function):void
		{
			dispatcher.addEventListener(type, listener);
		}
		
		public static function getTexture(name:String):Texture
		{
			if (gameTextures[name] == undefined)
			{
				var bitmap:Bitmap = new Assets[name]();
				gameTextures[name] = Texture.fromBitmap(bitmap);
			}
			return gameTextures[name];
		}
	}
}