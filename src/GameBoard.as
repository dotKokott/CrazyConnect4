package
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	/**
	 * ...
	 * @author Christian Kokott
	 */
		 	
	public class GameBoard extends Entity
	{		
		public var field:Array = new Array(7);		
		public var currentPlayer:int = 0;			
		
		private var wait:Boolean = false;
		
		private var rotateTimer:int = 20;
		private var rotateTimout:int = 20;
		private var canRotate:Boolean = false;
		
		private var rotated:Boolean = false;		
		private var currentRearrangedRow = 0;
				
		public function GameBoard() 
		{			
		
		}
		
		override public function update():void 
		{											
			if (rotated && !coinsDropping())
			{
				currentRearrangedRow -= 1;
				if (currentRearrangedRow >= 0)
				{
					rearrange(currentRearrangedRow);
				}
				else
				{
					rotated = false;
					checkForWin();
				}
				
			}
			
			if (rotateTimer >= rotateTimout)
			{
				canRotate = true;
			}
			else
			{
				rotateTimer++;
			}
			
			if (canRotate && (Input.check(Key.LEFT) || Input.check(Key.RIGHT)) && !coinsDropping())
			{
				rotateBoard(Input.check(Key.RIGHT));							
				
				canRotate = false;
				rotateTimer = 0;
				
				rotated = true;
				currentRearrangedRow = 7;

				if (currentPlayer == 0)
				{
					currentPlayer = 1;
				}
				else
				{
					currentPlayer = 0;
				}					
			}
			
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
						passed = true;
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
							return player;
						}
						
						
						//diagonal left
						passed = true;						
						for (var i:int = 1; i < 4; i++)
						{
							var nextCoin:Coin = getCoinByCoords(x - i,y + i);
							if (nextCoin == null || nextCoin.player != player)
							{
								passed = false;
								break;
							}
						}
						
						if (passed)
						{
							trace("DIAGONAL LEFT");
							return player;
						}						
						
						//diagonal right
						passed = true;
						for (var i:int = 1; i < 4; i++)
						{
							var nextCoin:Coin = getCoinByCoords(x + i,y + i);
							if (nextCoin == null || nextCoin.player != player)
							{
								passed = false;
								break;
							}
						}
						
						if (passed)
						{
							trace("DIAGONAL RIGHT");
							return player;
						}												
					}												
				}
				
			}
			
			return -1;			
		}
		
		public function rotateBoard(right:Boolean):void
		{
			var newField:Array = new Array(7);
			for (var x:int = 0; x < field.length; x++)
			{
				newField[x] = new Array(7);			
			}
			
			for (var i:int = 6; i >= 0; --i)
			{
				for (var j:int = 0; j < 7; ++j)
				{
					if (right)
					{
						newField[6 - j][i] = field[i][j];
						if (field[i][j] != null)
						{
							var coin:Coin = field[i][j] as Coin;
							coin.x = (6 - j) * 50;
							coin.y = i * 50;						
						}						
					}
					else
					{
						newField[j][6 - i] = field[i][j];
						if (field[i][j] != null)
						{
							var coin:Coin = field[i][j] as Coin;
							coin.x = j * 50;
							coin.y = (6 - i) * 50;						
						}						

					}

				}
			}
							
			field = newField;
		}
		
		//null = not in bounds or no player
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
		
		public function rearrange(row:int):void
		{
			for (var x:int = 6; x >= 0; --x)
			{
				var coin:Coin = getCoinByCoords(x, row);
				if (coin != null)
				{
					coin.rearrange();					
				}
			}
		}
		
		public function restartGame():void
		{
			for (var x:int = 0; x < field.length; x++)
			{
				field[x] = new Array(7);
								
				for (var y:int = 0; y < field.length; y++)
				{
					field[x][y] = null;
					var circle:Image = Image.createCircle(25, 0x00FF00)
					circle.x = x * 50;
					circle.y = y * 50;
					
					addGraphic(circle);	
				}
			}
			
			var coins:Array = [];		
			world.getClass(Coin, coins);

			for each (var c:Coin in coins)
			{
				world.remove(c);
			}	
						
			currentPlayer = 0;
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