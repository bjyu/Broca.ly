/**
 * Scene에 표현되는 캐릭터이다.
 */
package elements
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.getQualifiedClassName;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.textures.Texture;
	
	public class Character extends Sprite
	{
		private var _characterID:String;

		public function set characterID(value:String):void
		{
			_characterID = value;
		}


		public function get characterID():String
		{
			return _characterID;
		}

		private var _matrixPos:Point = new Point();

		/**
		 * 2D position for isometric
		 */
		public function get matrixPos():Point
		{
			return _matrixPos;
		}

		/**
		 * @private
		 */
		public function set matrixPos(value:Point):void
		{
			_matrixPos = value;
		}

		
		private var _isAppeared:Boolean = false;

		public function get isAppeared():Boolean
		{
			return _isAppeared;
		}

		public function set isAppeared(value:Boolean):void
		{
			_isAppeared = value;
		}
		
		private var _faceID:String;

		public function get faceId():String
		{
			return _faceID;
		}

		public function set faceId(value:String):void
		{
			if (value != _faceID)	
			{
				_faceID = value;
				this.name = value;
//				act();
			}
		}

		
//		private var m_characters:Array = new Array("dog", "duck");
		private var m_textures:Vector.<Texture>;
		
		private var m_image:Image;
		
		private var _direction:String = "right";

		/**
		 * direction (left/right)
		 */
		public function get direction():String
		{
			return _direction;
		}

		/**
		 * @private
		 */
		public function set direction(value:String):void
		{
			if (value != _direction)
			{
				_direction = value;
				if (m_image)
					this.m_image.scaleX *= -1;
			}
		}


		public function get textureBounds():Rectangle
		{
			return m_image.bounds;
		}
		
		// 생성자 함수.
		public function Character(id:String = "")
		{
			super();
			_characterID = id;
			
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		
		private function onAddedToStage():void
		{
//			m_textures = Assets.getAtlas(Assets.DefaultAtlasName).getTextures(m_characters[int(_characterID)]);
//			m_textures = Assets.getAtlas(Assets.DefaultAtlasName).getTextures(characterID);
//			m_image = new Image(m_textures[0]);
			
			m_image = new Image(Assets.getAtlas("CharactersAtlas").getTexture(characterID));
			
			// To Do # 계산된 값으로 사용 할 것.
//			m_image.width = 200;
//			m_image.height = 300;
			
			this.addChild(m_image);
			
//			bgImg.pivotX = m_image.x + m_image.width  / 2;
//			this.pivotY = m_image.height / 2;
			//			
//			bgImg.scaleX = (matrixPos.x > matrixPos.y ? -1 : 1);
			m_image.scaleX = m_image.scaleY = Main.STAGE_WIDTH / 3 / m_image.width * 0.75;
//			this.scaleX *= (matrixPos.x > matrixPos.y ? -1 : 1);
			
			m_image.x = Main.STAGE_WIDTH / 3 * 0.25 / 2;
			
			if (matrixPos.x > matrixPos.y)
			{
				m_image.scaleX *= -1;
				m_image.x += m_image.width;
			}
			
//			trace("bounds1: " + this.bounds.toString());
//			trace("bounds2: " + m_image.bounds.toString());
		}
		
		/** 표정을 바꾼다. (이미지 교체) */
		public function act():void
		{
			if (faceId)
				m_image.texture = Assets.getAtlas(Assets.DefaultAtlasName).getTexture(faceId); //m_textures[int(Math.random()*3)];
			else 
				m_image.texture = m_textures[0];
		}
		
	}
}