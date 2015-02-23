import starling.display.Sprite;
import starling.utils.AssetManager;
import starling.display.Button;
import starling.animation.Transitions;
import starling.events.Event;
import starling.core.Starling;
import starling.display.Image;
import starling.display.DisplayObject;
import starling.events.Event;
import starling.events.KeyboardEvent;
import flash.ui.Keyboard;

class Encounter extends Sprite {

	var image:Image;
	var background:Image;
	var text:String;
	var options:Array<String>;

	public function new(texture:String, backgroundImage:String, textString:String, x:Int, y:Int) {
		super();

		image = new Image(Root.assets.getTexture(texture));
		image.x = x;
		image.y = y;
		addChild(image);

		//background = new Image(Root.assets.getTexture(backgroundImage));
		text = textString;

		Starling.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, activateEncounter);
	}

	public function activateEncounter(event:KeyboardEvent) {

	}
}