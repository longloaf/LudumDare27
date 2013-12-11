package  
{
	import org.flixel.FlxGame;
	
	[SWF(width = "800", height = "600", backgroundColor = "#000000")]
	
	/**
	 * ...
	 * @author Maksim Soldatov
	 */
	public class Main extends FlxGame
	{
		
		public function Main() 
		{
			super(800, 600, MenuState, 1, G.FPS, G.FPS, true);
			//super(800, 600, Test2, 1, G.FPS, G.FPS, true);
			//super(800, 600, Test3, 1, G.FPS, G.FPS, true);
			forceDebugger = true;
		}
		
	}

}