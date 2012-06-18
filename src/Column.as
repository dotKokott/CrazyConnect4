package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author ...
	 */
	public class Column extends Entity
	{
		public var Id:int;
		
		public var coins:Vector.<Coin> = new Vector.<Coin>();
		
		public function Column(columnId:int)		
		{
			Id = columnId;
			x = columnId * 50;
			y = 0;
			for (var i:int = 0; i < 7; i++)
			{
				var circle:Image = Image.createCircle(25, 0x00FF00)
				circle.y = i * 50;				
				addGraphic(circle);		
			}
		}
		
	}

}