import flash.media.Sound;
import flash.media.SoundChannel;
import starling.display.Sprite;
import starling.utils.AssetManager;
import starling.display.Button;
import starling.animation.Transitions;
import starling.events.Event;
import starling.core.Starling;
import starling.display.Image;
import starling.display.DisplayObject;
import starling.events.KeyboardEvent;
import flash.ui.Keyboard;

class Root extends Sprite {

	public static var assets:AssetManager;
	public var game:Game;

	public function new() {
		super();
	}

	public function start(startup:Startup) {

		assets = new AssetManager();
		assets.enqueue("assets/startbutton.png");
		assets.enqueue("assets/continueButton.png");
		assets.enqueue("assets/tutorialbutton.png");
		assets.enqueue("assets/credits.png");
		assets.enqueue("assets/backbutton.png");
		assets.enqueue("assets/background.png");
		assets.enqueue("assets/creditsbutton.png");
		assets.enqueue("assets/menu.png");
		assets.enqueue("assets/menubutton.png");
		assets.enqueue("assets/menuselect.mp3");
		assets.enqueue("assets/tutorialBackground.png");

		assets.loadQueue(function onProgress(ratio:Float) {
			
            if (ratio == 1) {

                Starling.juggler.tween(startup.loadingBitmap, 2.0, {
                    transition: Transitions.EASE_OUT,
                        delay: 1.0,
                        alpha: 0,
                        onComplete: function() {
                        	startup.removeChild(startup.loadingBitmap);
                        	addMenu();
                        	addEventListener(Event.TRIGGERED, menuButtonClicked);
               			}

                });
            }

        });
	}

	public function addMenu() {
		var menu = new Menu();
		menu.alpha = 0;
		addChild(menu);
		//Tween in menu
		Starling.juggler.tween(menu, 0.25, {
                    transition: Transitions.EASE_IN,
                        delay: 0.0,
                        alpha: 1.0
        });
	}

	public function menuButtonClicked(event:Event) {
		var button = cast(event.target, Button);
		var menuSelect:SoundChannel = Root.assets.playSound("menuselect");
		menuSelect;
		if(button.name == "start") {
			startGame();
		} 
		else if(button.name == "tutorial") {
			showTutorial();
		 }
		else if(button.name == "credits") {
			showCredits();
		} 
		else if(button.name == "next") {
		 	Starling.current.stage.removeEventListeners();
		 	Starling.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, flip);
			game.nextLevel(5);
			removeChildAt(1);
		} 
		else if(button.name == "back") {
			Starling.juggler.tween(getChildAt(0), .25, {
                    transition: Transitions.EASE_OUT,
                        delay: 0.0,
                        alpha: 0.0,
                        onComplete: function() {
                        	removeChildAt(0);
        					}
        
        	});
			addMenu();
		}
		else if(button.name == "return"){
        	removeChildren();
        	addMenu();
        }
	}

	public function startGame() {
		//Tween out menu
		Starling.juggler.tween(getChildAt(0), 0.25, {
                    transition: Transitions.EASE_OUT,
                        delay: 0.0,
                        alpha: 0.0,
                        onComplete: function() {
                        	removeChildAt(0);
                        }
        });
		removeEventListeners();
		game = new Game(5);
		addChild(game);
		Starling.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, flip);
	}

	public function movement(event:KeyboardEvent) {
	    if (event.keyCode == Keyboard.LEFT) {
	    	player.x -= 10; //placeholder
	    }
	    else if(event.keyCode == Keyboard.RIGHT) {
	    	player.x += 10; //placeholder
	    }
	    else if(event.keyCode == Keyboard.UP) {
	    	player.y -= 10; //placeholder
	    }
	    else if(event.keyCode == Keyboard.DOWN) {
	    	player.y += 10; //placeholder
	    }
	    if(player.x <= 0){
	    	player.x = 0;  //placeholder
	    }
	    else if(player.x >= stage.stageWidth){
	    	player.x = stage.stageWidth;
	    }
	    else if(player.y <= 0){
	    	player.y = 0;  //placeholder
	    }
	    else if(player.y >= stage.stageHeight){
	    	player.y = stage.stageHeight; //placeholder
	    }
	    for(child in children){ //pseudo-code, will check items on stage and see if they intersect with the player, then will prompt the player for action based on the item.
	    	var bound1 = player.bounds;
	    	var bound2 = child.bounds;
	    	if bound1.intersects(bound2){
	    		if (child == "berrybush")
	    	}
	    }
	}

	public function continueScreen() {
		Starling.current.stage.removeEventListeners();
		var continueScreen = new ContinueScreen();
		continueScreen.alpha = 0;
		addChild(continueScreen);
		//Tween in continue screen
		Starling.juggler.tween(continueScreen, 0.25, {
                    transition: Transitions.EASE_IN,
                        delay: .25,
                        alpha: 1.0
        });
        addEventListener(Event.TRIGGERED, menuButtonClicked);
	}


	public function showTutorial() {
		//Tween out the menu
		Starling.juggler.tween(getChildAt(0), 0.25, {
                    transition: Transitions.EASE_OUT,
                        delay: 0.0,
                        alpha: 0.0,
                        onComplete: function() {
                        	removeChildAt(0);
                        }
        });
		var tutorial = new Tutorial();
		tutorial.alpha = 0;
		addChild(tutorial);
		//Tween in tutorial screen
		Starling.juggler.tween(tutorial, 0.25, {
                    transition: Transitions.EASE_IN,
                        delay: .25,
                        alpha: 1.0
        });
	}

	public function showCredits() {
		//Tween out the menu
		Starling.juggler.tween(getChildAt(0), 0.25, {
                    transition: Transitions.EASE_OUT,
                        delay: 0.0,
                        alpha: 0.0,
                        onComplete: function() {
                        	removeChildAt(0);
                        }
        });
		var credits = new Credits();
		credits.alpha = 0;
		addChild(credits);
		//Tween in tutorial screen
		Starling.juggler.tween(credits, 0.25, {
                    transition: Transitions.EASE_IN,
                        delay: .25,
                        alpha: 1.0
        });
	}
}

