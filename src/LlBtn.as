package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxU;
	/**
	 * ...
	 * @author Maksim Soldatov
	 */
	public class LlBtn extends Btn
	{
		[Embed(source = "ll_btn_390x100_4.png")]
		private static const Img:Class;
		
		public function LlBtn() 
		{
			loadGraphic(Img, true, false, 390, 100);
			width *= 0.9;
			height *= 0.8;
			centerOffsets();
			callback = function():void { FlxU.openURL("http://longloaf.com"); };
		}
		
	}

}