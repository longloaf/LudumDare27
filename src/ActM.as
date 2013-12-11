package  
{
	/**
	 * ...
	 * @author Maksim Soldatov
	 */
	public class ActM 
	{
		
		private var act:Act = null;
		private var initAct:Boolean = false;
		
		public function init(a:Act):void
		{
			act = a;
			act.init();
		}
		
		public function update():void
		{
			if (act == null) return;
			
			act.update();
			var next:Act = act.next();
			if (next != null) {
				act = next;
				act.init();
			}
		}
		
	}

}