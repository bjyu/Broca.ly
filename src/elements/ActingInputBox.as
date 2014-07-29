/**
 * 캐릭터 액션을 지정할 수 있는 박스이다.
 * Feathers examples의 TileList를 참고하였다.
 */
package elements
{
	import feathers.controls.Button;
	import feathers.controls.List;
	import feathers.controls.PageIndicator;
	import feathers.controls.ScreenNavigator;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.data.ListCollection;
	import feathers.layout.TiledRowsLayout;
	import feathers.themes.MetalWorksMobileTheme;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class ActingInputBox extends Sprite
	{
		
		private var m_faceTab:Sprite;
		private var m_actionTab:Sprite;
		
		private var m_pageIndicator:PageIndicator;
		private var m_navigator:ScreenNavigator;
		private var m_list:List;
		
		public function ActingInputBox()
		{
			super();
			
			// background
			var img:Image = new Image(Assets.getTexture("space"))
			img.width = 800;
			img.height = 440;
			img.color = 0x0;
			addChild(img);
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage():void
		{
//			new MetalWorksMobileTheme();
			
			initialize();
		}
		
		private function initialize():void
		{
			// create meta data
			var collection:ListCollection = new ListCollection();
			
			var arrTexture:Vector.<Texture> = Assets.getAtlas("KakaoAtlas").getTextures();
			var arrName:Vertor.<String> = Assets.getAtlas("KakaoAtlas").getNames();
			var cnt:uint = arrName.length;
			
			for(var i:uint = 0; i < cnt ; i++)
			{
				collection.addItem({texture: arrTexture[i], id:arrName[i] });
			}
			
			const listLayout:TiledRowsLayout = new TiledRowsLayout();
			listLayout.paging = TiledRowsLayout.PAGING_HORIZONTAL;
			listLayout.useSquareTiles = false;
			listLayout.tileHorizontalAlign = TiledRowsLayout.TILE_HORIZONTAL_ALIGN_CENTER;
			listLayout.horizontalAlign = TiledRowsLayout.HORIZONTAL_ALIGN_CENTER;
			listLayout.manageVisibility = true;
			listLayout.gap = 8;
			
			this.m_list = new List();
			this.m_list.dataProvider = collection;
			this.m_list.layout = listLayout;
			this.m_list.snapToPages = true;
			this.m_list.scrollBarDisplayMode = List.SCROLL_BAR_DISPLAY_MODE_NONE;
			this.m_list.horizontalScrollPolicy = List.SCROLL_POLICY_ON;
			this.m_list.itemRendererFactory = tileListItemRendererFactory;
			this.m_list.addEventListener(Event.SCROLL, onScroll);
			this.addChild(this.m_list);
			
			m_pageIndicator = new PageIndicator();
			
			this.m_pageIndicator.direction = PageIndicator.DIRECTION_HORIZONTAL;
			this.m_pageIndicator.pageCount = 1;
			this.m_pageIndicator.gap = 3;
			this.m_pageIndicator.paddingTop = this.m_pageIndicator.paddingRight = this.m_pageIndicator.paddingBottom =
				this.m_pageIndicator.paddingLeft = 6;
			
//			m_pageIndicator.horizontalAlign = PageIndicator.HORIZONTAL_ALIGN_CENTER;
//			m_pageIndicator.verticalAlign = PageIndicator.VERTICAL_ALIGN_BOTTOM;
			
			m_pageIndicator.addEventListener(Event.CHANGE, onChange);
			
			addChild(m_pageIndicator);
			
			this.layout();
		}
		
		protected function layout():void
		{
			this.m_pageIndicator.width = this.stage.stageWidth;
			this.m_pageIndicator.validate();
			this.m_pageIndicator.y = this.stage.stageHeight - this.m_pageIndicator.height;
			
			const shorterSide:Number = Math.min(this.stage.stageWidth, this.stage.stageHeight);
			const layout:TiledRowsLayout = TiledRowsLayout(this.m_list.layout);
			layout.paddingTop = layout.paddingRight = layout.paddingBottom =
				layout.paddingLeft = shorterSide * 0.06;
			layout.gap = shorterSide * 0.04;
			
			this.m_list.itemRendererProperties.gap = shorterSide * 0.01;
			
			this.m_list.width = this.stage.stageWidth;
			this.m_list.height = 400; //this.m_pageIndicator.y;
			this.m_list.validate();
			
			m_list.addEventListener(Event.TRIGGERED, onTriggered);
			
			this.m_pageIndicator.pageCount = this.m_list.horizontalPageCount;
		}
		
		protected function tileListItemRendererFactory():IListItemRenderer
		{
			const renderer:DefaultListItemRenderer = new DefaultListItemRenderer();
//			renderer.labelField = "label";
			renderer.iconSourceField = "texture";
			renderer.iconPosition = Button.ICON_POSITION_TOP;
//			renderer.defaultLabelProperties.textFormat = new BitmapFontTextFormat(_font, NaN, 0x000000);
			
			renderer.labelField = "name";
			renderer.defaultLabelProperties.visible = false;
			renderer.addEventListener(Event.TRIGGERED, onTriggered);
			return renderer;
		}
		
		private function onTriggered(event:Event):void
		{
			
			trace(m_list.selectedItem.id);
		}
		
		private function onScroll():void
		{
			this.m_pageIndicator.selectedIndex = this.m_list.horizontalPageIndex;
		}		
		
		private function onChange(event:Event):void
		{
			this.m_list.scrollToPageIndex(this.m_pageIndicator.selectedIndex, 0, this.m_list.pageThrowDuration);
		}
		
	}
}