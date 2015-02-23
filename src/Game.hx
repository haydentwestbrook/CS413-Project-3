import starling.display.Sprite;
import starling.utils.AssetManager;
import starling.display.Button;
import starling.animation.Transitions;
import starling.events.Event;
import starling.core.Starling;
import starling.display.Image;
import starling.display.DisplayObject;
import flash.ui.Keyboard;

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
	}
}