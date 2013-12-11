package  
{
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	/**
	 * ...
	 * @author Maksim Soldatov
	 */
	public class MenuState extends FlxState
	{
		[Embed(source = "menu_bg.png")]
		private static const BG_IMG:Class;
		
		public function MenuState() 
		{
			add(new FlxSprite(0, 0, BG_IMG));
			
			var playBtn:PlayBtn = new PlayBtn();
			playBtn.x = (FlxG.width - playBtn.width) / 2;
			playBtn.y = 350;
			add(playBtn);
			
			var llBtn:LlBtn = new LlBtn();
			llBtn.x = (FlxG.width - llBtn.width) / 2;
			llBtn.y = 470;
			add(llBtn);
		}
		
	}

}