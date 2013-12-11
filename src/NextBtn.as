package  
{
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Maksim Soldatov
	 */
	public class NextBtn extends Btn
	{
		[Embed(source="next_btn_200x100_4.png")]
		private static const Img:Class;
		
		public function NextBtn() 
		{
			loadGraphic(Img, true, false, 200, 100);
			width *= 0.8;
			height *= 0.8;
			centerOffsets();
		}
		
	}

}