import starling.text.TextField;
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
	var dialogBox:DialogBox;
	var visited:Bool;

	public function new(texture:String, textString:String, options:Array<String>, rightAnswer:Int, x:Int, y:Int) {
		super();

		image = new Image(Root.assets.getTexture(texture));
		image.x = x;
		image.y = y;
		addChild(image);

		dialogBox = new DialogBox(textString, options, rightAnswer);
		

		//Starling.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, activateEncounter);
	}

	public function activateEncounter() {
		if(!visited) {
			addChild(dialogBox);
			Starling.current.stage.removeEventListeners();
			Starling.current.stage.addEventListener(Event.TRIGGERED, dialogBox.buttonHandler);
		}
	}

	public function deactivateEncounter() {
		visited = true;
		removeChild(dialogBox);
		Starling.current.stage.removeEventListeners();
		Starling.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, cast (this.parent, Game).movement);
	}
}

class DialogBox extends Sprite {

	var background:Image;
	var text:TextField;
	var options:Array<String>;
	var rightAnswer:Int;
	var buttons:Array<Button>;
	var closeButton:Button;

	public function new(textString:String, options:Array<String>, rightAnswer:Int) {
		super();

		trace(rightAnswer);

		background = new Image(Root.assets.getTexture("encounterScreen"));
		addChild(background);
		

		text = new TextField(200, 50, textString);
		text.hAlign = starling.utils.HAlign.LEFT;
		text.fontSize = 14;
		text.x = 225;
		text.y = 10;
		addChild(text);

		buttons = new Array<Button>();
		var y = 40;
		for(option in options) {
			var optionText = new TextField(100, 30, option);
			optionText.fontSize = 14;
			optionText.x = 75;
			optionText.y = y;
			addChild(optionText);

			var button = new Button(Root.assets.getTexture("optionbutton"));
			button.x = 50;
			button.y = y;
			buttons.push(button);
			addChild(button);
			y += 50;
		}
	}	

	public function buttonHandler(event:Event) {
		var buttonEvent = cast(event.target, Button);

		if(buttonEvent.name == "close") {
			cast(this.parent, Encounter).deactivateEncounter();
		}

		var i = 0;
		for(button in buttons) {
			if(button == buttonEvent && i == rightAnswer) {
				success();
			} else {
				fail();
			}
			i++;
		}
	}

	public function success() {
		text.text = "Good job!";

		closeButton = new Button(Root.assets.getTexture("closebutton"));
		closeButton.x = 225;
		closeButton.y = 200;
		closeButton.name = "close";
		addChild(closeButton);
	}

	public function fail() {
		text.text = "Wrong answer!";

		closeButton = new Button(Root.assets.getTexture("closebutton"));
		closeButton.x = 225;
		closeButton.y = 200;
		closeButton.name = "close";
		addChild(closeButton);
	}
}