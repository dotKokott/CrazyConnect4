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
		
		public function checkForWin():int
		{
			for (var x:int = 0; x < field.length; x++)
			{
				for (var y:int = 0; y < field.length; y++)
				{
					var coin:Coin = getCoinByCoords(x, y);					
					if (coin != null)
					{
						var player:int = coin.player;						
						
						//horizontal
						var passed:Boolean = true;
						for (var i:int = 1; i < 4; i++)
						{
							var nextCoin:Coin = getCoinByCoords(x + i, y);
							if (nextCoin == null || nextCoin.player != player)
							{
								passed = false;
								break;
							}
						
						}
						
						if (passed)
						{
							trace("HORIZONTAL");
							return player;
						}
						
						//vertical						
						passed = true
						for (var i:int = 1; i < 4; i++)
						{
							var nextCoin:Coin = getCoinByCoords(x,y + i);
							if (nextCoin == null || nextCoin.player != player)
							{
								passed = false;
								break;
							}
						}
						
						if (passed)
						{
							trace("VERTICAL");
							return player;
						}
						
					}												
				}
				
			}
			
			return -1;
			
		}
		
		//0 = player1; 1 = player2; -1 = null
		public function getCoinByCoords(x:int, y:int):Coin
		{
			if (coordsInBounds(x,y) && field[x][y] != null)
			{
				return (field[x][y] as Coin);
			}
			else
			{
				return null;				
			}
		}
		
		private function coordsInBounds(x:int, y:int):Boolean
		{
			return x >= 0 && x < field.length && y >= 0 && y < field.length;
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