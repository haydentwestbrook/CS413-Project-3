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
import starling.text.TextField;
import starling.text.BitmapFont;
import starling.textures.Texture;
import flash.xml.XML;
import flash.ui.Keyboard;

class Root extends Sprite {

	public static var assets:AssetManager;
	public var game:Game;
	public var player:Player;

	public function new() {
		super();
	}

	public function start(startup:Startup) {

		assets = new AssetManager();
		assets.enqueue("assets/assets0.png");
		assets.enqueue("assets/assets0.xml");
		assets.enqueue("assets/assets1.png");
		assets.enqueue("assets/assets1.xml");
		assets.enqueue("assets/assets2.png");
		assets.enqueue("assets/assets2.xml");
		assets.enqueue("assets/assets3.png");
		assets.enqueue("assets/assets3.xml");
		
		assets.enqueue("assets/ambience.mp3");
		assets.enqueue("assets/beargrowlshort.mp3");
		assets.enqueue("assets/firecrackle.mp3");
		
		assets.enqueue("assets/font.png");
		assets.enqueue("assets/font.fnt");

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
		game = new Game();
		addChild(game);
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

		startButton.x = 575;
		startButton.y = 300;
		this.addChild(startButton);

		tutorialButton = new Button(Root.assets.getTexture("tutorialbutton"));
		tutorialButton.x = 575;
		tutorialButton.y = 400;

		startButton.x = 590;
		startButton.y = 400;
		this.addChild(startButton);

		tutorialButton = new Button(Root.assets.getTexture("tutorialbutton"));
		tutorialButton.x = 590;
		tutorialButton.y = 500;

		tutorialButton.name = "tutorial";
		this.addChild(tutorialButton);

		creditsButton = new Button(Root.assets.getTexture("creditsbutton"));

		creditsButton.x = 575;
		creditsButton.y = 500;

		creditsButton.x = 590;
		creditsButton.y = 600;

		creditsButton.name = "credits";
		this.addChild(creditsButton);
	}
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
		backButton.y = 600;
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

		backButton.x = 80;
		backButton.y = 590;
	}
}

class GameOver extends Sprite {
	public var background:Image;
	public var returnButton:Button;

	public function new(win:Bool, encounter:Encounter) {
		super();

		Starling.current.stage.removeEventListeners();
		var root:Root = cast (encounter.parent.parent, Root);
		root.removeChildren();
		root.addChild(this);

		var background:Image;
		var returnButton:Button;
		if(win) {
			background = new Image(Root.assets.getTexture("win"));
			returnButton = new Button(Root.assets.getTexture("menubutton"));
			returnButton.x = 580;
			returnButton.y = 625;
			returnButton.name = "return";
			root.addChild(returnButton);
			flash.media.SoundMixer.stopAll();
		} else {
			background = new Image(Root.assets.getTexture("gameover"));
			returnButton = new Button(Root.assets.getTexture("menubutton"));
			returnButton.x = 580;
			returnButton.y = 625;
			returnButton.name = "return";
			flash.media.SoundMixer.stopAll();
		}
		root.addChild(background);
		root.addChild(returnButton);

		root.addEventListener(Event.TRIGGERED, root.menuButtonClicked);

		/*var returnButton = new Button(Root.assets.getTexture("menubutton"));
		returnButton.x = 580;
		returnButton.y = 625;
		returnButton.name = "return";
		root.addChild(returnButton);

*/
	}
}