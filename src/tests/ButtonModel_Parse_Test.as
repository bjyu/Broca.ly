package tests
{
	import org.flexunit.asserts.assertTrue;

	public class ButtonModel_Parse_Test
	{
		private var m_model:Object =
		[
			// category name
			{	
				"name":"cat1",
				"numButton":7,
				"buttons":
				[
					{ "id":"btn1", "desc":"desc", "subCat":"cat2"},
					{ "id":"btn2", "desc":"desc"},
					{ "id":"btn3", "desc":"desc"},
					{ "id":"btn4", "desc":"desc"},
					{ "id":"btn5", "desc":"desc"},
					{ "id":"btn6", "desc":"desc"},
					{ "id":"btn7", "desc":"desc"},
				]
			},
			{	
				"name":"cat2",
				"numButton":3,
				"buttons:":
				[
					{"id":"btn2_1", "desc":""},
					{"id":"btn2_2", "desc":""},
					{"id":"btn2_3", "desc":""}
				]
			}
		];
		
		public function ButtonModel_Parse_Test()
		{
		}
		
		[Test]
		public function jsonModel_parse_true():void
		{
			for each (var o:Object in m_model)
			{
				trace(o.name);
				for each (var b:Object in o.buttons)
				{
					trace(b.id);
				}
			}
			
			assertTrue(true);
		}
		
		[Test]
		public function jsonModel_accessAndParse_true():void
		{
			for each (var o:Object in m_model)
			{
				if (o.name != "cat1")
					continue;
				
				for each (var b:Object in o.buttons)
				{
					trace(b.id);
				};

			}
						
			assertTrue(true);
		}
	}
}