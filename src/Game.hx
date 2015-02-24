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
import Root;

class Game extends Sprite {

	var player:Player;
	var encounters:Array<Encounter>;

	public function new() {
		super();

		//Add player
		player = new Player();	
		addChild(player);

		//Add encounters
		encounters = new Array<Encounter>();
		encounters.push(new Encounter("berrybush", "", "Its a berry bush!", 200, 300));
		//Add encounters to stage
		for(encounter in encounters) {
			addChild(encounter);
		}
		Starling.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, movement);
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
	    else if((player.x + player.width) >= stage.stageWidth){
	    	player.x = stage.stageWidth - player.width;
	    }
	    if(player.y <= 0){
	    	player.y = 0;  //placeholder
	    }
	    else if((player.y + player.height)>= stage.stageHeight){
	    	player.y = stage.stageHeight - player.height; //placeholder
	    }
	    for(encounter in encounters){ //pseudo-code, will check items on stage and see if they intersect with the player, then will prompt the player for action based on the item.
	    	var bound1 = player.bounds;
	    	var bound2 = encounter.bounds;
	    	if (bound1.intersects(bound2)){
	    		trace("Contact");
	    	}
	    }
	}
	
}