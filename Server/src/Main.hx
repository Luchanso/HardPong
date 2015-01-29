package;

import haxe.Json;
import php.Lib;
import php.Web;
import sys.db.Connection;
import sys.db.Manager;
import sys.db.Mysql;

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
				var result = getRecords();
				sendData( result );
				
			case Action.SetRecords:
				var result = setRecords();
				sendData( result );
				
			default:
				
				sendData( { error: 1, msg: "Unknow query" } );
				
		}
		
	}
	
	static private function connectToBD() : Void 
	{
		
		var cnx = Mysql.connect( { host : "localhost", user : "root", pass : "", database : "pong" } );
		
		Manager.cnx = cnx;
		Manager.initialize();

	}
	
	static private function dissconnectFromBD() : Void
	{
		
		Manager.cleanup();
		Manager.cnx.close();
		
	}
	
	static private function getRecords() : Dynamic
	{
		
		
		
		return null;
	
	}
	
	static private function setRecords() : Dynamic
	{
	
		var params = Web.getParams();
		var result = { };
		
		if (!(params.exists("positiveScore") &&
			params.exists("negativeScore") &&
			params.exists("userProfileUrl") &&
			params.exists("userPhotoUrl") &&
			params.exists("userName") &&
			params.exists("userId")))
			{
				result = { error: 1, msg: "Bad arguments" };
				return result;
			}
			
		var pScore = Std.parseInt(params.get("positiveScore"));
		var nScore = Std.parseInt(params.get("negativeScore"));
		var userUrl = Std.string(params.get("userProfileUrl"));
		var userPhoto = Std.string(params.get("userPhotoUrl"));
		var userName = Std.string(params.get("userName"));
		var userId = Std.string(params.get("userId"));
		if (pScore == null ||
			nScore == null ||
			userPhoto == null ||
			userName == null ||			
			userId == null)
			{
				result = { error: 1, msg: "Bad arguments" };
				return result;
			}
			
		connectToBD();
		
		var records : List<Record> = Record.manager.scoreAbove(pScore / nScore);
		var listResult = new Array();
		
		
		for (record in records)
		{			
			listResult.push(record.toObject());
		}
		
		result = listResult;	
			
		return result;
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