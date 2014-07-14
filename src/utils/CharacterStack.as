package utils
{
	import elements.Character;

	public class CharacterStack
	{
		private var m_characterStack:Vector.<Character>;
		private var m_priority:Array;
		
		public function CharacterStack()
		{
			m_characterStack = new Vector.<Character>();
			m_priority = new Array(0,3,1,2); // 0 , 1 , 2 , 3 의 포지션에서 좌,우,좌,우로 순차적 등장.
		}
		
		/**
		 * 최상위로 올린다. 중복되는 경우, 스택에서 제거하고 최상위로 올린다.
		 */
		public function push(character:Character):void
		{
			// 새로 들어온 경우.
			var idx:int = m_characterStack.indexOf(character);
			if (idx < 0)
				character.position = m_priority[m_characterStack.length];
				
			
			pop(character);
			m_characterStack.push(character);
			reorder();
		}
		
		private function pop(character:Character):void
		{	
			var idx:int = m_characterStack.indexOf(character);
			if (idx >= 0)
			{
				m_characterStack.splice(idx, 1);
			}
		}
		
		public function contains(character:Character):Boolean
		{
			return !(m_characterStack.indexOf(character, 0) < 0);
		}
		
		/**
		 * 우선순위를 재조정한다.
		 */
		private function reorder():void
		{
			var i:int = 0;
			var cnt:int = m_characterStack.length;
			if (cnt > 4)
				throw new Error("stack overflowed.");
			
			for (i ; i < cnt ; i++)
			{
				m_characterStack[i].position = m_priority[i];
			}
		}
	}
}