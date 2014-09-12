/**
 * 캐릭터 등장에 필요한 모든 것을 관리한다.
 * 
 * --> to-be
 * 캐릭터 자원 불러오기.
 * 캐릭터 위치 조정.
 * 캐릭터 애니메이션?
 */
package managers
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.net.URLRequest;
	import flash.system.ImageDecodingPolicy;
	import flash.system.LoaderContext;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	
	import elements.Character;
	
	import feathers.layout.ViewPortBounds;
	
	import ly.broca.controller.RootController;
	import ly.broca.model.CharacterModel;
	import ly.broca.model.RootModel;
	
	import starling.animation.IAnimatable;
	import starling.animation.Juggler;
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.EventDispatcher;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	
	import utils.Animator;
	import utils.CharacterStack;
	import utils.Isomatric;

	public class CharacterManager extends starling.events.EventDispatcher
	{
		private static var _texture:Texture;
		private var m_loader:Loader;
		
		// 캐릭터 배치를 위한 배열이다. 
		private var m_stack:CharacterStack;
		
		private var m_posArr:Array;
		
		private var onComplete:Function;
		
		// 캐릭터 정보를 갖는다.
		public var characters:Dictionary;
		
		public var sideUnit:Number = 200;
		
		public var rootView:Sprite;
		
		private var _numCharacters:uint = 0;
		private var m_startInfo:Object;

		public function get numCharacters():uint
		{
			return _numCharacters;
		}

		public function set numCharacters(value:uint):void
		{
			if (value != _numCharacters)
			{
				_numCharacters = value;
			}
		}
		
		public function CharacterManager(startInfo:Object, onComplete:Function)
		{
			m_startInfo = startInfo;
			this.onComplete = onComplete;
			// To Do # init models
//			m_stack = new CharacterStack();
//			characters = new Dictionary();
			
			// init image resources
			// after loading resources, call showUp function.
			initializeImage();
		}
		
		// To Do # lobby 구성시 필요, 다른 클래스로 이동할 것.
		public function initLocationMatrix():void
		{
			// set array for player numbers
			switch (numCharacters)
			{
				case 2:
					m_posArr = 
					[0,0,1],
					[0,0,0],
					[1,0,0];
					break;
				
				case 3:
					m_posArr =
					[0,0,1],
					[0,1,0],
					[1,0,0];
					break;
				
				case 4:
					m_posArr = 
					[0,0,1],
					[0,0,1],
					[1,1,0];
					break;
				
				case 5:
					m_posArr = 
					[0,1,1],
					[1,0,0],
					[1,0,1];
					
				case 6:
					m_posArr =
					[0,1,1],
					[1,0,1],
					[1,1,0];
					break;
				
				default:
					break;
			}
		}
		
		
		/** 
		 * 캐릭터들을 등장시킨다.
		 */
		public function showUp():void
		{
			// To Do # 구현.
			var gapH:Number = Main.STAGE_WIDTH - 200;
			var gapV:Number = Main.STAGE_HEIGHT - 300;
			var r:Number = Math.min(gapH, gapV);
			
			var centerX:Number = Main.STAGE_WIDTH / 2;
			// To Do # Device별 정리 필요.
			var centerY:Number = 688 / 2; 
			
			var i:uint = 0;
			for (var c:Character in characters)
			{
//				var t:Number = (Math.PI * 2 / numCharacters) * i - Math.PI; // 9o'clock orient
//				var newX:Number = centerX + (r * Math.cos(t));
//				var newY:Number = centerY + (r * Math.sin(t));
				i++;
				
//				trace(new Point(newX, newY).toString());
			}
			
			
			// get character from position array
			/*
			for (u in user)
			{
				
			}
			
			*/
			
			// tile: 3x3, object 2x3
//			Isomatric.convert2dToIsometric(
			
			
			// 5 layers
			
			// 1) x1: w / 3 
			// 2) x1: w / 3 / 2, x2: x1+ w/3 
			// 3) x1: w / 3, x2: w / 3 * i, ..
			// 4) x1: same with 2)
			// 5) x1: same with 1)
			
		}
		
		
		/**
		 * 캐릭터를 새로 등록한다.
		 */
		public function newCharacter(id:String):Character
		{
			if (characters[id] == null)
				characters[id] = new Character(id);
			
			var character:Character = characters[id];
//			character.addEventListener(CharacterEvent.ACTING, onActing);
			
			return characters[id];
		}
		
//		private function onActing(event:CharacterEvent):void
//		{
//			var character:Character = event.target as Character;
//			if (character)
//			{
//				// 다시 포지셔닝 한다.
//				direct(character);
//			}
//		}
		
		
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
		 * 대사를 갱신한다.
		 */
		public function act(character:Character):void
		{
			m_stack.push(character);
			
			character.act();
			
//			character.scaleX = 1;
//			character.scaleY = 1;
			
			
			if (!character.isAppeared) /* stage hasn't this character*/
			{
				var tween:Tween = new Tween(character, 1.0, Transitions.EASE_IN);
				character.y = character.textureBounds.height;
				character.pivotY = character.height;
				character.height = 0;
				
				switch (character.matrixPos.x > character.matrixPos.y)
				{
					case 0:
						character.x = -character.width;
						tween.moveTo(0, character.y);
						
						break;
					
					case 1:
						
						character.x = Main.STAGE_WIDTH;
						tween.moveTo(Main.STAGE_WIDTH - character.width, character.y);
						break;
				}

				tween.animate("height", character.textureBounds.height);
				tween.onComplete = function():void
					{
						Starling.juggler.remove(tween);
						tween = null;
					};
				Starling.juggler.add(tween);
				
					
//				Animator.moveTo(character, character.position);
//				Animator.bottomUp(character);

//				character.isAppeared = true;
			}
			
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
			// var imageSrc:String = "http://cfs6.tistory.com/upload_control/download.blog?fhandle=YmxvZzY0NTE2QGZzNi50aXN0b3J5LmNvbTovYXR0YWNoLzAvMjkuanBn";
			var imageSrc:String = "http://cfile28.uf.tistory.com/original/2229124451EE947D06D061";
			m_loader.load(new URLRequest(imageSrc), loaderContext);
			m_loader.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE, onLoadComplete);
			
			// http://blogfiles.naver.net/20140317_293/sisaem9_1395041195241SPYCB_PNG/%B3%AA%C0%CC%BD%BA%C1%F8.png
			// http://cfile8.uf.tistory.com/original/2532BF4451EE947A013CBB
			// http://cfile30.uf.tistory.com/original/2513F84451EE94782CFA58
			
			// http://cfile28.uf.tistory.com/original/2229124451EE947D06D061
		}
		
		private function initializeMVC():void
		{
			var root:RootModel = new RootModel();
			rootView = new Sprite();
			
			var infoArr:Array = m_startInfo.info;
			for(var i:int = 0; i < infoArr.length ; i++)
			{
				var model:CharacterModel = new CharacterModel();
				
				model.characterID = infoArr[i].characterID;
				model.faceID = model.characterID;
				model.matrixPos = new Point(int(infoArr[i].isoX), int(infoArr[i].isoY));
				
				root.addChild(model);
				numCharacters++;
			}
			
			trace("numCharacters: " + numCharacters);
			
			var rootController:RootController = new RootController(root, rootView);
			var self:EventDispatcher = this;
			rootController.addEventListener("characterTouched", 
				function(e:starling.events.Event):void
				{
					// bubble manually.
					self.dispatchEvent(e);
				}
			);
			
			rootView.addEventListener(TouchEvent.TOUCH,
				function(e:TouchEvent):void
				{
					if (e.getTouch(rootView, TouchPhase.ENDED))
					{
						self.dispatchEvent(new starling.events.Event("outsideTouched", false, rootView));
						trace(getQualifiedClassName(e.currentTarget));
					}
				}
			);
		}
		
		protected function onLoadComplete(event:flash.events.Event):void
		{
			_texture = Texture.fromBitmap(Bitmap(LoaderInfo(event.target).content));
//			Assets.addEventListener("loaded", appear);
			Assets.getAtlas(Assets.DefaultAtlasName, _texture);
			
			m_loader.contentLoaderInfo.removeEventListener(flash.events.Event.COMPLETE, onLoadComplete);
			m_loader = null;
			
			this.dispatchEvent(new starling.events.Event("imageLoaded"));
			
			Assets.addEventListener(Assets.DefaultAtlasName + "Loaded", function():void {

	//			showUp();
				initializeMVC();
				onComplete();
			});
		}
		
	}
}