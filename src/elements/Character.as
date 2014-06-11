package elements
{
	import flash.geom.Rectangle;
	
	import events.CharacterEvent;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
//	import starling.text.TextField;
//	import starling.utils.HAlign;
	
	import utils.Animator;
	
	public class Character extends Sprite
	{
		private var m_id:String;
//		private var m_characterImages:Object;
		
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


		public function textureBounds():Rectangle
		{
			return m_image.bounds;
		}
		
		// 생성자 함수.
		public function Character(id:String = "")
		{
			super();
			m_id = id;
			
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage():void
		{
			m_image = new Image(Assets.gameTextureAtlas.getTexture("charac" + m_id));
			this.addChild(m_image);
		}
		
		/**
		 * 대사를 갱신한다.
		 */
		public function act():void
		{
			this.dispatchEvent(new CharacterEvent(CharacterEvent.ACTING));
			appear();
		}
		
		private function appear():void
		{
			Animator.moveTo(m_image, position);
			Animator.bottopUp(m_image);
		}
		
	}
}