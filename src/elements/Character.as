package elements
{
	import flash.geom.Rectangle;
	
	import events.CharacterEvent;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	
	import utils.Animator;
	
	public class Character extends Sprite
	{
		private var m_id:String;
//		private var m_characterImages:Object;
		
		private var m_image:Image;
		private var m_words:String;
		private var m_textField:TextField;
		
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
			//			this.y = 300;
			
			m_textField = new TextField(300, 25, m_words);
			m_textField.border = true;
			m_textField.y = 150;
			this.addChild(m_textField);
		}
		
		/**
		 * 대사를 갱신한다.
		 */
		public function act(words:String):void
		{
			this.dispatchEvent(new CharacterEvent(CharacterEvent.ACTING));
			appear();
			m_textField.text = words;
		}
		
		private function appear():void
		{
			if (position == 0)
			{
				m_textField.hAlign = HAlign.LEFT;
				m_textField.x=10;
			} 
			else if (position == 3)
			{
				m_textField.hAlign = HAlign.RIGHT;
				m_textField.x = Main.STAGE_WIDTH - 300 - 10;
			}
			
			Animator.moveTo(m_image, position);
			Animator.bottopUp(m_image);
		}
		
	}
}