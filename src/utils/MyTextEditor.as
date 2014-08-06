package utils
{
	import flash.events.FocusEvent;
	
	import feathers.controls.text.StageTextTextEditor;
	import feathers.events.FeathersEventType;
	
	public class MyTextEditor extends StageTextTextEditor
	{
		
		/**
		 * @private
		 */
		protected override function stageText_focusInHandler(event:FocusEvent):void
		{
			this._stageTextHasFocus = true;
			
			if(this.textSnapshot)
			{
				this.textSnapshot.visible = false;
			}
			this.invalidate(INVALIDATION_FLAG_DATA);
			this.invalidate(INVALIDATION_FLAG_SKIN);
			
			this.dispatchEventWith(FeathersEventType.FOCUS_IN);
		}
		
		/**
		 * @private
		 */
		protected override function stageText_focusOutHandler(event:FocusEvent):void
		{
			this._stageTextHasFocus = false;
			//since StageText doesn't expose its scroll position, we need to
			//set the selection back to the beginning to scroll there. it's a
			//hack, but so is everything about StageText.
			//in other news, why won't 0,0 work here?
//			this.stageText.selectRange(this.text.length, this.text.length);
//			this.stageText.selectRange(1,1);
			
			this.invalidate(INVALIDATION_FLAG_DATA);
			this.invalidate(INVALIDATION_FLAG_SKIN);
			this.dispatchEventWith(FeathersEventType.FOCUS_OUT);
		}
	}
}