package  
{
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Maksim Soldatov
	 */
	public class A 
	{
		private var len:int;
		
		private var key:Array = new Array();
		private var val:Array = new Array();
		
		public function A(l:int)
		{
			shuffle(l);
		}
		
		public function shuffle(l:int):void
		{
			if (l < 1) throw new Error();
			len = l;
			var i:int;
			for (i = 0; i < len; ++i) {
				key[i] = i;
			}
			var last:int = l - 1;
			for (i = 0; i < last; ++i) {
				var j:int = int(FlxG.random() * (len - i)) + i;
				var tmp:int = key[i];
				key[i] = key[j];
				key[j] = tmp;
			}
			for (i = 0; i < len; ++i) {
				val[key[i]] = i;
			}
		}
		
		public function getLen():int
		{
			return len;
		}
		
		private function checkID(id:int):void
		{
			if ((id < 0) || (id >= len)) throw new Error();
		}
		
		public function getVal(k:int):int
		{
			checkID(k);
			return val[k];
		}
		
		public function getKey(v:int):int
		{
			checkID(v);
			return key[v];
		}
		
	}

}