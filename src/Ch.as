package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Maksim Soldatov
	 */
	public class Ch extends FlxSprite
	{
		[Embed(source = "chars1_100x100_7.png")]
		private static const Img:Class;
		
		public static const FORWARD:int = 0;
		public static const BACKWARD:int = 1;
		public static const BACKWARD_ERR:int = 2;
		
		private var forwardAct:Act = new Act();
		private var backwardAct:Act = new Act();
		private var backwardErrAct:Act = new Act();
		
		private var am:ActM = new ActM();
		
		public var onForwardArrived:Function = G.NIL_FUNC;
		public var onBackwardArrived:Function = G.NIL_FUNC;
		public var onBackwardErrArrived:Function = G.NIL_FUNC;
		
		public var val:int;
		
		public var p:PlayState;
		
		private var sc:Number;
		private var scErr:Number;
		
		public function Ch() 
		{
			loadGraphic(Img, true, true, 100, 100);
			
			forwardAct
			.setInit(forward_init)
			.setUpdate(forward_update);
			
			backwardAct
			.setInit(backward_init)
			.setUpdate(backward_update);
			
			backwardErrAct
			.setInit(backward_init)
			.setUpdate(backwardErr_update);
		}
		
		public function init(a:int):void
		{
			reset(0, 0);
			if (a == FORWARD) {
				am.init(forwardAct);
			} else if (a == BACKWARD) {
				am.init(backwardAct);
			} else if (a == BACKWARD_ERR) {
				am.init(backwardErrAct);
			} else {
				throw new Error();
			}
		}
		
		override public function update():void 
		{
			am.update();
		}
		
		private function forward_init():void
		{
			x = -width;
			facing = RIGHT;
			sc = 30 + FlxG.random() * 30;
		}
		
		private function forward_update():void
		{
			x += 10;
			if (x < 250 - width / 2) {
				y = 450 - height;
			} else if (x < 550 - width / 2) {
				var x2:Number = (x + width / 2) / 100.0;
				y = 450 - height + (x2 * x2 - 8 * x2 + 13.75) * sc;
			} else if (x < FlxG.width) {
				y = 450 - height;
			} else {
				onForwardArrived();
				kill();
			}
		}
		
		private function backward_init():void
		{
			x = FlxG.width;
			facing = LEFT;
			sc = 30 + FlxG.random() * 30;
			scErr = 70 + FlxG.random() * 30;
		}
		
		private function backward_update():void
		{
			x -= 10;
			
			if (x > 550 - width / 2) {
				y = 450 - height;
			} else if (x > 250 - width / 2) {
				var x2:Number = (x + width / 2) / 100.0;
				y = 450 - height + (x2 * x2 - 8 * x2 + 13.75) * sc;
			} else if (x > -width) {
				y = 450 - height;
			} else {
				onBackwardArrived();
				var m:Mark = p.chMarkGroup.members[val] as Mark;
				m.visible = true;
				m.frame = Mark.OK;
				kill();
			}
		}
		
		private function backwardErr_update():void
		{
			x -= 10;
			if (x > 700 - width / 2) {
				y = 450 - height;
			} else {
				var x2:Number = (x + width / 2) / 100.0;
				y = 450 - height + (x2 * x2 - 11.5 * x2 + 31.5) * scErr;
				if (y > FlxG.height) {
					onBackwardErrArrived();
					var m:Mark = p.chMarkGroup.members[val] as Mark;
					m.visible = true;
					m.frame = Mark.ERR;
					kill();
				}
			}
		}
		
	}

}