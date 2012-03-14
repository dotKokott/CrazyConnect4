package
{
	import net.flashpunk.Entity;
	/**
	 * ...
	 * @author Christian Kokott
	 */
	public class Game extends Entity
	{
		public var field:Array = new Array(7);
		
		public function Game() 
		{
			for (var i:int = 0; i < field.length; i++)
			{
				field[i] = new Array(7);
				for (var j:int = 0; j < field.length; j++)
				{
					field[i][j] = null;
				}
			}
		}
		
		override public function update():void 
		{
		
		}
		
		override public function render():void 
		{
			
		}
	}
}