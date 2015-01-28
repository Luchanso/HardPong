package ;


import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;
import openfl.events.KeyboardEvent;
import openfl.geom.Point;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;


enum GameState {
	
	Paused;
	Playing;
	
}

enum Player {
	
	Human;
	AI;
	
}

class Main extends Sprite 
{
	
	var inited:Bool;
	
	private var platform1:Platform;
	private var platform2:Platform;
	private var ball:Ball;
	private var scorePlayer:Int;
	private var scoreAI:Int;
	private var scoreField:TextField;
	private var messageField:TextField;
	private var currentGameState:GameState;
	private var arrowKeyUp:Bool;
	private var arrowKeyDown:Bool;
	private var platformSpeed:Int;
	private var ballMovement:Point;
	private var ballSpeed:Int;

	/* ENTRY POINT */
	
	function resize(e) 
	{
		
		if (!inited) init();
		
	}
	
	function init() 
	{
		
		if (inited) return;
		inited = true;
		
		platform1 = new Platform();
		platform1.x = 5;
		platform1.y = 200;
		this.addChild(platform1);
		
		platform2 = new Platform();
		platform2.x = 480;
		platform2.y = 200;
		this.addChild(platform2);
		
		ball = new Ball();
		ball.x = 250;
		ball.y = 250;
		this.addChild(ball);
		
		var scoreFormat:TextFormat = new TextFormat("Arial", 24, 0xbbbbbb, true);
		scoreFormat.align = TextFormatAlign.CENTER;
		
		scoreField = new TextField();
		addChild(scoreField);
		scoreField.width = 500;
		scoreField.y = 30;
		scoreField.defaultTextFormat = scoreFormat;
		scoreField.selectable = false;
		
		var messageFormat:TextFormat = new TextFormat("Arial", 18, 0xbbbbbb, true);
		messageFormat.align = TextFormatAlign.CENTER;
		
		messageField = new TextField();
		addChild(messageField);
		messageField.width = 500;
		messageField.y = 450;
		messageField.defaultTextFormat = messageFormat;
		messageField.selectable = false;
		messageField.text = "Нажмите пробел, чтобы начать\nИспользутей стрелки для движения платформы";
		
		scorePlayer = 0;
		scoreAI = 0;
		arrowKeyUp = false;
		arrowKeyDown = false;
		platformSpeed = 7;
		ballSpeed = 14;
		ballMovement = new Point(0, 0);
		setGameState(Paused);
		
		stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
		stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
		this.addEventListener(Event.ENTER_FRAME, everyFrame);
		
	}
	
	private function setGameState(state:GameState):Void 
	{
		
		currentGameState = state;
		updateScore();
		if (state == Paused) 
		{
			messageField.alpha = 1;
		}
		else 
		{
			messageField.alpha = 0;
			platform1.y = 200;
			platform2.y = 200;
			ball.x = 250;
			ball.y = 250;
			var direction:Int = (Math.random() > .5)?(1):( -1);
			var randomAngle:Float = (Math.random() * Math.PI / 2) - 45;
			ballMovement.x = direction * Math.cos(randomAngle) * ballSpeed;
			ballMovement.y = Math.sin(randomAngle) * ballSpeed;
		}
		
	}
	
	private function keyDown(event:KeyboardEvent):Void 
	{
		
		if (currentGameState == Paused && event.keyCode == 32) 
		{
			setGameState(Playing);
		} 
		else if (event.keyCode == 38) 
		{
			arrowKeyUp = true;
		} 
		else if (event.keyCode == 40) 
		{
			arrowKeyDown = true;
		}
		
	}
	
	private function keyUp(event:KeyboardEvent):Void 
	{
		
		if (event.keyCode == 38)
		{
			arrowKeyUp = false;
		}
		else if (event.keyCode == 40) 
		{
			arrowKeyDown = false;
		}	
		
	}
	
	private function everyFrame(event:Event):Void 
	{
		
		if (currentGameState == Playing) 
		{
			
			if (arrowKeyUp) 
			{
				platform1.y -= platformSpeed;
			}
			if (arrowKeyDown) 
			{
				platform1.y += platformSpeed;
			}
			
			if (ball.x > 100 && ball.y > platform2.y + 70) 
			{
				platform2.y += platformSpeed;
			}
			if (ball.x > 100 && ball.y < platform2.y + 30) 
			{
				platform2.y -= platformSpeed;
			}
			
			if (platform1.y < 5) platform1.y = 5;
			if (platform1.y > 395) platform1.y = 395;
			
			if (platform2.y < 5) platform2.y = 5;
			if (platform2.y > 395) platform2.y = 395;
			
			ball.x += ballMovement.x;
			ball.y += ballMovement.y;
			
			if (ballMovement.x < 0 && ball.x < 30 && ball.y >= platform1.y && ball.y <= platform1.y + 100) 
			{
				bounceBall();
				ball.x = 30;
			}
			if (ballMovement.x > 0 && ball.x > 470 && ball.y >= platform2.y && ball.y <= platform2.y + 100) 
			{
				bounceBall();
				ball.x = 470;
			}
			
			if (ball.y < 5 || ball.y > 495) ballMovement.y *= -1;			
			if (ball.x < 5) winGame(AI);
			if (ball.x > 495) winGame(Human);
		}
		
	}
	
	private function bounceBall():Void 
	{
		
		var direction:Int = (ballMovement.x > 0) ? ( -1) : (1);
		var randomAngle:Float = (Math.random() * Math.PI / 2) - 45;
		ballMovement.x = direction * Math.cos(randomAngle) * ballSpeed;
		ballMovement.y = Math.sin(randomAngle) * ballSpeed;
		
	}
	
	private function winGame(player:Player):Void 
	{
		
		if (player == Human) 
		{
			scorePlayer++;
		}
		else
		{
			scoreAI++;
		}
		setGameState(Paused);
		
	}
	
	private function updateScore():Void 
	{
		
		scoreField.text = scorePlayer + ":" + scoreAI;
		
	}

	public function new() 
	{
		
		super();	
		addEventListener(Event.ADDED_TO_STAGE, added);
		
	}

	function added(e) 
	{
		
		removeEventListener(Event.ADDED_TO_STAGE, added);
		stage.addEventListener(Event.RESIZE, resize);
		init();
		
	}
	
	public static function main() 
	{		

		Lib.current.stage.align = flash.display.StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
		Lib.current.addChild(new Main());

	}
	
}