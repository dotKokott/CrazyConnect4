package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;
	/**
	 * ...
	 * @author ...
	 */
	public class Message extends Entity
	{
		public var text:String = "";
		public function Message(text:String,posX:int, posY:int) 
		{
			this.text = text
			graphic = new Text(text, posX, posY);
			x = posX;
			y = posY;
		}
		
		override public function update():void 
		{
			(graphic as Text).text = text;			
		}
		
	}

}