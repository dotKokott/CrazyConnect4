package  
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author ...
	 */
	public class Coin extends Entity
	{
		
		public var gameBoard:GameBoard;
		public var dropping:Boolean = false;
		public var dropDestination:Point;
		
		public var player:int;
		
		public function Coin(board:GameBoard, player:int) 
		{
			gameBoard = board;
			this.player = player;
			
			var color:uint = 0xFF0000;
			if (player == 1)
			{
				color = 0x0000FF;
				
			}
			var circle:Image = Image.createCircle(25, color)			
			graphic = circle;				
		}		
		
		//Returns true if the drop was successful
		public function drop(columnId:int):Boolean
		{
			if (gameBoard.field[columnId][0] != null)
			{
				return false;
			}
			
			for (var i:int = 0; i < gameBoard.field.length; i++)
			{
				if (gameBoard.field[columnId][i] == null)
				{
					dropDestination = new Point(columnId * 50,i * 50);					
				}
			}
			
			x = dropDestination.x;
			
			dropping = true;
			return dropping;
		}		
		
		override public function update():void 
		{
			if (dropping)
			{
				if (y < dropDestination.y)
				{
					y += 10;
				}
				else
				{
					gameBoard.field[Math.floor(x / 50)][Math.floor(y / 50)] = this;
					dropping = false;					
					
					var winPlayer:int = gameBoard.checkForWin();
					
					if (winPlayer != -1)
					{
						trace("PLAYER WON: " + winPlayer.toString());
					}
				}
			}
		}		
	}

}