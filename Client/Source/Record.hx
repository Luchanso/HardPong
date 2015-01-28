package ;


import flash.events.Event;
import openfl.display.Bitmap;
import openfl.display.Loader;
import openfl.display.Sprite;
import openfl.net.URLRequest;

class Record extends Sprite
{
	
	public urlImg(default, default) : String;
	public urlProfile(default, default) : String;
	public scoreUser(default, default) : Int;
	public scoreAI(default, default) : Int;

	public function new(urlImg : String, urlProfile : String, scoreUser : String, scoreAI : String)
	{
		
		super();
		
		this.urlImg = urlImg;
		this.urlProfile = urlProfile;
		this.scoreUser = scoreUser;
		this.scoreAI = scoreAI;
		
		this.loadImgProfile();

	}
	
	public function loadImgProfile() : Void
	{
		
		var urlreq = new URLRequest(this.urlImg);
		var loader = new Loader();
		loader.load(urlreq);
		loader.addEventListener(Event.COMPLETE, loadComplete);
		
		addChild(loader);
		
	}
	
	private function loadComplete(e:Event):Void 
	{
		
		var img:Loader = e.currentTarget.loader;
		img.
		
		
	}
	
}