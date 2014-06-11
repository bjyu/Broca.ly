/**
 * 캐릭터 등장에 필요한 모든 것을 관리한다.
 */
package managers
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.ImageDecodingPolicy;
	import flash.system.LoaderContext;
	import flash.utils.Dictionary;
	
	import elements.Character;
	
	import events.CharacterEvent;
	
	import starling.events.Event;
	import starling.events.EventDispatcher;
	import starling.textures.Texture;
	
	import utils.CharacterStack;

	public class CharacterManager extends starling.events.EventDispatcher
	{
		private static var _texture:Texture;
		private var m_loader:Loader;
		private var m_stack:CharacterStack;
		
		public var characters:Dictionary;
		
		
		public function CharacterManager()
		{
			m_stack = new CharacterStack();
			characters = new Dictionary();
			
			// init image resources
			initializeImage();
		}
		
		/**
		 * 캐릭터를 새로 등록한다.
		 */
		public function newCharacter(id:String):Character
		{
			if (characters[id] == null)
				characters[id] = new Character(id);
			
			var character:Character = characters[id];
			character.addEventListener(CharacterEvent.ACTING, onActing);
			
			return characters[id];
		}
		
		private function onActing(event:CharacterEvent):void
		{
			var character:Character = event.target as Character;
			if (character)
			{
				// 다시 포지셔닝 한다.
				direct(character);
			}
		}
		
		
		// 캐릭터 등장 엔진  
		private function direct(character:Character):void
		{
			// 다시 포지셔닝 한다.
			
			// engine
			// 현재 포지셔닝
			// get
			
			
			// 다음 포지셔닝
			// set
			// 1. 캐릭터의 위치
			// 2. 캐릭터의 방향 (stare at)
			
			// FIRST OF ALL, Frame 선정
			// 1 / 2 / 3 / 4
			// left/right
			
			// case 1: 이미 있는 경우
			// case 2: 새로 등장하는 경우
			// case 3: 방향을 바꾸는 경우
			
			m_stack.push(character);
			
		}
		
		/**
		 * id로 캐릭터를 찾는다. 
		 */
		public function findCharacter(id:String):Character
		{
			if (characters[id] != null)
				return characters[id];
			
			return null;
		}
		
		/**
		 * 이미지를 불러온다.
		 */ 
		private function initializeImage():void
		{
			m_loader = new Loader();
			var loaderContext:LoaderContext = new LoaderContext();
			loaderContext.imageDecodingPolicy = ImageDecodingPolicy.ON_LOAD;
			var imageSrc:String = "http://cfs6.tistory.com/upload_control/download.blog?fhandle=YmxvZzY0NTE2QGZzNi50aXN0b3J5LmNvbTovYXR0YWNoLzAvMjkuanBn";
			m_loader.load(new URLRequest(imageSrc), loaderContext);
			m_loader.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE, onLoadComplete);
		}
		
		protected function onLoadComplete(event:flash.events.Event):void
		{
			_texture = Texture.fromBitmap(Bitmap(LoaderInfo(event.target).content));
//			Assets.addEventListener("loaded", appear);
			Assets.getAtlas(_texture);
			
			m_loader.contentLoaderInfo.removeEventListener(flash.events.Event.COMPLETE, onLoadComplete);
			m_loader = null;
			
			this.dispatchEvent(new starling.events.Event("imageLoaded"));
		}
		
		
			
	}
}