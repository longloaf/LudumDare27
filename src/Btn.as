package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Maksim Soldatov
	 */
	public class Btn extends FlxSprite
	{
		public static const NORMAL:int = 0;
		public static const OVER:int = 1;
		public static const PRESSED:int = 2;
		public static const DISABLED:int = 3;
		
		private var enabled:Boolean = true;
		private var mousePressed:Boolean = false;
		
		public var callback:Function = G.NIL_FUNC;
		
		public function setEnabled(e:Boolean):void
		{
			if (e == enabled) return;
			
			enabled = e;
			if (enabled) {
				frame = NORMAL;
			} else {
				frame = DISABLED;
			}
		}
		
		public function getEnabled():Boolean
		{
			return enabled;
		}
		
		override public function update():void 
		{
			super.update();
			if (!enabled) return;
			if ((FlxG.mouse.x >= x) && (FlxG.mouse.x < x + width) &&
			(FlxG.mouse.y >= y) && (FlxG.mouse.y < y + height)) {
				if (FlxG.mouse.justPressed()) {
					mousePressed = true;
				} else if (mousePressed && !FlxG.mouse.pressed()) {
					mousePressed = false;
					callback();
				}
				if (enabled) {
					if (mousePressed) {
						frame = PRESSED;
					} else {
						frame = OVER;
					}
				}
			} else {
				mousePressed = false;
				frame = NORMAL;
			}
		}
		
		override public function reset(X:Number, Y:Number):void 
		{
			super.reset(X, Y);
			enabled = true;
			mousePressed = false;
			frame = NORMAL;
		}
		
	}

}