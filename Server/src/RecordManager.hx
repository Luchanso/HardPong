package;

import sys.db.Manager;
import sys.db.Mysql;


class RecordManager extends Manager<Record>
{

	public function new()
	{
		
		super(Record);
		
	}
	
	public function scoreAbove( ratio : Float )
	{		
		
		return this.search( $ratio <= ratio );
    }

	
}