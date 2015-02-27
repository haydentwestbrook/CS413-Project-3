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

		encounters.push(new Encounter("log", "You found a log!", ["Build a Fire", "Eat the Log"], 0, 
									  "Good Job! Hardwoods, like Aspen, burn longer and hotter than softer woods.",
									  "You shouldn't eat the log. Wood is hard to digest",
									  "fire","", 500, 550, player, "test", "test", 1, 4, ""));

		encounters.push(new Encounter("preTent", "You found a tent!", ["Assemble Tent", "Leave Tent"], 0, 
									  "Nice work! Now you have a safe shelter from the weather, and bugs.",
									  "You really want to leave a perfectly good tent? Did you know there are over 3,500 species of mosquitos? Suit yourself.",
									  "tent","", 800, 40, player, "test", "test", 1, 4, ""));

		encounters.push(new Encounter("canteen", "You found a canteen!", ["Eat the Canteen", "Pickup the Canteen"], 1, 
							  		  "Good job! Now you can fill the canteen with fresh water. Make sure your water source is not stagnant",
							  		  "Food might be in limited supply, but you shouldn't eat the canteen",
							 	 	  "","", 200, 300, player, "test", "test", 1, 3, "canteen"));

		encounters.push(new Encounter("berrybush", "Its a berry bush! You are unable to idenitify the type of berries it has. What do you do?", ["Eat the berries", "Leave them alone"], 1, 
									  "Good Job! You should never eat something you are unable identify.", 
									  "Oh no! The berries are poisonous! You should never eat anything you can not identify.", 
									  "berrybush", "berrybush", 700, 350, player, "test", "test", 1, 3, ""));
		var rand = Std.random(2);
		if(rand == 0) {
			encounters.push(new Encounter("bear", "Look out! Its a grizzly bear and its going to attack you! What should you do?", ["Stand your ground and make yourself bigger. Acting tough will drive it away.", "Run away!", "Stay calm, back away slowly and don't make eye contact."], 2, 
										  "Good Job! If you encounter a grizzly bear, you should try to not get close and show you are not a threat. Bear spray is also important as it has has been shown to be about 92 percent effective at deterring bears.", "Oh no! The bear attacked you! \n\n Grizzly bears often see eye contact as an act of aggression, so acting tough will only provoke them. Also never try to out run a grizzly bear, they can run up to 30 mph. (Bring a slow friend).",
										  "", "", 950, 550, player, "test", "test", 100, 101, ""));
		} else {
			encounters.push(new Encounter("blackbear", "Look out! Its a black bear and its going to attack you! What should you do?", ["Stand your ground and make yourself bigger. Acting tough will drive it away.", "Run away!", "Offer the bear food."], 0, 
										  "Good Job! Making yourself appear bigger than you are by waving your arms and making a lot of noise can scare the bear off. Bear spray is also important has has been shown to be about 92 percent effective at deterring bears.", "Oh no! The bear attacked you! \n\n Black bears are less fearsome than grizzly bears and can be scared off. But don't try to out run bears, they are too fast and it will only provoke them. Also never let them smell food on you as this can cause them to attack.",
										  "", "", 950, 550, player, "test", "test", 100, 101, ""));
		}
	

		encounters.push(new Encounter("snake", "Its a snake! If you are ever bitten by a poisonous snake, what should you do?", ["Suck out the venom.", "Apply ice to the bite.", "Do not overly exert yourself and try to seek medical attention."], 2, 
									  "Nice work! Only trained medical professionals are going to be able to effectively treat a snake bite.",
									  "Trying the suck the venom out has no positive effect on a snake bite. Ice also has no effect and can cause more harm than good. The best option is to not exert yourself and attempt to get medical attention.",
									  "","", 1200, 230, player, "test", "test", 4, 8, ""));

		//Add encounters to stage
		for (encounter in encounters) {
			addChild(encounter);
		}

		//Add player health
		playerHealth = new TextField(120, 50, "Health: " + player.health, "font", 24, 0xFFFFFF);
		addChild(playerHealth);

		//Display inventory
		playerInventory = new TextField(1000, 50, "Inventory: " + player.displayInv(), "font", 24, 0xFFFFFF);
		playerInventory.hAlign = starling.utils.HAlign.LEFT;
		playerInventory.x = 120;
		addChild(playerInventory);

		Starling.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, movement);
	}

	public function movement(event:KeyboardEvent) {
		var oldX = player.x;
		var oldY = player.y;
	    if (event.keyCode == Keyboard.LEFT) {
	    	player.x -= 20; //placeholder
	    }
	    else if(event.keyCode == Keyboard.RIGHT) {
	    	player.x += 20; //placeholder
	    }
	    else if(event.keyCode == Keyboard.UP) {
	    	player.y -= 20; //placeholder
	    }
	    else if(event.keyCode == Keyboard.DOWN) {
	    	player.y += 20; //placeholder
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