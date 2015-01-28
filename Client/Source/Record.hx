package ;


import flash.events.Event;
import openfl.display.Bitmap;
import openfl.display.Loader;
import openfl.display.Sprite;
import openfl.events.MouseEvent;
import openfl.filters.DropShadowFilter;
import openfl.Lib;
import openfl.net.URLRequest;
import openfl.text.TextField;
import openfl.text.TextFieldAutoSize;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;

class Record extends Sprite
{
	
	public var urlImg : String;
	public var urlProfile : String;
	public var userName : String;
	public var scoreUser : Int;
	public var scoreAI : Int;
	
	private var loader : Loader;
	private var img : Bitmap;
	private var imgContainer : Sprite;
	

	public function new(?urlImg : String, ?urlProfile : String, ?userName : String, scoreUser : Int = 0, scoreAI : Int = 0)
	{		
		super();		
		
		if ( urlProfile != null) this.urlProfile = urlProfile;
		if ( userName != null) this.userName = userName;
		
		this.scoreUser = scoreUser;
		this.scoreAI = scoreAI;		
		
		if ( urlImg != null)
		{
			
			this.urlImg = urlImg;			
			this.loadImgProfile();
			
		}		
	}
	
	public function loadImgProfile() : Void
	{	
		
		var urlreq = new URLRequest(this.urlImg);
		loader = new Loader();
		loader.load(urlreq);
		loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadComplete);
		
	}
	
	private function loadComplete(e:Event) : Void
	{
		
		var shadow = new DropShadowFilter(1, 90, 0, 0.4, 2, 2);
		
		img = cast(loader.contentLoaderInfo.content, Bitmap);
		imgContainer = new Sprite();
		
		imgContainer.addChild(img);
		imgContainer.buttonMode = true;		
		imgContainer.addEventListener(MouseEvent.CLICK, imgClick);
		imgContainer.x = 0;
		imgContainer.y = 20;
		imgContainer.filters = [shadow];
		
		this.addChild(imgContainer);
				
		ini();
		
	}
	
	private function imgClick(e : MouseEvent) : Void 
	{
		
		Lib.getURL(new URLRequest(this.urlProfile));
		
	}
	
	private function ini () : Void 
	{
		
		var userTextFormat = new TextFormat("Tahoma", 12, 0x2B507A, true);
		var scoreFormat = new TextFormat("Arial", 13, 0x232323, true);		
		
		var userNameField = new TextField();
		userNameField.defaultTextFormat = userTextFormat;
		userNameField.selectable = false;
		userNameField.x = imgContainer.width / 2;		
		userNameField.y = 0;
		userNameField.width = 0;		
		userNameField.htmlText = "<a href=\"" + this.urlProfile + "\">" + this.userName + "</a>";
		userNameField.autoSize = TextFieldAutoSize.CENTER;
		
		var scoreField = new TextField();
		scoreField.defaultTextFormat = scoreFormat;
		scoreField.x = imgContainer.width / 2;
		scoreField.y = this.imgContainer.y + this.imgContainer.height;		
		scoreField.selectable = false;
		scoreField.width = 0;
		scoreField.text = "1 место (" + this.scoreUser + ":" + this.scoreAI + ")";
		scoreField.autoSize = TextFieldAutoSize.CENTER;
		
		addChild(userNameField);
		addChild(scoreField);
		
	}
	
}