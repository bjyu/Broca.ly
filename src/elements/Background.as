package elements
{
	import starling.display.Sprite;
	
	public class Background extends Sprite
	{
		public function Background()
		{
			super();
			
			initialize();
		}
		
		public function initialize():void
		{
			var url:String = "http://cfile223.uf.daum.net/original/1806C449500D55562C6282";
			
			var img:WebImage = new WebImage(url);
			img.loadImage();
			img.alpha = 0.2;
			
			addChild(img);
		}
		
	}
}