package 
{	
	/**
	 * ...
	 * @author Christian Kokott
	 */
	import net.flashpunk.Engine;
	import net.flashpunk.FP;

	public class Main extends Engine 
	{	
		public function Main()
		{			
			super(800, 608, 60, false);
			FP.world = new GameWorld;
		}			
	}	
}