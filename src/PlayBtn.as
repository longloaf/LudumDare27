package  
{
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Maksim Soldatov
	 */
	public class PlayBtn extends Btn
	{
		
		[Embed(source = "play_btn_200x100_4.png")]
		private static const Img:Class;
		
		public function PlayBtn() 
		{
			loadGraphic(Img, true, false, 200, 100);
			width *= 0.8;
			height *= 0.8;
			centerOffsets();
			callback = function():void { FlxG.switchState(new PlayState()); };
		}
		
	}

}