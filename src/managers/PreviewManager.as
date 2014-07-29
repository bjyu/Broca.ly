/**
 * 대사 이외의 표현에 대한 미리보기를 제공한다.
 */
package managers
{
	import elements.Preview;
	
	import starling.display.Sprite;

	public class PreviewManager
	{
		private var m_previewLayer:Sprite;
		private var _preview:Preview;

		public function get preview():Preview
		{
			return _preview;
		}

//		public function set preview(value:Preview):void
//		{
//			_preview = value;
//		}

		
		public function PreviewManager(layer:Sprite)
		{
			m_previewLayer = layer;
			
			_preview = new Preview();
			m_previewLayer.addChild(_preview);
		}
		
	}
}