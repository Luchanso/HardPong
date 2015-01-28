package ;


import com.demonsters.debugger.MonsterDebugger;
import openfl.events.Event;
import openfl.net.URLLoader;
import openfl.net.URLRequest;
import openfl.display.Sprite;

class TableRecords extends Sprite
{

	private var records : Array<Record>;
	private var loader : URLLoader;
	
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
		#if Debug
		var url = new URLRequest("http://localhost/hardpong/index.php?query=getRecords");
		#else
		var url = new URLRequest("http://good4dev.ru/hardpong/index.php?query=getRecords");
		#end
		
		loader = new URLLoader(url);
		loader.addEventListener(Event.COMPLETE, dataLoad);
	
	}
	
	private function dataLoad (e:Event) : Void 
	{
		
		MonsterDebugger.log(loader.data);
		
	}
	
}