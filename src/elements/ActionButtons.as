/**
 * 버튼 이미지를 로드한다.
 * 인덱스를 이용해서 필요한 버튼을 가져올 수 있다.
*/
package elements
{
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	public class ActionButtons
	{
		public static var Buttons:Dictionary = new Dictionary();
		
		
		public static function Button(name:String):starling.display.Sprite
		{
			if (Buttons[name] == undefined) {
				var s:flash.display.Sprite = new flash.display.Sprite(); 
				var g:Graphics = s.graphics;
				var r:int = 50;
				g.beginFill(Math.random() * 0xffffff);
				g.drawCircle(r,r,r);
				g.endFill();
				
				var bitmapData:BitmapData = new BitmapData(r*2,r*2,true,0xffffff);
				bitmapData.draw(s);
				
				var texture:Texture = Texture.fromBitmapData(bitmapData,true,true);
				var image:Image = new Image(texture);
				
				var sprite:starling.display.Sprite = new starling.display.Sprite();
				sprite.addChild(image);
				
				Buttons[name] = sprite;
			}
			
			return Buttons[name];
		}
	}
}