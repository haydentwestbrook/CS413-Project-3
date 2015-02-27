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
import starling.text.BitmapFont;
import flash.media.SoundChannel;
import flash.media.Sound;
import flash.media.SoundMixer;
import Root;
import Root.GameOver;

class Encounter extends Sprite {

	public var image:Image;
	public var dialogBox:DialogBox;
	public var visited:Bool;
	public var thisTexture:String;
	public function new(texture:String, textString:String, options:Array<String>, rightAnswer:Int, rightText:String, wrongText:String, 
						rightTexture:String, wrongTexture:String, x:Int, y:Int, player:Player, bonusOption:String, reqItem:String, 
						maxHealthLoss:Int, minHealthLoss:Int, addedItem:String) {
		super();

		image = new Image(Root.assets.getTexture(texture));
		thisTexture = texture;
		image.x = x;
		image.y = y;
		addChild(image);
		dialogBox = new DialogBox(textString, options, rightAnswer, rightText, wrongText, rightTexture, wrongTexture, 
								  bonusOption, reqItem, maxHealthLoss, minHealthLoss, addedItem, player);
		

		//Starling.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, activateEncounter);
	}

	public function activateEncounter() {
		if(!visited) {
			dialogBox.activateDialog();
			addChild(dialogBox);
			if (this.thisTexture == "bear") {
				var beargrowl:SoundChannel = Root.assets.playSound("beargrowlshort");
			}
			Starling.current.stage.removeEventListeners();
			Starling.current.stage.addEventListener(Event.TRIGGERED, dialogBox.buttonHandler);
		}
	}

	public function deactivateEncounter() {
		visited = true;
		removeChild(dialogBox);
		Starling.current.stage.removeEventListeners();
		Starling.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, cast (this.parent, Game).movement);

		cast(this.parent, Game).updatePlayerInfo();

		var winSituation = true;
		for(encounter in cast(this.parent, Game).encounters) {
			if(!encounter.visited){
		    		winSituation = false;
		    	}
		}
		if(winSituation){
		    var gameOver = new GameOver(true, this);
		}
	    if(cast(this.parent, Game).player.health <=0){
	    	var gameOver = new GameOver(false, this);
	    }

	}
}

class DialogBox extends Sprite {

	var background:Image;
	var text:TextField;
	var options:Array<String>;
	var rightAnswer:Int;
	var buttons:Array<Button>;
	var closeButton:Button;
	var rightText:String;
	var wrongText:String;
	var rightTexture:String;
	var wrongTexture:String;
	var reqItem:String;
	var bonusOption:String;
	var minHealthLoss:Int;
	var maxHealthLoss:Int;
	var addedItem:String;
	var player:Player;
	var optionsLength:Int;

	public function new(textString:String, options:Array<String>, rightAnswer:Int, rightText:String, wrongText:String, 
						rightTexture:String, wrongTexture:String, bonusOption:String, reqItem:String,
						maxHealthLoss:Int, minHealthLoss:Int, addedItem:String, player:Player) {
		super();
		this.rightAnswer = rightAnswer;
		this.rightText = rightText;
		this.wrongText = wrongText;
		this.rightTexture = rightTexture;
		this.wrongTexture = wrongTexture;
		this.reqItem = reqItem;
		this.bonusOption = bonusOption;
		this.minHealthLoss = minHealthLoss;
		this.maxHealthLoss = maxHealthLoss;
		this.addedItem = addedItem;
		this.player = player;
		this.optionsLength = options.length;
		this.options = options;

		background = new Image(Root.assets.getTexture("encounterScreen"));
		addChild(background);
		

		text = new TextField(250, 600, textString, "font", 18, 0xFFFFFF);
		text.hAlign = starling.utils.HAlign.LEFT;
		text.vAlign = starling.utils.VAlign.TOP;
<<<<<<< HEAD
		text.fontSize = 14
		;
=======
>>>>>>> 07741d4c23ed0420db720d5b14a0dd7c6c3396c1
		text.x = 350;
		text.y = 40;
		addChild(text);
	}	

	public function buttonHandler(event:Event) {
		var buttonEvent = cast(event.target, Button);

		if(buttonEvent.name == "close") {
			cast(this.parent, Encounter).deactivateEncounter();
		}

		var i = 0;
		for(button in buttons) {
			if(button == buttonEvent && (i == rightAnswer || i == optionsLength)) {
				if(i == optionsLength) {
					player.inventory.remove(reqItem);
				}
				success();
			} else if(button == buttonEvent && i != rightAnswer) {
				fail();
			}
			i++;
		}
	}

	public function activateDialog() {
		buttons = new Array<Button>();
		var y = 40;
		
		for(item in player.inventory){
			if(item == reqItem){
				options.push(bonusOption);
			}
		}

		for(option in options) {
			var optionText = new TextField(250, 400, option, "font", 18, 0xFFFFFF);
			optionText.hAlign = starling.utils.HAlign.LEFT;
			optionText.vAlign = starling.utils.VAlign.TOP;
			optionText.x = 90;
			optionText.y = y;
			addChild(optionText);

			var button = new Button(Root.assets.getTexture("optionbutton"));
			button.x = 50;
			button.y = y;
			buttons.push(button);
			addChild(button);
			y += 75;
		}
	}

	public function success() {
		text.text = rightText;
		var x = cast(parent,Encounter).image.x;
		var y = cast(parent,Encounter).image.y;
		parent.removeChild(cast(parent, Encounter).image);
		if(rightTexture != "") {
			var image = new Image(Root.assets.getTexture(rightTexture));
			image.x = x;
			image.y = y;
			cast (parent, Encounter).addChild(image);
		}

		closeButton = new Button(Root.assets.getTexture("closebutton"));
		closeButton.x = 350;
		closeButton.y = 200;
		closeButton.name = "close";
		addChild(closeButton);

		if(addedItem != "") {
			player.inventory.push(addedItem);
		}
	}

	public function fail() {
		if(maxHealthLoss > 0) {
			var rand = Std.random(maxHealthLoss);
			if(rand < minHealthLoss) {
				rand = minHealthLoss;
			}
			cast (this.parent.parent, Game).player.health -= rand;
		}


		text.text = wrongText;
		var x = cast(parent,Encounter).image.x;
		var y = cast(parent,Encounter).image.y;
		parent.removeChild(cast(parent, Encounter).image);
		if(wrongTexture != "") {
			var image = new Image(Root.assets.getTexture(wrongTexture));
			image.x = x;
			image.y = y;
			cast (parent, Encounter).addChild(image);
		}

		closeButton = new Button(Root.assets.getTexture("closebutton"));
		closeButton.x = 350;
		closeButton.y = 200;
		closeButton.name = "close";
		addChild(closeButton);
	}
}