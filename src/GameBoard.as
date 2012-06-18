package
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	
	/**
	 * ...
	 * @author Christian Kokott
	 */
		 	
	public class GameBoard extends Entity
	{		
		public var field:Array = new Array(7);		
		public var currentPlayer:int = 0;			
		
		private var wait:Boolean = false;
		
		public function GameBoard() 
		{			
		
		}
		
		override public function update():void 
		{
			if (Input.mouseReleased && !coinsDropping())
			{
				var columnId:int = Math.floor(Input.mouseX / 50);
				
				var coin:Coin = new Coin(this, currentPlayer);
				
				if (coin.drop(columnId))
				{
					this.world.add(coin);
					wait = true;
					
					if (currentPlayer == 0)
					{
						currentPlayer = 1;
					}
					else
					{
						currentPlayer = 0;
					}					
				}
			}
		}
		
		public function coinsDropping():Boolean
		{			
			var coins:Array = [];		
			world.getClass(Coin, coins);

			for each (var c:Coin in coins)
			{
				if (c.dropping)
					return true;
			}				
			
			return false;
		}
		
		override public function added():void 
		{
			for (var x:int = 0; x < field.length; x++)
			{
				field[x] = new Array(7);
				
				//this.world.add(new Column(i));
				
				for (var y:int = 0; y < field.length; y++)
				{
					field[x][y] = null;
					var circle:Image = Image.createCircle(25, 0x00FF00)
					circle.x = x * 50;
					circle.y = y * 50;
					
					addGraphic(circle);	
				}
			}	
		}
	}
}