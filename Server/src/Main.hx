package;

import haxe.Json;
import php.Lib;
import php.Web;

enum Action
{
	
	GetRecords;
	SetRecords;
	Unknow;
	
}

class Main 
{

	static function main() 
	{
		var a = Main.parse();
		
		switch (a) 
		{
			case Action.GetRecords:
				
				
			case Action.SetRecords:
				
				
			default:
				
				sendData( { error: 1, msg: "Unknow query" } );
				
		}
		
	}
	
	
	static function parse() : Action
	{
		var result : Action = Action.Unknow;
		
		var params = Web.getParams();		
		
		if (params.exists("query"))	
			switch (params.get("query"))
			{
				
				case "getRecords": 
					result = Action.GetRecords;
					
				case "setRecords":
					result = Action.SetRecords;

			}
		
		return result;
		
	}
	
	static private function sendData(data : Dynamic) : Void 
	{
		
		Lib.print(Json.stringify(data));
		
	}
	
}