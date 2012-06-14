package
{
	import net.flashpunk.Entity;
	/**
	 * ...
	 * @author Christian Kokott
	 */
		 	
	public class GameBoard extends Entity
	{		
		public var field:Array = new Array(7);
		
		public function GameBoard() 
		{			
			
		}
		
		override public function update():void 
		{
		
		}
		
		override public function added():void 
		{
			for (var i:int = 0; i < field.length; i++)
			{
				field[i] = new Array(7);
				this.world.add(new Column(i));
				for (var j:int = 0; j < field.length; j++)
				{
					field[i][j] = null;
				}
			}	
		}
	}
}