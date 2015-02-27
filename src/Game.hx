import starling.display.Sprite;
import starling.utils.AssetManager;
import starling.display.Button;
import starling.animation.Transitions;
import starling.events.Event;
import starling.core.Starling;
import starling.display.Image;
import starling.display.DisplayObject;
import flash.ui.Keyboard;
import starling.events.KeyboardEvent;
import starling.text.TextField;
import starling.utils.HAlign;
import flash.media.SoundChannel;
import flash.media.Sound;
import flash.media.SoundMixer;
import Root;

class Game extends Sprite {

	public var player:Player;
	public var playerHealth:TextField;
	public var playerInventory:TextField;
	public var encounters:Array<Encounter>;

	public function new() {
		super();

		var background:Image = new Image(Root.assets.getTexture("background"));
		addChild(background);
		
		
		var ambience:Sound = Root.assets.getSound("ambience");
		var soundChannel:SoundChannel;
		soundChannel  = ambience.play(0,9999);
		
		//var fire:SoundChannel = Root.assets.playSound("firecrackle");
			//fire;
		//Add player
		player = new Player();	
		addChild(player);


		//Add encounters
		encounters = new Array<Encounter>();
		encounters.push(new Encounter("river", "You found a river!", ["Drink water", "Walk away"], 1, 
									  "Good job! Stagnant water should be treated before drinking.",
									  "Oh no! Stagnant water is the perfect breeding ground for bacteria and parasites, which can lead to serious sickness!",
									  "","", 0, 0, player, "Fill canteen", "canteen", 1, 3, ""));

		encounters.push(new Encounter("canteen", "You found a canteen!", ["Eat the Canteen", "Pickup the Canteen"], 1, 
									  "Good job! Now you can fill the canteen with fresh water. Make sure your water source is not stagnant",
									  "Food might be in limited supply, but you shouldn't eat the canteen",
									  "","", 200, 75, player, "test", "test", 1, 3, "canteen"));

		encounters.push(new Encounter("berrybush", "Its a berry bush! You are unable to idenitify the type of berries it has. What do you do?", ["Eat the berries", "Leave them alone"], 1, 
									  "Good Job! You should never eat something you are unable identify.", 
									  "Oh no! The berries are poisonous! You should never eat anything you can not identify.", 
									  "", "", 640, 300, player, "test", "test", 1, 3, ""));

		encounters.push(new Encounter("bear", "Its a bear!", ["Fight!", "Run", "Play dead"], 2, 
									  "Good Job!", "Oh no! The bear ate you. \n\n Grizzly Bears can run up to 30 mph. (Bring a slow friend).",
									  "", "", 500, 500, player, "test", "test", 100, 101, ""));
		
		encounters.push(new Encounter("log", "You found a log!", ["Build a Fire", "Eat the Log"], 0, 
									  "Good Job! Hardwoods, like Aspen, burn longer and hotter than softer woods.",
									  "You shouldn't eat the log. Wood is hard to digest",
									  "fire","", 1000, 30, player, "test", "test", 1, 4, ""));

		//Add encounters to stage
		for (encounter in encounters) {
			addChild(encounter);
		}

		//Add player health
		playerHealth = new TextField(80, 50, "Health: " + player.health);
		addChild(playerHealth);

		//Display inventory
		playerInventory = new TextField(1000, 50, "Inventory: " + player.displayInv());
		playerInventory.hAlign = starling.utils.HAlign.LEFT;
		playerInventory.x = 80;
		addChild(playerInventory);

		Starling.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, movement);
	}

	public function movement(event:KeyboardEvent) {
		var oldX = player.x;
		var oldY = player.y;
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
	    else if((player.x + player.width) >= stage.stageWidth){
	    	player.x = oldX;
	    }
	    if(player.y <= 0){
	    	player.y = 0;  //placeholder
	    }
	    else if((player.y + player.height)>= stage.stageHeight){
	    	player.y = oldY; //placeholder
	    }
	    for(encounter in encounters){ //pseudo-code, will check items on stage and see if they intersect with the player, then will prompt the player for action based on the item.
	    	var bound1 = player.bounds;
	    	var bound2 = encounter.bounds;
	    	if (bound1.intersects(bound2)){
	    		player.x = oldX;
	    		player.y = oldY;
	    		encounter.activateEncounter();
	    	}
	    }
	}

	public function updatePlayerInfo() {
		playerHealth.text = "Health: " + player.health;
		playerInventory.text = "Inventory: " + player.displayInv();
	}
}