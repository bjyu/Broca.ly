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
//		[Embed(source="../media/graphics/bgWelcome.jpg")]
//		public static const BgWelcome:Class;
		
		
		private static var gameTextures:Dictionary = new Dictionary();
		private static var gameTextureAtlases:Dictionary = new Dictionary();
//		public static var gameTextureAtlas:TextureAtlas;
		public static var dispatcher:EventDispatcher = new EventDispatcher();
		
		
		public static function getAtlas(name:String, texture:Texture = null):TextureAtlas
		{
			
			if (gameTextureAtlases[name] == undefined && texture)
			{
				var xml:XML;
				var loader:URLLoader = new URLLoader();
//				loader.load(new URLRequest("DynamicAtlasTest.xml"));
				// KakaoAtlas
				// defaultTheme, button(rect, circle),  
				loader.load(new URLRequest(name + ".xml"));
				
				loader.addEventListener(flash.events.Event.COMPLETE,
					function(event:flash.events.Event):void
					{
						xml = new XML(event.target.data);
						gameTextureAtlases[name] = new TextureAtlas(texture, xml);
						
						dispatcher.dispatchEvent(new starling.events.Event("loaded"));
					}
				);
			}
			
			return gameTextureAtlases[name];
		}
		
		public static function addEventListener(type:String, listener:Function):void
		{
			dispatcher.addEventListener(type, listener);
		}
		
		public static function getTexture(name:String):Texture
		{
			if (gameTextures[name] == undefined)
			{
				if (name == "space") {
					return gameTextures[name] = Texture.fromColor(100, 100);
				}
				
				var bitmap:Bitmap = new Assets[name]();
				gameTextures[name] = Texture.fromBitmap(bitmap);
			}
			return gameTextures[name];
		}
	}
}