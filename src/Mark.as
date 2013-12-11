package  
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Maksim Soldatov
	 */
	public class Mark extends FlxSprite
	{
		[Embed(source = "mark_50x50_2.png")]
		private static const Img:Class;
		
		public static const ERR:int = 0;
		public static const OK:int = 1;
		
		public function Mark() 
		{
			loadGraphic(Img, true, false, 50, 50);
		}
		
	}

}