class Menu extends Sprite {

	public var background:Image;
	public var startButton:Button;
	public var tutorialButton:Button;
	public var creditsButton:Button;

	public function new() {
		super();

		var menu = new Image(Root.assets.getTexture("menu"));
		addChild(menu);

		startButton = new Button(Root.assets.getTexture("startbutton"));
		startButton.name = "start";
		startButton.x = 250;
		startButton.y = 200;
		this.addChild(startButton);

		tutorialButton = new Button(Root.assets.getTexture("tutorialbutton"));
		tutorialButton.x = 250;
		tutorialButton.y = 300;
		tutorialButton.name = "tutorial";
		this.addChild(tutorialButton);

		creditsButton = new Button(Root.assets.getTexture("creditsbutton"));
		creditsButton.x = 250;
		creditsButton.y = 400;
		creditsButton.name = "credits";
		this.addChild(creditsButton);
`	}
}

class ContinueScreen extends Sprite {
	public var background:Image;
	public var nextButton: Button;

	public function  new() {
		super();

		background = new Image(Root.assets.getTexture("continue"));
		addChild(background);

		nextButton = new Button(Root.assets.getTexture("continueButton"));
		nextButton.name = "next";
		nextButton.x = 250;
		nextButton.y = 300;
		this.addChild(nextButton);
	}
}

class Tutorial extends Sprite {

	public var background:Image;
	public var backButton:Button;
	public var tutorialBackground:Image;

	public function new() {
		super();

		backButton = new Button(Root.assets.getTexture("backbutton"));
		backButton.name = "back";
		tutorialBackground = new Image(Root.assets.getTexture("tutorialBackground"));
		addChild(tutorialBackground);
		this.addChild(backButton);

		backButton.x = 50;
		backButton.y = 520;
	}
}

class Credits extends Sprite {

	public var background:Image;
	public var backButton:Button;
	public var creditsBackground:Image;

	public function new() {
		super();

		backButton = new Button(Root.assets.getTexture("backbutton"));
		backButton.name = "back";
		creditsBackground = new Image(Root.assets.getTexture("credits"));
		addChild(creditsBackground);
		this.addChild(backButton);

		backButton.x = 50;
		backButton.y = 520;
	}
}

class GameOver extends Sprite {
	public var background:Image;
	public var returnButton:Button;

	public function new() {
		super();
		background = new Image(Root.assets.getTexture("gameover"));
		addChild(background);
		returnButton = new Button(Root.assets.getTexture("menubutton"));
		returnButton.x = 250;
		returnButton.y = 300;
		returnButton.name = "return";
		addChild(returnButton);
	}
}