/*
 * Action Cancel Button. 
 */
package elements
{
	import flash.geom.Point;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.HAlign;
	
	public class ActionCancelButton extends Sprite
	{
		// text tip.
		private var m_text:TextField;
		
		// image
		private var m_image:Image;
		
		private var _activatedTexture:Texture;

		public function get activatedTexture():Texture
		{
			return _activatedTexture;
		}

		public function set activatedTexture(value:Texture):void
		{
			_activatedTexture = value;
		}

		
		private var _inactivatedTexture:Texture;

		public function get inactivatedTexture():Texture
		{
			return _inactivatedTexture;
		}

		public function set inactivatedTexture(value:Texture):void
		{
			_inactivatedTexture = value;
		}

		
		// init position
		public var initPoint:Point;
		
		private var _activated:Boolean = false;

		public function get activated():Boolean
		{
			return _activated;
		}

		public function set activated(value:Boolean):void
		{
			if (value != _activated)
			{
				trace(value);
				
				_activated = value;
				
				m_text.visible = _activated;
					
				// change image
				if (_activated)
				{
					m_image.texture = activatedTexture;
				} 
				else
				{
					if (inactivatedTexture)
						m_image.texture = inactivatedTexture;
				}
			}
			
		}
		
		private var _text:String;

		public function get text():String
		{
			return _text;
		}

		public function set text(value:String):void
		{
			if (value != _text)
			{
				_text = value;
				m_text.text = _text;
			}
		}
		
		private var _angleToBasis:Number;

		public function get angleToBasis():Number
		{
			return _angleToBasis;
		}

		public function set angleToBasis(value:Number):void
		{
			_angleToBasis = value;
		}
		
		// textField의 너비가 전체 너비에 영향이 없도록 한다.
		public override function get width():Number
		{
			return m_image.width;
		}
		
		
		// constructor
		public function ActionCancelButton(texture:Texture, text:String = "", inactivedTexture:Texture = null)
		{
			super();
			initPoint = new Point();
			
			this.activatedTexture = texture;
			this.inactivatedTexture = inactivedTexture;
			
			m_image = new Image(texture);
			addChild(m_image);
			
			m_text = new TextField(200, 30, "", "Verdana", 22, 0x808000, true);
			m_text.hAlign = HAlign.CENTER;
			m_text.y = -30;
			m_text.x = -100 + m_image.width/2;
			m_text.visible = false;
			addChild(m_text);
			
			this.text = text;
			
		}
		
		public function initialize():void
		{
			this.x = initPoint.x;
			this.y = initPoint.y;
			
			this.activated = false;
			
			this.scaleX = this.scaleY = 1.0;
		}
		
	}
}