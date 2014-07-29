/**
 * Scene에 표현되는 캐릭터이다.
 */
package elements
{
	import flash.geom.Rectangle;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class Character extends Sprite
	{
		private var _id:String;

		public function get id():String
		{
			return _id;
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

		
		private var m_characters:Array = new Array("dog", "duck");
		private var m_textures:Vector.<Texture>;
		
		private var m_image:Image;
		
		/**
		 * direction (left/right)
		 */
		public var direction:String = "left";
		
		private var _position:int = 0;

		/**
		 * 캐릭터의 위치 (위치별 아이디를 가질 수 있다. 네 자리중 왼쪽부터 0~3값을 갖는다.)
		 */
		public function get position():int
		{
			return _position;
		}

		/**
		 * @private
		 */
		public function set position(value:int):void
		{
			if (_position != value)
			{
				_position = value;
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
			_id = id;
			
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		
		private function onAddedToStage():void
		{
			m_textures = Assets.getAtlas("KakaoAtlas").getTextures(m_characters[int(_id)]);
			m_image = new Image(m_textures[0]);
			this.addChild(m_image);
		}
		
		// 표정을 바꾼다. (이미지 교체)
		public function act(faceId:String = ""):void
		{
			m_image.texture = m_textures[int(Math.random()*3)];
		}
		
	}
}