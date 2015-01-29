package;


import sys.db.Object;
import sys.db.Manager;

class Record extends Object
{
	public var id : Int;
	public var userId : String;
	public var ratio : Float;
	public var positiveScore : Float;
	public var negativeScore : Float;
	public var userProfile : String;
	public var userPhoto : String;
	public var userName : String;
	
	public static var TABLE_NAME = "Record";
	public static var manager = new RecordManager();
	
	public function toObject() : Dynamic
	{
		return { id : id, userId : userId, ratio : ratio, positiveScore : positiveScore, negativeScore :
			negativeScore, userProfile : userProfile, userPhoto : userPhoto, userName : userName };
	}

	public function new() 
	{
		super();
		
	}
	
}