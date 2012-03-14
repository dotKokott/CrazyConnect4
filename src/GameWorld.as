package  
{
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author Christian Kokott
	 */
	public class GameWorld extends World
	{
		
		public function GameWorld() 
		{
			
		}
		
		override public function begin():void
		{
			add(new Game);
		}
		
		override public function update():void 
		{
			super.update();			
		}		
	}

}