package  
{
	import org.flixel.FlxText;
	/**
	 * ...
	 * @author Maksim Soldatov
	 */
	public class ChBtn extends Btn
	{
		public var val:int;
		private var key:int = -1;
		public var t:FlxText;
		public var m:Mark;
		
		public var p:PlayState;
		
		public function ChBtn()
		{
			callback = chBtnCallback;
		}
		
		private function chBtnCallback():void
		{
			setKey(p.chID);
			++p.chID;
			setEnabled(false);
		}
		
		public function setKey(id:int):void
		{
			key = id;
			p.seq[key] = val;
			t.text = (key + 1).toString();
		}
		
		public function getKey():int
		{
			return key;
		}
		
	}

}