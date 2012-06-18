package  
{
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author Christian Kokott
	 */
	public class GameWorld extends World
	{		
		public var message:Message;
		public function GameWorld() 
		{
			
		}
		
		override public function begin():void
		{
			message = new Message("Play!", 320, 0);
			add(message)
			add(new GameBoard());
		}
		
		override public function update():void 
		{
			super.update();			
		}		
	}

}