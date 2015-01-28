package ;


import com.demonsters.debugger.MonsterDebugger;
import openfl.net.URLRequest;
import openfl.display.Sprite;

class TableRecords extends Sprite
{

	var records:Array<Record>;
	
	public function new() 
	{
		
		super();
		
		this.graphics.beginFill(0xffffff);
		this.graphics.drawRect(0, 0, 550, 450);
		this.graphics.endFill();
		
		
		records = new Array<Record>();
		
		/*var record  = new Record("http://cs323930.vk.me/v323930021/53f8/qX8MRNyUPqg.jpg", "https://vk.com/loutchansky", "Лучанский Олег", 3, 0);
		record.x = 50;
		record.y = 5;
		addChild(record);
		records.push(record); */
	}
	
	private function Load() : Void 
	{
	
		
	
	}
	
}