package  
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Maksim Soldatov
	 */
	public class NumBig extends FlxSprite
	{
		[Embed(source = "num_200x201_11.png")]
		private static const Img:Class;
		
		public function NumBig() 
		{
			loadGraphic(Img, true, false, 200, 201);
		}
		
	}

}