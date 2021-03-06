package elements
{
	import starling.display.Button;
	
	public class ActionButton extends Button
	{
		
		private var _subCatId:String;

		public function get subCatId():String
		{
			return _subCatId;
		}

		public function set subCatId(value:String):void
		{
			_subCatId = value;
		}
		
		
		public function ActionButton(buttonId:String)
		{
			super(Assets.getAtlas("ActionButtonAtlas").getTexture(buttonId));
			this.name = buttonId;
		}

	}
}