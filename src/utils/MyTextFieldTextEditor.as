package utils
{
	import feathers.controls.text.TextFieldTextEditor;

	
	public class MyTextFieldTextEditor extends TextFieldTextEditor
	{
		public function MyTextFieldTextEditor()
		{
			super();
			
		}
		
		public function requestSoftKeyboard():Boolean
		{
			return this.textField.requestSoftKeyboard();
		}
		
	}
}