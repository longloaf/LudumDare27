package  
{
	/**
	 * ...
	 * @author Maksim Soldatov
	 */
	public class Act 
	{
		
		public var init:Function = G.NIL_FUNC;
		public var update:Function = G.NIL_FUNC;
		public var next:Function = G.NIL_FUNC;
		
		public function setInit(f:Function):Act
		{
			init = f;
			return this;
		}
		
		public function setUpdate(f:Function):Act
		{
			update = f;
			return this;
		}
		
		public function setNext(f:Function):Act
		{
			next = f;
			return this;
		}
		
	}

}